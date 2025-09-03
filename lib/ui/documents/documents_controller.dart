import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:ipbot_app/Utils/tools.dart';
import 'package:ipbot_app/repo/auth_repo.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http_auth/http_auth.dart';
import '../../repo/setting_repo.dart';
import 'm/document_response.dart';

class DocumentsController extends GetxController {
  RxBool isLoading = false.obs;
  RefreshController refreshController = RefreshController(initialRefresh: false);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxList<PlatformFile> files = RxList();
  String? pageType = "A4";
  String? printType = "Black & White";
  String? noOfCopies = "1";
  String? transactionsId;
  RxString amount = RxString("0");
  String? amountPerPage;
  Rx<DocumentResponse?> response = Rx(null);
  RxList<Data> list = RxList([]);
  List<int> pageCount = [];

  final Razorpay _razorpay = Razorpay();

  @override
  void onInit() {
    super.onInit();
    onList();
    getAmount();
    initPaymentGateway();
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void getAmount() {
    print("Fetching amount for printType: $printType");
    if (printType == "Color") {
      getAmountPerPageColor().then((value) {
        amountPerPage = value.data;
        print("amountPerPageColor: $amountPerPage");
        getTotalAmount(); // Call getTotalAmount after setting amountPerPage
      }).catchError((e) {
        print("Error fetching amountPerPageColor: $e");
        amountPerPage = "0"; // Fallback value
        getTotalAmount();
      });
    } else {
      getAmountPerPage().then((value) {
        amountPerPage = value.data;
        print("amountPerPage: $amountPerPage");
        getTotalAmount(); // Call getTotalAmount after setting amountPerPage
      }).catchError((e) {
        print("Error fetching amountPerPage: $e");
        amountPerPage = "0"; // Fallback value
        getTotalAmount();
      });
    }
  }

  void onAddDocument() {
    if (formKey.currentState!.validate()) {
      if (files.isEmpty) {
        Tools.ShowErrorMessage('Please upload files');
        return;
      }
      isLoading.value = true;
      // formDataToSend.fields.addAll([
      //   MapEntry('page_type', pageType ?? 'A4'),
      //   MapEntry('print_type', printType ?? 'Color'),
      //   MapEntry('no_of_copies', noOfCopies ?? '2'),
      //   MapEntry('transactions_id', transactionsId.value ),
      //   MapEntry('amount', amount.value),
      //   MapEntry('otp', (1000 + (Random().nextDouble() * 9000).floor()).toString()),
      //   MapEntry('user_id', auth.value.id?.toString() ?? '1'),
      // ]);
      Map<String, dynamic> map = {};
      map['page_type'] = pageType;
      map['print_type'] = printType;
      map['no_of_copies'] = noOfCopies;
      map['transactions_id'] = transactionsId;
      map['amount'] = amount.value;
      map['otp'] = generateOtp();
      map['user_id'] = auth.value.id?.toString();
      dio.FormData data = dio.FormData.fromMap(map);

      data.files.add(MapEntry(
        "file",
        dio.MultipartFile.fromFileSync(
          files.first.path!,
          filename: files.first.name,
        ),
      ));

      addDocument(data).then((value) {
        isLoading.value = false;
        if (value.success!) {
          onList();
          Tools.ShowSuccessMessage(value.message ?? "");
          clearData();
          Get.back();
          Get.back();
        } else {
          Tools.ShowErrorMessage(value.message ?? "");
        }
      }).catchError((e) {
        isLoading.value = false;
      });
    }
  }



  String generateOtp() {
    var rnd = Random();
    var next = rnd.nextDouble() * 1000000;

    while (next < 100000) {
      next *= 10;
    }
    print('otp==>${next.toInt()}');
    return next.toInt().toString();
  }

  void clearData() {
    pageType = "A4";
    printType = "Color";
    noOfCopies = "1";
    transactionsId = null;
    amount = RxString("0");
    files.value = [];
    pageCount.clear();
  }

  void onList() {
    getDocument({"user_id": auth.value.id.toString()}).then((value) {
      response.value = value;
      if (value.data != null && value.data!.isNotEmpty) {
        list.value = value.data!.reversed.toList();
        refreshController.refreshCompleted();
      } else {
        refreshController.loadFailed();
        Tools.ShowErrorMessage("No documents found");
      }
    }).catchError((e) {
      print("Error fetching documents: $e");
      refreshController.loadFailed();
      Tools.ShowErrorMessage("Failed to load documents. Please try again.");
    });
  }


  void onDeleteItem(Data data) {
    list.remove(data);
    deleteDocument(data.id).then((value) {
      Tools.ShowSuccessMessage(value.message ?? "");
    });
  }

  void getTotalAmount() {
    double pdfAmount = 0;
    double copy = double.parse(noOfCopies!);
    double pageAmount = double.parse(amountPerPage!);
    for (var element in pageCount) {
      pdfAmount = pdfAmount + (element * copy * pageAmount);
    }
    amount.value = (pdfAmount).toString();
  }


  void initPaymentGateway() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  Future<void> payAmount() async {
    double amt = double.parse(amount.value) * 100;
    String? id = await createOrder(amt);
    var options = {
      'key': 'rzp_live_hzmhxKLtnWFjhB',
      'order_id': id,
      'amount': amt,
      'name': '${auth.value.name}',
      'description': 'Print Document',
      'prefill': {
        'contact': '${auth.value.mobile}',
        'email': '${auth.value.email}'
      }
    };
    if (id != null) {
      _razorpay.open(options);
    } else {
      Tools.ShowErrorMessage("Order not created");
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Tools.ShowSuccessMessage("Payment success");
    transactionsId = response.paymentId;
    onAddDocument();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Tools.ShowErrorMessage("${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {}

  Future<String?> createOrder(amt) async {
    String orderID = "rec_${DateTime.now().millisecond}";
    final Map<String, dynamic> body = {
      "amount": amt,
      "currency": "INR",
      "receipt": orderID,
      "partial_payment": true,
      "first_payment_min_amount": 1,
    };
    var credentials =
        BasicAuthClient('rzp_live_hzmhxKLtnWFjhB', 'GZL6YqyRjvc9osRzpKThEv22');
    var response = await credentials.post(
      Uri.parse('https://api.razorpay.com/v1/orders'),
      headers: {"Authorization": credentials.toString()},
      body: jsonEncode(body),
    );

    print("credentials==>${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Order Created: ${response.body}");
      return jsonDecode(response.body)['id'];
    } else {
      print("Error: ${response.body}");
      return null;
    }
  }
}
