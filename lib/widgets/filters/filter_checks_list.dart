import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class FilterChecksList<T> extends StatelessWidget {
  final List<T> data;
  final Set<int> selectedItemIds;
  final int Function(T) idGetter;
  final String Function(T) labelGetter;
  final void Function(int) onToggle;
  final bool isLoading;

  const FilterChecksList({
    super.key,
    required this.data,
    required this.selectedItemIds,
    required this.idGetter,
    required this.labelGetter,
    required this.onToggle,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SingleChildScrollView(
        child: Skeletonizer(
          enabled: isLoading,
          child: Column(
            children:
                data.map((item) {
                  final id = idGetter(item);
                  final label = labelGetter(item);
                  return CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: SubText(text: label, color: AppColors.textPrimary),
                    value: selectedItemIds.contains(id),
                    onChanged: (_) => onToggle(id),
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: AppColors.primary,
                  );
                }).toList(),
          ),
        ),
      ),
    );
  }
}
