import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ipbot_app/ui/widgets/sub_txt_widget.dart';

import '../../Constant/color_const.dart';

class InputPhoneWidget extends StatelessWidget {
  TextEditingController? controller;
  Function(CountryCode)? onChanged;
  var onDone;
  String? title;
  String? hint;
  String? errorMsg;
  InputPhoneWidget(
      {super.key,
      this.controller,
      this.title,
      this.hint,
      this.onChanged,
      this.onDone,
      this.errorMsg});

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border = OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: color_E4DFDF),
      borderRadius: BorderRadius.circular(12.0),
    );
    OutlineInputBorder errorBorder = OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: color_E4DFDF),
      borderRadius: BorderRadius.circular(12.0),
    );
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
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
          TextFormField(
            controller: controller ?? TextEditingController(),
            keyboardType: TextInputType.phone,
            onFieldSubmitted: onDone,
            validator: (value) {
              if (value!.isEmpty) {
                return errorMsg;
              }
              return null;
            },
            decoration: InputDecoration(
              fillColor: Colors.white,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              focusedBorder: border,
              errorBorder: errorBorder,
              errorStyle: const TextStyle(color: Colors.red),
              enabledBorder: border,
              border: border,
              focusedErrorBorder: border,
              filled: true,
              hoverColor: Colors.transparent,
              hintText: hint ?? "",
              hintStyle: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade400,
              ),
              counterText: "",
              prefixIcon: CountryCodePicker(
                onChanged: onChanged,
                initialSelection: "+91",
                builder: (code) {
                  return Container(
                    width: getWidth(code!.dialCode.toString().length),
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        SubTxtWidget(code.dialCode!),
                        const SizedBox(
                          height: 40,
                          width: 20,
                          child: VerticalDivider(),
                        )
                      ],
                    ),
                  );
                },
                showFlagDialog: false,
                showFlag: false,
              ),
            ),
          )
        ],
      ),
    );
  }
  double getWidth(int len){
    if(len==5){
      return 80;
    }
    if(len==4){
      return 70;
    }
    return 60;
  }
}
