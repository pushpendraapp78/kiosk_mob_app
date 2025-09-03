import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateConvert on String {
  String toSplitDate() {
    final old_format = DateFormat('yyyy-MM-dd');
    final newDate = DateFormat('dd MMM');
    DateTime dateTime = old_format.parse(this);
    String date = newDate.format(dateTime);
    return date.replaceAll(" ", "\n");
  }

  String timeAgo({bool numericDates = true}) {
    final date2 = DateTime.now().toLocal();
    final old_format = DateFormat(
      'MM/dd/yyyy hh:mm',
    );
    print(old_format.parse(this.toUpperCase()).toString());
    final difference = date2.difference(old_format.parse(this));

    if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 week ago' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 day ago' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 minute ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }

  String toFirstCap() {
    if (isEmpty) return "";
    return substring(0, 1).toUpperCase();
  }
}
