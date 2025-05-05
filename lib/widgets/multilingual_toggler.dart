import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/widgets/buttons/primarybutton_widget.dart';
import 'package:takeout/widgets/formfields/customtextfield_widget.dart';

class MultilingualToggler extends StatefulWidget {
  final List<Map<String, dynamic>> languages;
  final String requiredLangCode;
  final List<String> fields;
  final Map<String, Map<String, TextEditingController>> controllers;

  const MultilingualToggler({
    super.key,
    required this.languages,
    required this.requiredLangCode,
    required this.fields,
    required this.controllers,
  });

  @override
  State<MultilingualToggler> createState() => _MultilingualTogglerState();
}

class _MultilingualTogglerState extends State<MultilingualToggler> {
  late String selectedLanguage;
  late int previousLangIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedLanguage = widget.requiredLangCode;
    previousLangIndex = widget.languages.indexWhere((lang) => lang["label"] == selectedLanguage);
  }

  @override
  Widget build(BuildContext context) {
    final currentLangIndex = widget.languages.indexWhere((lang) => lang["label"] == selectedLanguage);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Language Toggle Buttons
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: widget.languages.map((lang) {
              final code = lang["label"];
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: CustomPrimaryButton(
                  text: '${lang["icon"]} ${"language.$code".tr()}',
                  onPressed: () {
                    final nextIndex = widget.languages.indexWhere((l) => l["label"] == code);
                    if (nextIndex != -1 && code != selectedLanguage) {
                      setState(() {
                        previousLangIndex = currentLangIndex;
                        selectedLanguage = code;
                      });
                    }
                  },
                  height: 40,
                  fontSize: 14,
                  backgroundColor: selectedLanguage == code ? AppColors.primaryDark : AppColors.neutral30,
                  textColor: selectedLanguage == code ? AppColors.textLight : AppColors.textPrimary,
                  borderRadius: 8,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 24),

        // Language-specific Fields
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          switchInCurve: Curves.easeOut,
          switchOutCurve: Curves.easeIn,
          transitionBuilder: (child, animation) {
            final isForward = currentLangIndex > previousLangIndex;
            final offset = isForward ? const Offset(1, 0) : const Offset(-1, 0);
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: animation.drive(Tween<Offset>(begin: offset, end: Offset.zero)),
                child: FadeTransition(opacity: animation, child: child),
              ),
            );
          },
          child: Column(
            key: ValueKey(selectedLanguage),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.fields.map((fieldName) {
              final controller = widget.controllers[selectedLanguage]?[fieldName];
              final placeholderKey = 'input.${fieldName}_placeholder_$selectedLanguage'.tr();
              final isRequired = selectedLanguage == widget.requiredLangCode;

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: CustomTextField(
                  label: "",
                  hint: placeholderKey + (isRequired ? " (${"status.required".tr()})" : " (${"status.optional".tr()})"),
                  controller: controller,
                  maxLines: 3,
                  validator: (val) {
                    if (isRequired && (val == null || val.trim().isEmpty)) {
                      return "$fieldName is required in ${"language.$selectedLanguage".tr()}.";
                    }
                    return null;
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
