import 'package:flutter/material.dart';
import 'package:takeout/utils/colors.dart';
import 'package:takeout/utils/font_sizes.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.black,
            fontSize: FontSizes.body,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            suffixIconColor: AppColors.black,
            iconColor: AppColors.black,
            hintText: hint,
            errorStyle: TextStyle(
              color: AppColors.grey,
              fontSize: FontSizes.body,
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.textfieldborder),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primary),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.red),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.red),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          ),
        ),
      ],
    );
  }
}
