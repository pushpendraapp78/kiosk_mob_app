import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipbot_app/Utils/tools.dart';
import 'package:ipbot_app/repo/auth_repo.dart';
import 'package:ipbot_app/repo/session_repo.dart';
import '../../Constant/color_const.dart';

class SignupController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool obscureText = RxBool(true);
  RxBool obscureTextCnf = RxBool(true);
  RxBool isLoading = RxBool(false);
  var nameCon = TextEditingController();
  var cnfPassowrdCon = TextEditingController();
  var emailCon = TextEditingController();
  var phoneCon = TextEditingController();
  var passwordCon = TextEditingController();
  String countryCode = "+91";

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
  void onSignUp(){
    if(formKey.currentState!.validate()){
      isLoading.value=true;
      Map<String,dynamic>map={};
      map['user_name']=nameCon.text;
      map['email_id']=emailCon.text;
      map['password']=passwordCon.text;
      map['mobile_no']=phoneCon.text;
      map['role_id']= [2];
      map['created_by']=emailCon.text;
      map['status']="active";
      signUp(map).then((value) {
        isLoading.value=false;
        if(value.success!){
          CreateSession(value.data!.toJson(), true);
          Get.offAllNamed('/dashboard');
        }else{
          Tools.ShowErrorMessage(value.message??"");
        }
      },);
    }
  }


}
