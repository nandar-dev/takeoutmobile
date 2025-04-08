import 'package:flutter/material.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';

class TitleText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final Color? color;
  final FontWeight? fontWeight;
  final bool isCenter;
  final double? fontSize;

  const TitleText({
    super.key,
    required this.text,
    this.textAlign,
    this.color,
    this.fontWeight,
    this.isCenter = false,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: isCenter ? TextAlign.center : (textAlign ?? TextAlign.start),
      style: TextStyle(
        fontSize: fontSize ?? FontSizes.heading1,
        fontWeight: fontWeight ?? FontWeight.bold,
        color: color ?? AppColors.neutral100,
      ),
    );
  }
}

class SubText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;

  const SubText({
    super.key,
    required this.text,
    this.textAlign,
    this.color,
    this.fontWeight,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.start,
      style: TextStyle(
        fontSize: fontSize ?? FontSizes.body1,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? AppColors.neutral30,
      ),
    );
  }
}