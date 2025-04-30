import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';

void showToast({
  required String message,
  ToastGravity gravity = ToastGravity.BOTTOM,
  Toast length = Toast.LENGTH_LONG,
  Color? backgroundColor,
  Color? textColor,
  double? fontSize,
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: length,
    gravity: gravity,
    timeInSecForIosWeb: 1,
    backgroundColor: backgroundColor ?? AppColors.neutral100.withOpacity(0.4),
    textColor: textColor ?? Colors.white,
    fontSize: fontSize ?? FontSizes.body,
  );
}