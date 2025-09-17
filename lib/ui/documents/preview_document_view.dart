import 'dart:io';

import 'package:docx_to_text/docx_to_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:ipbot_app/ui/widgets/sub_txt_widget.dart';
import '../../Constant/color_const.dart';
import '../widgets/button_primary_widget.dart';
import '../widgets/header_txt_widget.dart';
import 'documents_controller.dart';

class PreviewDocumentView extends StatefulWidget {
  const PreviewDocumentView({super.key});

  @override
  State<PreviewDocumentView> createState() => _LoginPageState();
}

class _LoginPageState extends State<PreviewDocumentView> {
  final DocumentsController _con = Get.put(DocumentsController());

  @override
  void initState() {
    super.initState();
    _con.pageCount.clear();
    for (var element in _con.files) {
      _con.pageCount.add(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        title: HeaderTxtWidget('Preview Document'),
        backgroundColor: scaffoldBackgroundColor,
      ),
      body: Obx(
            () => Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SubTxtWidget(
                        'Paper size :',
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: SubTxtWidget('${_con.pageType}'),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SubTxtWidget(
                        'Print Type :',
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: SubTxtWidget('${_con.printType}'),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SubTxtWidget(
                        'No Of Copies :',
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: SubTxtWidget('${_con.noOfCopies}'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SubTxtWidget(
                        'Total Amount :',
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: SubTxtWidget('₹ ${_con.amount.value}'),
                    ),
                  ],
                ),
                ListView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                      height: 350,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                      ),
                      child: preview(_con.files[index], index),
                    );
                  },
                  itemCount: _con.files.length,
                  shrinkWrap: true,
                  primary: false,
                ),
                const SizedBox(height: 20),
                ButtonPrimaryWidget(
                  "Continue",
                  onTap: () {
                    // 🔻 Razorpay payment disabled
                    _con.payAmount();

                    // 👉 Instead, directly add the document without payment
                    // _con.onAddDocument();
                  },
                  isLoading: _con.isLoading.value,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget preview(PlatformFile file, int index) {
    if (file.extension == "pdf") {
      return PDFView(
        filePath: file.path,
        enableSwipe: true,
        swipeHorizontal: true,
        backgroundColor: Colors.grey.shade100,
        onPageChanged: (page, total) {
          _con.pageCount[index] = total ?? 1;
          _con.getTotalAmount();
        },
        onViewCreated: (controller) async {
          _con.getTotalAmount();
        },
      );
    }
    if (file.extension == "jpg" || file.extension == "png") {
      return Image.file(File(file.path!));
    }
    if (file.extension == "docx" || file.extension == "doc") {
      return FutureBuilder(
        future: readFromDocxFile(file.path!),
        builder: (context, snapshot) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SubTxtWidget(snapshot.data ?? ""),
            ),
          );
        },
      );
    }
    return SubTxtWidget("No File Found");
  }

  Future<String> readFromDocxFile(filePath) async {
    final file = File(filePath);
    final bytes = await file.readAsBytes();
    return docxToText(bytes);
  }
}
