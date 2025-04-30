import 'package:flutter/material.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class CustomRadioInput<T> extends StatelessWidget {
  final String label;
  final String? description;
  final T value;
  final T? groupValue;
  final ValueChanged<T?> onChanged;
  final bool disabled;
  final EdgeInsetsGeometry? padding;
  final bool showBorder;
  final Color? activeColor;
  final Color? inactiveColor;
  final double radioSize;
  final bool dense;

  const CustomRadioInput({
    super.key,
    required this.label,
    this.description,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.disabled = false,
    this.padding,
    this.showBorder = false,
    this.activeColor,
    this.inactiveColor,
    this.radioSize = 24.0,
    this.dense = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isSelected = value == groupValue;
    final colorScheme = theme.colorScheme;

    return Opacity(
      opacity: disabled ? 0.6 : 1.0,
      child: GestureDetector(
        onTap: disabled ? null : () => onChanged(value),
        behavior: HitTestBehavior.translucent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Custom radio circle
            Container(
              width: radioSize,
              height: radioSize,
              margin: EdgeInsets.only(right: dense ? 12.0 : 16.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? (activeColor ?? colorScheme.primary)
                      : (inactiveColor ?? AppColors.neutral50),
                  width: 2.0,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: isSelected
                    ? Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: activeColor ?? colorScheme.primary,
                        ),
                      )
                    : null,
              ),
            ),
        
            // Label and optional description
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SubText(
                    text: label,
                    fontSize: dense ? FontSizes.md : FontSizes.body,
                      fontWeight: FontWeight.w500,
                      color: disabled
                          ? AppColors.neutral60
                          : AppColors.textPrimary,
                  ),
                  if (description != null) ...[
                    const SizedBox(height: 4),
                    SubText(
                      text: description!,
                      fontSize: FontSizes.sm,
                        color: AppColors.neutral60,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
