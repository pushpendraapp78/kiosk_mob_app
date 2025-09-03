import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../../generated/assets.dart';
import '../../generated/l10n.dart';
import '../widgets/button_primary_widget.dart';
import '../widgets/header_txt_widget.dart';
import '../widgets/input_widget.dart';
import '../widgets/sub_txt_widget.dart';
import 'forget_password_logic.dart';

class ForgetPasswordPage extends StatefulWidget {
   const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final _con = Get.put(ForgetPasswordLogic());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
      ),
      body: Obx(() => AbsorbPointer(
        absorbing: _con.isLoading.value,
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _con.formKeyUpdate,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10,bottom: 10),
                    alignment: AlignmentDirectional.centerStart,
                    child:  HeaderTxtWidget('Forget Password?',fontSize: 24,fontWeight: FontWeight.w800,),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10,bottom: 10),
                    alignment: AlignmentDirectional.centerStart,
                    child:  SubTxtWidget(S.of(context).pleaseEnterYourEmailAddressToRequest,fontSize: 15,fontWeight: FontWeight.w600,),
                  ),
                  InputWidget(
                    controller: _con.emailCon,
                    hint: S.of(context).abcemailcom,
                    inputType: TextInputType.emailAddress,
                    prefixIcon: Container(
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset(Assets.svgMail),
                    ),
                    errorMsg: S.of(context).pleaseEnterEmail,
                    validator: ValidationType.EMAIL,
                  ),

                  const SizedBox(height: 40,),
                  ButtonPrimaryWidget("Submit",
                    onTap: (){
                      _con.onForgetPassword();
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
