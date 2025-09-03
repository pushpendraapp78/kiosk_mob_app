import 'package:flutter/material.dart';
import 'package:ipbot_app/ui/widgets/sub_txt_widget.dart';
import '../../Constant/color_const.dart';

class DropdownWidget<T> extends StatelessWidget {
  String? title;
  String? titleHint;
  String? hint;
  String? errorMsg;
  Function(T?) onChanged;
  T? value;
  List<DropdownMenuItem<T>>? items;

  DropdownWidget({
    super.key,
    this.title,
    this.titleHint,
    this.hint,
    this.errorMsg,
    this.value,
    required this.onChanged,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
          DropdownButtonFormField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: color_E4DFDF),
                borderRadius: BorderRadius.circular(12.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: color_E4DFDF),
                borderRadius: BorderRadius.circular(12.0),
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: color_E4DFDF),
                borderRadius: BorderRadius.circular(12.0),
              ),
              hintText: hint,
              hintStyle: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                  color: color_747688),
            ),
            items: items,
            onChanged: onChanged,
            value: value,
            validator: (value) {
              if (value == null) {
                return errorMsg;
              }
              return null;
            },
          )
        ],
      ),
    );
  }
}
