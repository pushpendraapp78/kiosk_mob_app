import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../Constant/color_const.dart';
import '../../generated/assets.dart';
import '../../generated/l10n.dart';
import '../widgets/button_primary_widget.dart';
import '../widgets/custom_switch.dart';
import '../widgets/header_txt_widget.dart';
import '../widgets/input_widget.dart';
import '../widgets/sub_txt_widget.dart';
import 'login_controller.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController _con = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Obx(() => AbsorbPointer(
        absorbing: _con.isLoading.value,
        child: Column(
          children: [
            Expanded(child: SingleChildScrollView(
                controller: ScrollController()
                  ..addListener(() {
                    FocusScope.of(context).unfocus();
                  }),
                child: Form(
                  key: _con.formKey,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const SizedBox(height: 50,),
                        Image.asset(Assets.imgLogo,height: 120,),
                        const SizedBox(height: 30,),
                        Container(
                          padding: const EdgeInsets.only(left: 10,bottom: 10),
                          alignment: AlignmentDirectional.center,
                          child:  HeaderTxtWidget('Welcome to IpBot',fontSize: 20,fontWeight: FontWeight.w800,textAlign: TextAlign.center,),
                        ),
                        InputWidget(
                          controller: _con.emailCon,
                          hint: S.of(context).abcemailcom,
                          validator: ValidationType.EMAIL,
                          inputType: TextInputType.emailAddress,
                          prefixIcon: Container(
                            padding: const EdgeInsets.all(10),
                            child: SvgPicture.asset(Assets.svgMail),
                          ),
                          errorMsg: S.of(context).pleaseEnterEmail,
                        ),
                        InputWidget(
                          controller: _con.passwordCon,
                          hint: S.of(context).yourPassword,
                          obscureText:_con.obscureText.value,
                          validator: ValidationType.TEXT,
                          inputType: TextInputType.visiblePassword,
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
                          errorMsg: S.of(context).pleaseEnterPassword,
                        ),
                        const SizedBox(height: 20,),
                        Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CustomSwitch(onChanged: (value) {
                                    _con.isRememberMe.value=value;
                                  },value: _con.isRememberMe.value,),
                                  const SizedBox(width: 10,),
                                  SubTxtWidget(S.of(context).rememberMe,fontSize: 14,fontWeight: FontWeight.w600,)
                                ],
                              ),
                              InkWell(
                                onTap: (){
                                  Get.toNamed('/forget_password');
                                },
                                child: SubTxtWidget(S.of(context).forgotPassword,fontSize: 14,fontWeight: FontWeight.w600,),
                              ),
                            ],
                          ),),
                        const SizedBox(height: 30,),
                        ButtonPrimaryWidget(S.of(context).signIn.toUpperCase(),onTap: (){
                          _con.onSignin();
                        },isLoading: _con.isLoading.value,),
                        const SizedBox(height: 20,),
                        SubTxtWidget('OR',fontSize: 16,),
                        const SizedBox(height: 20,),
                        _signUp(),
                      ],
                    ),
                  ),
                )
            )),
            ButtonPrimaryWidget("Sign with Google",
            marginVertical: 10,marginHorizontal: 20,
            color: Colors.white,
            borderColor: primaryColorCode,
            txtColor: Colors.black,
            leading: Image.asset(Assets.imgGoogle,height: 30,),
              onTap: () {
                _con.googleSignIn();
              },
            )
          ],
        ),
      ),),
    );
  }
  Widget _signUp(){
    return Container(
      padding: const EdgeInsets.all(30),
      alignment: AlignmentDirectional.center,
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        children: [
          HeaderTxtWidget('Don’t have an account?  ',
            fontSize: 15,
            fontWeight: FontWeight.w700,),
          InkWell(
            child: HeaderTxtWidget('Sign up',
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.blue,),
            onTap: (){
              Get.toNamed('/signup');
            },
          )
        ],
      ),
    );
  }
}
