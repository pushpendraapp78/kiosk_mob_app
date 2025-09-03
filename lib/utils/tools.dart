import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'dart:ui' as ui;

class Tools {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static void ShowSuccessMessage(message) {
    if (message == null) {
      return;
    }
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.lightGreen,
    ));
  }

  static void ShowErrorMessage(message) {
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ));
  }

  static bool isEmailValid(email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  static String changeDateFormat(String date, String format_type) {
    final format22 = DateFormat('yyyy-MM-dd HH:mm:ssZ', 'en-US');
    DateFormat format = DateFormat(format_type);
    DateTime dateTime =
        format22.parse(DateTime.parse(date).toLocal().toString());
    try {
      return format.format(dateTime);
    } catch (e, s) {
      return date;
    }
  }

  static DateTime changeToDate(String date) {
    final format = DateFormat('dd-MM-yyyy', 'en-US');
    return format.parse(date);
  }

  static String changeDateFormat2(
      String date, String format_type, String old_format) {
    final format22 = DateFormat(old_format);
    DateFormat format = DateFormat(format_type);
    DateTime dateTime = format22.parse(DateTime.parse(date).toString());
    try {
      return format.format(dateTime);
    } catch (e, s) {
      return date;
    }
  }

  static String changeTimeFormat(String time) {
    final format22 = new DateFormat('HH:mm', 'en-US');
    DateFormat format = DateFormat("hh:mm a");
    DateTime dateTime = format22.parse(time);
    return format.format(dateTime);
  }

  static String changeTimeFormat2(String time) {
    final format22 = new DateFormat('HH:mm:ss', 'en-US');
    DateFormat format = DateFormat("HH:mm");
    DateTime dateTime = format22.parse(time);
    return format.format(dateTime);
  }

  static double getMonth(String date) {
    final format22 = DateFormat('MM/dd/yyyy', 'en-US');
    DateTime dateTime = format22.parse(date);
    return dateTime.month.toDouble();
  }

  static String getCurrentDate() {
    final format = DateFormat('yyyy-MM-dd', 'en-US');
    return format.format(DateTime.now());
  }

  static bool isExpire(String date) {
    final old_format = DateFormat('yyyy-MM-dd HH:mm:ssZ', "en");
    DateTime dateTime = old_format.parse(date.replaceAll("T", " "));
    DateTime newDate = DateTime.now();
    int leftDays = dateTime.difference(newDate).inDays;
    return leftDays < 0;
  }

  static bool isAvailableFoCancel(String date) {
    final old_format = DateFormat('dd MMM yyyy');
    DateTime dateTime = old_format.parse(date);
    DateTime newDate = DateTime.now();
    int leftDays = dateTime.difference(newDate).inDays;
    return leftDays > 0;
  }

  static Color hexToColor(String code) {
    return Color(
        int.parse(code.length > 3 ? code.substring(1, 7) : code, radix: 16) +
            0xFF000000);
  }

  static void ShowDailog(context, widget) {
    showDialog(
        context: context,
        barrierColor: Colors.grey.shade400.withOpacity(0.5),
        builder: (ctxt) => widget);
  }

  static void ShowBottomSheet(context, widget,
      {bool isScrollControlled = true}) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return widget;
        },
        backgroundColor: Colors.transparent,
        isScrollControlled: isScrollControlled);
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
