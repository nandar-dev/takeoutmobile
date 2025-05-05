import 'package:flutter/material.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class TimePicker extends StatelessWidget {
  final String label;
  final TimeOfDay? selectedTime;
  final ValueChanged<TimeOfDay> onTimeSelected;
  final bool enabled;

  const TimePicker({
    super.key,
    required this.label,
    required this.selectedTime,
    required this.onTimeSelected,
    this.enabled = true,
  });

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay now = TimeOfDay.now();
    final TimeOfDay initialTime = selectedTime ?? now;

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: AppColors.neutral20,
              onSurface: AppColors.neutral100,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedTime) {
      onTimeSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayTime = selectedTime != null
        ? selectedTime!.format(context)
        : "HH:MM";

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
        if (label.isNotEmpty) const SizedBox(height: 8),
        InkWell(
          onTap: enabled ? () => _selectTime(context) : null,
          child: InputDecorator(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.neutral40),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.primary),
              ),
              suffixIcon: const Icon(Icons.access_time),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 12,
              ),
            ),
            child: Text(
              displayTime,
              style: TextStyle(
                color: enabled
                    ? AppColors.neutral100
                    : AppColors.neutral60,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
