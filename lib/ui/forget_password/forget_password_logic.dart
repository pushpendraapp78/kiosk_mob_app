import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Utils/tools.dart';
import '../../repo/auth_repo.dart';

class ForgetPasswordLogic extends GetxController {
  RxBool isLoading=false.obs;
  RxBool obscureText = RxBool(true);
  RxBool obscureOldText = RxBool(true);
  RxBool obscureTextCnf = RxBool(true);
  GlobalKey<FormState> formKeyUpdate = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyReset = GlobalKey<FormState>();
  var emailCon = TextEditingController();
  var newPasswordCon = TextEditingController();
  var oldPasswordCon = TextEditingController();
  var cnfPasswordCon = TextEditingController();
  void onChangePassword(){
    if(formKeyReset.currentState!.validate()){
      isLoading.value=true;
      Map<String,dynamic>map={};
      map['current_password']=oldPasswordCon.text;
      map['new_password']=newPasswordCon.text;
      map['new_password_confirmation']=cnfPasswordCon.text;
      changePassword(map).then((value) {
        isLoading.value=false;
        if(value.success!){
          Tools.ShowSuccessMessage(value.message!);
          Get.back();
        }else{
          Tools.ShowErrorMessage(value.message!);
        }
      },);
    }
  }
  void onForgetPassword(){
    if(formKeyUpdate.currentState!.validate()){
      isLoading.value=true;
      Map<String,dynamic>map={};
      map['email']=emailCon.text;
      forgetPassword(map).then((value) {
        isLoading.value=false;
        if(value.success!){
          Tools.ShowSuccessMessage(value.message!);
          Get.back();
        }else{
          Tools.ShowErrorMessage(value.message!);
        }
      },);
    }
  }
}
