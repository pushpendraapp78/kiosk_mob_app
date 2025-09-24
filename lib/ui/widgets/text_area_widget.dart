import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ipbot_app/ui/widgets/sub_txt_widget.dart';
import '../../Constant/color_const.dart';

class TextAreaWidget extends StatelessWidget {
  final TextEditingController? controller;
  final bool enabled;
  final bool obscureText;
  final TextInputType inputType;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onDone;
  final Color? color;
  final Color? fillColor;
  final String? title;
  final String? sufix;
  final String? hint;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final double? radius;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Widget? child;
  final EdgeInsets? contentPadding;
  final EdgeInsets? margin;
  final TextInputAction? textInputAction;
  final TextAlignVertical? textAlignVertical;

  /// 👇 New property
  final String? Function(String?)? validator;

  const TextAreaWidget({
    super.key,
    this.controller,
    this.inputType = TextInputType.multiline,
    this.sufix,
    this.title,
    this.enabled = true,
    this.obscureText = false,
    this.color,
    this.fillColor,
    this.hint,
    this.maxLength,
    this.minLines = 1,
    this.maxLines = 5,
    this.inputFormatters,
    this.suffixIcon,
    this.child,
    this.radius,
    this.contentPadding,
    this.margin,
    this.textInputAction,
    this.prefixIcon,
    this.textAlignVertical = TextAlignVertical.top,
    this.onChanged,
    this.onDone,
    this.validator, required FocusNode focusNode,
  });

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
            const SizedBox(height: 10),
          },
          child ??
              TextFormField(
                obscureText: obscureText,
                enabled: enabled,
                controller: controller ?? TextEditingController(),
                keyboardType: inputType,
                inputFormatters: inputFormatters,
                minLines: minLines,
                maxLines: obscureText ? 1 : maxLines ?? 5,
                maxLength: maxLength,
                onChanged: onChanged,
                onFieldSubmitted: onDone,
                textInputAction: textInputAction,
                textAlignVertical: textAlignVertical,
                validator: validator, // 👈 support validation
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
                    borderSide: BorderSide(width: 1, color: Colors.red),
                    borderRadius: BorderRadius.circular(radius ?? 12.0),
                  ),
                  errorStyle: const TextStyle(color: Colors.red),
                  border: OutlineInputBorder(
                    borderSide:
                    BorderSide(width: 1, color: color ?? color_E4DFDF),
                    borderRadius: BorderRadius.circular(radius ?? 12.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(width: 1, color: color ?? color_E4DFDF),
                    borderRadius: BorderRadius.circular(radius ?? 12.0),
                  ),
                  filled: true,
                  suffixText: sufix,
                  suffixStyle: const TextStyle(color: Colors.black),
                  hoverColor: Colors.transparent,
                  hintText: hint ?? "",
                  hintStyle: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w500,
                    color: color_747688,
                  ),
                  counterText: "",
                  suffixIcon: suffixIcon,
                  prefixIcon: prefixIcon,
                ),
              ),
        ],
      ),
    );
  }
}
