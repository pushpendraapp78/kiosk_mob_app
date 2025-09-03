import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipbot_app/ui/dashboard/dashboard_controller.dart';
import '../../Utils/tools.dart';
import '../../repo/auth_repo.dart';
import '../../repo/session_repo.dart';
import '../../repo/setting_repo.dart';

class ProfileController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool isLoading = RxBool(false);
  var nameCon = TextEditingController();
  var emailCon = TextEditingController();
  var phoneCon = TextEditingController();
  Rx<String?> profilePhoto = Rx(null);
  @override
  void onReady() {
    super.onReady();
    initProfile();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void initProfile() {
    nameCon.text = auth.value.name ?? "";
    emailCon.text = auth.value.email ?? "";
    phoneCon.text = auth.value.mobile ?? "";
  }

  void onUpdateProfile() {
    if(formKey.currentState!.validate()){
      isLoading.value=true;
      Map<String,dynamic>map={};
      map['name']=nameCon.text;
      map['email']=emailCon.text;
      map['mobile']=phoneCon.text;
      updateProfile(map).then((value) {
        isLoading.value=false;
        if(value.success!){
          Get.find<DashboardController>().onGetProfile();
          Get.back();
        }else{
          Tools.ShowErrorMessage(value.message??"");
        }
      },);
    }
  }


}
