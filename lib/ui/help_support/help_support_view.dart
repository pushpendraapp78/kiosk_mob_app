import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ipbot_app/ext/hex_color.dart';
import '../../generated/assets.dart';
import '../../generated/l10n.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/button_primary_widget.dart';
import '../widgets/header_txt_widget.dart';
import '../widgets/input_widget.dart';
import '../widgets/text_area_widget.dart';
import 'help_support_controller.dart';

class HelpSupportPage extends StatelessWidget {
  final _con = Get.put(HelpSupportController()); // ✅ same controller
  final FocusNode _messageFocusNode = FocusNode(); // FocusNode for message field

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(
        showBackButton: true,
        title: HeaderTxtWidget(
          "Help & Support",
          fontSize: 24,
          color: Colors.white,
        ),
        height: 75,
      ),
      body: Obx(
            () => AbsorbPointer(
          absorbing: _con.isLoading.isTrue,
          child: SingleChildScrollView(
            controller: ScrollController()
              ..addListener(() {
                // Ensures the keyboard doesn't block the content
                FocusScope.of(context).unfocus();
              }),
            child: Form(
              key: _con.formKey,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    InputWidget(
                      controller: _con.nameCon,
                      hint: S.of(context).fullName,
                      validator: ValidationType.TEXT,
                      inputType: TextInputType.text,
                      prefixIcon: Container(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset(Assets.svgProfile),
                      ),
                      errorMsg: S.of(context).pleaseEnterFullName,
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
                      controller: _con.phoneCon,
                      hint: "+9113243354545",
                      validator: ValidationType.TEXT,
                      inputType: TextInputType.phone,
                      prefixIcon: Container(
                        padding: const EdgeInsets.all(10),
                        child: Icon(
                          Icons.phone_android,
                          color: '#807A7A'.toColor(),
                        ),
                      ),
                      errorMsg: S.of(context).pleaseEnterPhoneNumber,
                    ),
                    InputWidget(
                      controller: _con.otpCon,
                      hint: "Enter OTP",
                      inputType: TextInputType.number,
                      prefixIcon: Container(
                        padding: const EdgeInsets.all(10),
                        child: Icon(
                          Icons.lock,
                          color: '#807A7A'.toColor(),
                        ),
                      ),
                    ),
                    TextAreaWidget(
                      controller: _con.messageCon,
                      focusNode: _messageFocusNode,  // Set the focus node
                      hint: "Your message...",
                      inputType: TextInputType.multiline,
                      minLines: 5,
                      maxLines: 5,
                      inputFormatters: null,
                      prefixIcon: Transform.translate(
                        offset: const Offset(0, -45),
                        child: Icon(
                          Icons.message,
                          color: '#807A7A'.toColor(),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter your message";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ButtonPrimaryWidget(
                      S.of(context).submit,
                      onTap: _con.onSubmit,
                      isLoading: _con.isLoading.value,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
