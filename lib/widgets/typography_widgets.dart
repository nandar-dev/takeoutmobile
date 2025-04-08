import 'package:flutter/material.dart';
import 'package:takeout/utils/colors.dart';
import 'package:takeout/utils/font_sizes.dart';
class TitleText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final Color? color;
  final FontWeight? fontWeight;
  final bool isCenter;

  const TitleText({
    super.key,
    required this.text,
    this.textAlign,
    this.color,
    this.fontWeight,
    this.isCenter = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: isCenter ? TextAlign.center : (textAlign ?? TextAlign.start),
      style: TextStyle(
        fontSize: FontSizes.heading1,
        fontWeight: fontWeight ?? FontWeight.bold,
        color: color ?? AppColors.black,
      ),
    );
  }
}

class SubText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final Color? color;
  final FontWeight? fontWeight;

  const SubText({
    super.key,
    required this.text,
    this.textAlign,
    this.color,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.start,
      style: TextStyle(
        fontSize: FontSizes.body,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? AppColors.grey,
      ),
    );
  }
}
