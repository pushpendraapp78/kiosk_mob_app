import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipbot_app/model/help_support_ticket.dart';
import 'package:ipbot_app/repo/auth_repo.dart'; // Import the API file (adjust path if needed)
import 'package:ipbot_app/repo/session_repo.dart';
import 'package:ipbot_app/model/basic_response.dart';

class HelpSupportController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;

  final nameCon = TextEditingController();
  final emailCon = TextEditingController();
  final phoneCon = TextEditingController();
  final messageCon = TextEditingController();
  final otpCon = TextEditingController();

  RxList<HelpSupportTicket> tickets = <HelpSupportTicket>[].obs;

  @override
  void onReady() {
    super.onReady();
    initForm();
    fetchTickets();
  }

  @override
  void onClose() {
    nameCon.dispose();
    emailCon.dispose();
    phoneCon.dispose();
    messageCon.dispose();
    otpCon.dispose();
    super.onClose();
  }

  void initForm() async {
    try {
      final user = await getSession();
      nameCon.text = user.name ?? "";
      emailCon.text = user.email ?? "";
      phoneCon.text = user.mobile ?? "";
      messageCon.text = "";
      otpCon.text = "";
    } catch (e) {
      print("HelpSupportController.initForm error: $e");
      _showSnackBar("Failed to load user data", Colors.red);
    }
  }

  Future<void> onSubmit() async {
    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }

    isLoading.value = true;

    final requestBody = {
      "full_name": nameCon.text.trim(),
      "mobile_no": phoneCon.text.trim(),
      "email": emailCon.text.trim(),
      "otp": otpCon.text.trim(),
      "message": messageCon.text.trim(),
      "created_by": emailCon.text.trim(),
      "device_info": "Mobile",
    };

    try {
      final response = await addHelpSupportTicket(requestBody);
      if (response.success ?? false) {
        _showSnackBar(response.message ?? 'Submitted successfully', Colors.green);
        Get.offNamed('/help_support_list');
        await fetchTickets(); // Refresh list after submit
      } else {
        _showSnackBar(response.message ?? 'Failed to submit form', Colors.red);
      }
    } catch (e) {
      print("HelpSupportController.onSubmit error: $e");
      _showSnackBar("Network error: $e", Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchTickets() async {
    try {
      isLoading.value = true;
      final user = await getSession();
      final requestBody = {
        "created_by": user.email ?? "",
      };
      final ticketList = await getHelpSupportTickets(requestBody);
      tickets.value = ticketList;
    } catch (e) {
      print("HelpSupportController.fetchTickets error: $e");
      _showSnackBar("Network error: $e", Colors.red);
      tickets.clear();
    } finally {
      isLoading.value = false;
    }
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}