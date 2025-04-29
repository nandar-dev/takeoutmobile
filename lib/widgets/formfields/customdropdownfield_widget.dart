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
  final bool hideBorder;

  const CustomDropdownFormField({
    super.key,
    required this.label,
    required this.items,
    required this.value,
    required this.onChanged,
    this.hintText,
    this.validator,
    this.itemToString,
    this.hideBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(10));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) ...[
          Text(
            label,
            style: const TextStyle(
              color: AppColors.neutral100,
              fontSize: FontSizes.body,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
        ],
        DropdownButtonFormField<T>(
          isExpanded: true,
          value: value,
          validator: validator,
          style: const TextStyle(
            fontSize: FontSizes.body,
            color: AppColors.neutral100,
          ),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            hintText: hintText ?? 'Select an option',
            enabledBorder: hideBorder
                ? InputBorder.none
                : const OutlineInputBorder(
                    borderRadius: borderRadius,
                    borderSide: BorderSide(color: AppColors.textfieldborder),
                  ),
            focusedBorder: hideBorder
                ? InputBorder.none
                : const OutlineInputBorder(
                    borderRadius: borderRadius,
                    borderSide: BorderSide(color: AppColors.primary),
                  ),
            errorBorder: hideBorder
                ? InputBorder.none
                : const OutlineInputBorder(
                    borderRadius: borderRadius,
                    borderSide: BorderSide(color: AppColors.danger),
                  ),
            focusedErrorBorder: hideBorder
                ? InputBorder.none
                : const OutlineInputBorder(
                    borderRadius: borderRadius,
                    borderSide: BorderSide(color: AppColors.danger),
                  ),
            border: hideBorder
                ? InputBorder.none
                : const OutlineInputBorder(borderRadius: borderRadius),
          ),
          items: items.map((T value) {
            return DropdownMenuItem<T>(
              value: value,
              child: Text(
                itemToString != null ? itemToString!(value) : value.toString(),
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
