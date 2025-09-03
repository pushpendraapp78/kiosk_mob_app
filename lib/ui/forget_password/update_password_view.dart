import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../Utils/tools.dart';
import '../../generated/assets.dart';
import '../../generated/l10n.dart';
import '../widgets/button_primary_widget.dart';
import '../widgets/header_txt_widget.dart';
import '../widgets/input_widget.dart';
import 'forget_password_logic.dart';

class UpdatePasswordPage extends StatelessWidget {
  UpdatePasswordPage({super.key});
  final _con = Get.put(ForgetPasswordLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        title: HeaderTxtWidget(S.of(context).resetPassword,),
      ),
      body: Obx(() => AbsorbPointer(
        absorbing: _con.isLoading.value,
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _con.formKeyReset,
              child: Column(
                children: [
                  InputWidget(
                    controller: _con.oldPasswordCon,
                    hint: 'Current Password',
                    obscureText:_con.obscureOldText.value,
                    prefixIcon: Container(
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset(Assets.svgPassword),
                    ),
                    suffixIcon: IconButton(
                      icon: _con.obscureOldText.value?const Icon(Icons.visibility):const Icon(Icons.visibility_off),
                      onPressed: (){
                        _con.obscureOldText.value=!_con.obscureOldText.value;
                      },
                    ),
                    errorMsg: "Please enter current password",
                    validator: ValidationType.TEXT,
                  ),
                  InputWidget(
                    controller: _con.newPasswordCon,
                    hint: S.of(context).newPassword,
                    obscureText:_con.obscureText.value,
                    prefixIcon: Container(
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset(Assets.svgPassword),
                    ),
                    suffixIcon: IconButton(
                      icon: _con.obscureText.value?const Icon(Icons.visibility):const Icon(Icons.visibility_off),
                      onPressed: (){
                        _con.obscureText.value=!_con.obscureText.value;
                      },
                    ),
                    errorMsg: S.of(context).pleaseEnterNewPassword,
                    validator: ValidationType.TEXT,
                  ),
                  InputWidget(
                    controller: _con.cnfPasswordCon,
                    hint: S.of(context).confirmPassword,
                    obscureText:_con.obscureTextCnf.value,
                    prefixIcon: Container(
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset(Assets.svgPassword),
                    ),
                    suffixIcon: IconButton(
                      icon: _con.obscureTextCnf.value?const Icon(Icons.visibility):const Icon(Icons.visibility_off),
                      onPressed: (){
                        _con.obscureTextCnf.value=!_con.obscureTextCnf.value;
                      },
                    ),
                    validatorCallback: (value) {
                      if(value!.isEmpty){
                        return S.of(context).pleaseEnterConfirmPassword;
                      }
                      if(_con.cnfPasswordCon.value.text != _con.newPasswordCon.value.text){
                        return S.of(context).passwordNotMatch;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20,),
                  ButtonPrimaryWidget(S.of(context).update,
                    onTap: (){
                    _con.onChangePassword();
                    },isLoading: _con.isLoading.value,),
                  const SizedBox(height: 20,),
                ],
              ),
            )
        ),
      ),),
    );
  }
}
