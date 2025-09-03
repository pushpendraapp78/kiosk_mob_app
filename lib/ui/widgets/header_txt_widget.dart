import 'package:flutter/material.dart';
import '../../Constant/color_const.dart';

class HeaderTxtWidget extends StatelessWidget {
  String txt;
  var textAlign;
  var maxLines;
  var color;
  double fontSize;
  String? fontFamily;
  TextDecoration? decoration;
  TextOverflow? overflow;
  FontWeight? fontWeight;

  HeaderTxtWidget(this.txt,
      {this.fontWeight,
      this.textAlign,
      this.maxLines,
      this.color,
      this.fontSize = 16,
      this.overflow,
      this.fontFamily,
      this.decoration});

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
          fontSize: fontSize,
          fontStyle: FontStyle.normal,
          fontWeight: fontWeight ?? FontWeight.w900,
          color: color ?? textColor_12od26,
          fontFamily: fontFamily ?? "nunito",
          overflow: overflow,
          decoration: decoration ?? TextDecoration.none),
    );
  }
}
