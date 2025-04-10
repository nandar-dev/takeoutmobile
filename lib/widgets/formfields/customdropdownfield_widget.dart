import 'package:flutter/material.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';

class CustomDropdownFormField<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<T> items;
  final String? hintText;
  final String? Function(T?)? validator;
  final void Function(T?) onChanged;
  final String Function(T)? itemToString;

  const CustomDropdownFormField({
    super.key,
    required this.label,
    required this.items,
    required this.value,
    required this.onChanged,
    this.hintText,
    this.validator,
    this.itemToString,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.neutral100,
            fontSize: FontSizes.body,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<T>(
          value: value,
          validator: validator,
          style: TextStyle(
            fontSize: FontSizes.body,
            color: AppColors.neutral100,
          ),
          decoration: InputDecoration(
            hintText: hintText ?? 'Select an option',
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.textfieldborder),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primary),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.danger),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.danger),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          ),
          isDense: true,
          items:
              items.map((T value) {
                return DropdownMenuItem<T>(
                  value: value,
                  child: Text(
                    itemToString != null
                        ? itemToString!(value)
                        : value.toString(),
                  ),
                );
              }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
