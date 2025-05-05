import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/country_picker_dialog.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class CustomPhoneField extends StatelessWidget {
  final String label;
  final String hint;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final Function(String)? onCountryChanged;

  const CustomPhoneField({
    super.key,
    required this.label,
    required this.hint,
    this.focusNode,
    this.onChanged,
    this.onCountryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: SubText(
              text: label,
              color: AppColors.neutral80,
              fontSize: FontSizes.body,
              fontWeight: FontWeight.w500,
            ),
          ),
        IntlPhoneField(
          pickerDialogStyle: PickerDialogStyle(
            dialogPadding: EdgeInsets.all(12),
            listTilePadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            backgroundColor: AppColors.background,
          ),
          focusNode: focusNode,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(12),
            hintText: hint,
            hintStyle: const TextStyle(color: AppColors.neutral60),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.textfieldborder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.danger),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.danger),
            ),
          ),
          initialCountryCode: "MM",
          onChanged: (phone) => onChanged?.call(phone.completeNumber),
          onCountryChanged: (country) => onCountryChanged?.call(country.name),
        ),
      ],
    );
  }
}
