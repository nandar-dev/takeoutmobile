import 'package:flutter/material.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class FilterChecksList<T> extends StatelessWidget {
  final List<T> data;
  final Set<int> selectedItemIds;
  final int Function(T) idGetter;
  final String Function(T) labelGetter;
  final void Function(int) onToggle;

  const FilterChecksList({
    super.key,
    required this.data,
    required this.selectedItemIds,
    required this.idGetter,
    required this.labelGetter,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SingleChildScrollView(
        child: Column(
          children: data.map((item) {
            final id = idGetter(item);
            final label = labelGetter(item);
            return CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              title: SubText(
                text: label,
                color: AppColors.textPrimary,
              ),
              value: selectedItemIds.contains(id),
              onChanged: (_) => onToggle(id),
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: AppColors.primary,
            );
          }).toList(),
        ),
      ),
    );
  }
}
