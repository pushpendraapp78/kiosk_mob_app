import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../Utils/tools.dart';
import '../../repo/auth_repo.dart';
import '../../repo/session_repo.dart';

class LoginController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool obscureText = RxBool(true);
  RxBool isLoading = RxBool(false);
  RxBool isRememberMe = RxBool(true);
  var emailCon = TextEditingController();
  var passwordCon = TextEditingController();
  String? token;
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

  void onSignin() {
    if (formKey.currentState!.validate()) {
      FocusScope.of(scaffoldKey.currentContext!).unfocus();
      isLoading.value = true;
      Map<String, dynamic> map = {};
      map['username'] = emailCon.value.text;
      map['password'] = passwordCon.value.text;
      signIn(map).then((value) {
        isLoading.value=false;
        if(value.success!){
          CreateSession(value.data!.toJson(), isRememberMe.value);
          Get.offAllNamed('/dashboard');
        }else{
          Tools.ShowErrorMessage(value.message??"");
        }
      },);
    }
  }
  Future<void> googleSignIn() async {
    signInWithGoogle().then((value) {
      getProfileByEmail(value.user!.email!).then((value) {
        if (value.success!) {
          CreateSession(value.data!.toJson(), isRememberMe.value);
          Get.offAllNamed('/dashboard');
        } else {
          Map<String, dynamic>map = {};
          map['name'] = value.data!.name;
          map['email'] = value.data!.email;
          map['password'] = value.data!.id;
          onSignUp(map);
        }
      },);

    },);
  }
  void onSignUp(Map<String,dynamic>map){
    signUp(map).then((value) {
      if(value.success!){
        CreateSession(value.data!.toJson(), true);
        Get.offAllNamed('/dashboard');
      }else{
        Tools.ShowErrorMessage(value.message??"");
      }
    },);
  }
}
