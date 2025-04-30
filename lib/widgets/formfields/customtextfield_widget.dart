import 'package:flutter/material.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int maxLines;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool isDense;
  final EdgeInsetsGeometry? contentPadding;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.controller,
    this.validator,
    this.isDense = false,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(10));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty)
          SubText(
            text: label,
            color: AppColors.neutral100,
            fontSize: FontSizes.body,
            fontWeight: FontWeight.w500,
          ),
        if (label.isNotEmpty) const SizedBox(height: 4),
        TextFormField(
          maxLines: maxLines,
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
          style: const TextStyle(fontSize: FontSizes.body),
          decoration: InputDecoration(
            isDense: isDense,
            contentPadding:
                contentPadding ??
                const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            prefixIcon: prefixIcon,
            prefixIconConstraints: const BoxConstraints(
              minWidth: 32,
              minHeight: 32,
            ),
            suffixIcon: suffixIcon,
            suffixIconConstraints: const BoxConstraints(
              minWidth: 32,
              minHeight: 32,
            ),
            suffixIconColor: AppColors.neutral70,
            iconColor: AppColors.neutral70,
            hintText: hint,
            errorStyle: const TextStyle(
              color: AppColors.neutral60,
              fontSize: FontSizes.body,
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide(color: AppColors.textfieldborder),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide(color: AppColors.primary),
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide(color: AppColors.danger),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide(color: AppColors.danger),
            ),
            border: const OutlineInputBorder(borderRadius: borderRadius),
          ),
        ),
      ],
    );
  }
}
