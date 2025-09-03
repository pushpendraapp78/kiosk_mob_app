import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ipbot_app/ui/widgets/sub_txt_widget.dart';
import '../../Constant/color_const.dart';
import '../../Utils/tools.dart';

enum ValidationType { EMAIL, TEXT, NONE, ShowError }

class InputWidget extends StatelessWidget {
  TextEditingController? controller;
  bool enabled;
  bool obscureText;
  var inputType;
  var onChanged;
  var onDone;
  Color? color;
  Color? fillColor;
  String? title;
  String? sufix;
  String? hint;
  int? maxLength;
  int? maxLines;
  double? radius;
  List<TextInputFormatter>? inputFormatters;
  ValidationType validator;
  Widget? suffixIcon;
  Widget? prefixIcon;
  Widget? child;
  EdgeInsets? contentPadding;
  EdgeInsets? margin;
  String? errorMsg;
  FormFieldValidator<String>? validatorCallback;
  TextInputAction? textInputAction;
  InputWidget(
      {super.key,
      this.controller,
      this.inputType = TextInputType.text,
      this.sufix,
      this.title,
      this.enabled = true,
      this.obscureText = false,
      this.color,
      this.fillColor,
      this.hint,
      this.maxLength,
      this.maxLines,
      this.validator = ValidationType.NONE,
      this.onChanged,
      this.onDone,
      this.inputFormatters,
      this.suffixIcon,
      this.child,
      this.radius,
      this.contentPadding,
      this.validatorCallback,
      this.margin,
      this.errorMsg,
      this.textInputAction,
      this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      alignment: AlignmentDirectional.topCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null && title!.isNotEmpty) ...{
            SubTxtWidget(title!),
            const SizedBox(
              height: 10,
            ),
          },
          child ??
              TextFormField(
                obscureText: obscureText,
                enabled: enabled,
                controller: controller ?? TextEditingController(),
                keyboardType: inputType,
                inputFormatters: inputFormatters ??
                    [FilteringTextInputFormatter.singleLineFormatter],
                maxLines: obscureText ? 1 : maxLines ?? 1,
                maxLength: maxLength,
                onChanged: onChanged,
                onFieldSubmitted: onDone,
                textInputAction: textInputAction,
                validator: validatorCallback ??
                    (value) {
                      if (validator == ValidationType.NONE) {
                        return null;
                      }
                      if (validator == ValidationType.TEXT && value!.isEmpty) {
                        return errorMsg;
                      }
                      if (validator == ValidationType.EMAIL) {
                        if (value!.isEmpty) {
                          return errorMsg;
                        }
                        if (!Tools.isEmailValid(value.toString())) {
                          return "Please enter valid email Address";
                        }
                        return null;
                      }
                      if (validator == ValidationType.ShowError) {
                        return errorMsg;
                      }
                      return null;
                    },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1, color: color ?? color_E4DFDF),
                    borderRadius: BorderRadius.circular(radius ?? 12.0),
                  ),
                  fillColor: fillColor ?? Colors.white,
                  contentPadding: contentPadding ??
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1, color: color ?? color_E4DFDF),
                    borderRadius: BorderRadius.circular(radius ?? 12.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1, color: color ?? Colors.red),
                    borderRadius: BorderRadius.circular(radius ?? 12.0),
                  ),
                  errorStyle: TextStyle(color: Colors.red),
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1, color: color ?? color_E4DFDF),
                    borderRadius:
                        BorderRadius.circular(radius ?? 12.0), //<-- SEE HERE
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1, color: color ?? color_E4DFDF),
                    borderRadius: BorderRadius.circular(radius ?? 12.0),
                  ),
                  filled: true,
                  suffixText: sufix,
                  suffixStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  hoverColor: Colors.transparent,
                  hintText: hint ?? "",
                  hintStyle: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w500,
                      color: color_747688),
                  counterText: "",
                  suffixIcon: suffixIcon,
                  prefixIcon: prefixIcon,
                ),
              )
        ],
      ),
    );
  }
}
