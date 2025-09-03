import 'package:flutter/material.dart';

import '../../Constant/color_const.dart';

class SubTxtWidget extends StatelessWidget {
  String txt;
  var textAlign;
  var maxLines;
  var color;
  var overflow;
  bool italic;
  bool underline;
  double fontSize;
  FontWeight? fontWeight;

  SubTxtWidget(this.txt,
      {this.textAlign,
      this.maxLines,
      this.color,
      this.fontSize = 16,
      this.italic = false,
      this.underline = false,
      this.overflow,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: fontSize,
        fontStyle: italic ? FontStyle.italic : FontStyle.normal,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? textColor_12od26,
        fontFamily: 'nunito',
        overflow: overflow,
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
      ),
    );
  }
}
