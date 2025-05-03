import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/widgets/buttons/primarybutton_widget.dart';
import 'package:takeout/widgets/formfields/customtextfield_widget.dart';

class MultilingualAddressDescription extends StatefulWidget {
  final List<Map<String, dynamic>> languages;
  final String requiredLangCode;
  final Map<String, TextEditingController> addressControllers;
  final Map<String, TextEditingController> descriptionControllers;

  const MultilingualAddressDescription({
    super.key,
    required this.languages,
    required this.requiredLangCode,
    required this.addressControllers,
    required this.descriptionControllers,
  });

  @override
  State<MultilingualAddressDescription> createState() =>
      _MultilingualAddressDescriptionState();
}

class _MultilingualAddressDescriptionState
    extends State<MultilingualAddressDescription> {
  late String selectedLanguage;
  late int previousLangIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedLanguage = widget.requiredLangCode;
    previousLangIndex = widget.languages
        .indexWhere((lang) => lang["label"] == selectedLanguage);
  }

  @override
  Widget build(BuildContext context) {
    final currentLangIndex = widget.languages
        .indexWhere((lang) => lang["label"] == selectedLanguage);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Language selection buttons
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
                    final nextIndex = widget.languages
                        .indexWhere((l) => l["label"] == code);
                    if (nextIndex != -1 && code != selectedLanguage) {
                      setState(() {
                        previousLangIndex = currentLangIndex;
                        selectedLanguage = code;
                      });
                    }
                  },
                  height: 40,
                  fontSize: 14,
                  backgroundColor: selectedLanguage == code
                      ? AppColors.primaryDark
                      : AppColors.neutral30,
                  textColor: selectedLanguage == code
                      ? AppColors.textLight
                      : AppColors.textPrimary,
                  borderRadius: 8,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 24),

        // AnimatedSwitcher with directional offset
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          switchInCurve: Curves.easeOut,
          switchOutCurve: Curves.easeIn,
          transitionBuilder: (Widget child, Animation<double> animation) {
            final isForward = currentLangIndex > previousLangIndex;
            final offset = isForward ? const Offset(1, 0) : const Offset(-1, 0);

            return SlideTransition(
              position: animation.drive(
                Tween<Offset>(
                  begin: offset,
                  end: Offset.zero,
                ),
              ),
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
          child: Column(
            key: ValueKey(selectedLanguage),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                label: "",
                hint:
                    "merchant_shop.address_placeholder_$selectedLanguage".tr() +
                        (selectedLanguage == widget.requiredLangCode ? " *" : ""),
                controller: widget.addressControllers[selectedLanguage],
                maxLines: 3,
                validator: (val) {
                  if (selectedLanguage == widget.requiredLangCode &&
                      (val == null || val.trim().isEmpty)) {
                    return "Address is required in English.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              CustomTextField(
                label: "",
                hint:
                    "merchant_shop.description_placeholder_$selectedLanguage"
                        .tr() +
                        (selectedLanguage == widget.requiredLangCode ? " *" : ""),
                controller: widget.descriptionControllers[selectedLanguage],
                maxLines: 3,
                validator: (val) {
                  if (selectedLanguage == widget.requiredLangCode &&
                      (val == null || val.trim().isEmpty)) {
                    return "Description is required in English.";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
