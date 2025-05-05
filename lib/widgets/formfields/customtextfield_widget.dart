import 'package:flutter/material.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class CustomTextField extends StatefulWidget {
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
  final bool readOnly;
  final EdgeInsetsGeometry? contentPadding;
  final ValueChanged<String>? onChanged;

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
    this.readOnly = false,
    this.contentPadding,
    this.onChanged,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final bool isPassword = widget.obscureText;

    const borderRadius = BorderRadius.all(Radius.circular(10));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label.isNotEmpty)
          SubText(
            text: widget.label,
            color: AppColors.neutral80,
            fontSize: FontSizes.body,
            fontWeight: FontWeight.w500,
          ),
        if (widget.label.isNotEmpty) const SizedBox(height: 4),
        TextFormField(
          maxLines: widget.maxLines,
          readOnly: widget.readOnly,
          controller: widget.controller,
          obscureText: isPassword && !_isPasswordVisible,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          onChanged: widget.onChanged,
          style: const TextStyle(fontSize: FontSizes.body),
          decoration: InputDecoration(
            isDense: widget.isDense,
            contentPadding:
                widget.contentPadding ??
                const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            prefixIcon: widget.prefixIcon,
            prefixIconConstraints: const BoxConstraints(
              minWidth: 32,
              minHeight: 32,
            ),
            suffixIcon:
                widget.suffixIcon ??
                (isPassword
                    ? IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.neutral70,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    )
                    : null),
            suffixIconConstraints: const BoxConstraints(
              minWidth: 32,
              minHeight: 32,
            ),
            suffixIconColor: AppColors.neutral70,
            hintText: widget.hint,
            hintStyle: const TextStyle(color: AppColors.neutral60),
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
