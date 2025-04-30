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
  final bool showLabelAbove;
  final IconData? prefixIcon;
  final Color? fillColor;
  final double elevation;
  final bool showShadow;

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
    this.showLabelAbove = true,
    this.prefixIcon,
    this.fillColor,
    this.elevation = 0,
    this.showShadow = false,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(12);
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty && showLabelAbove) ...[
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Text(
              label,
              style: TextStyle(
                fontSize: FontSizes.body,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 4),
        ],
        Material(
          elevation: showShadow ? 1 : 0,
          shadowColor: showShadow ? AppColors.neutral50 : Colors.transparent,
          borderRadius: borderRadius,
          child: DropdownButtonFormField<T>(
            isExpanded: true,
            value: value,
            validator: validator,
            style: TextStyle(
              fontSize: FontSizes.body,
              fontWeight: FontWeight.w500,
            ),
            dropdownColor: fillColor ?? AppColors.background,
            borderRadius: BorderRadius.circular(12),
            icon: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
            decoration: InputDecoration(
              filled: fillColor != null,
              fillColor: fillColor,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              hintText: hintText ?? 'Select an option',
              hintStyle: TextStyle(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                fontSize: FontSizes.body,
              ),
              prefixIcon: prefixIcon != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 12, right: 8),
                      child: Icon(
                        prefixIcon,
                        size: 20,
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    )
                  : null,
              enabledBorder: hideBorder
                  ? InputBorder.none
                  : OutlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide: BorderSide(
                        color: AppColors.neutral30,
                        width: 1,
                      ),
                    ),
              focusedBorder: hideBorder
                  ? InputBorder.none
                  : OutlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide: BorderSide(
                        color: theme.colorScheme.primary,
                        width: 1.5,
                      ),
                    ),
              errorBorder: hideBorder
                  ? InputBorder.none
                  : OutlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide: BorderSide(
                        color: theme.colorScheme.error,
                        width: 1.5,
                      ),
                    ),
              focusedErrorBorder: hideBorder
                  ? InputBorder.none
                  : OutlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide: BorderSide(
                        color: theme.colorScheme.error,
                        width: 1.5,
                      ),
                    ),
              border: hideBorder
                  ? InputBorder.none
                  : OutlineInputBorder(borderRadius: borderRadius),
            ),
            items: items.map((T value) {
              return DropdownMenuItem<T>(
                value: value,
                child: Text(
                  itemToString != null ? itemToString!(value) : value.toString(),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: FontSizes.body,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              );
            }).toList(),
            onChanged: onChanged,
            selectedItemBuilder: (BuildContext context) {
              return items.map<Widget>((T item) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    itemToString != null ? itemToString!(item) : item.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: FontSizes.body,
                      color: theme.colorScheme.onSurface,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList();
            },
          ),
        ),
      ],
    );
  }
}