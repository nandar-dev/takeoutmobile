import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takeout/bloc/language/bloc.dart';
import 'package:takeout/bloc/language/event.dart';
import 'package:takeout/bloc/language/state.dart';
import 'package:takeout/pages/routing/routes.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/appbar_widget.dart';
import 'package:takeout/widgets/buttons/primarybutton_widget.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _allowedLocation = true;
  List<Map<String, dynamic>> languages = [
    {"id": 'en', "label": "English (US)", "icon": "assets/icons/eng.png"},
    {"id": 'zh', "label": "Chinese", "icon": "assets/icons/cn.png"},
  ];

  Future<bool> _onWillPop() async {
    Navigator.pushNamed(
      context,
      AppRoutes.appNavigation,
      arguments: {'initialIndex': 2},
    );
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          final selectedLang = languages.firstWhere(
            (lang) => lang['id'] == state.selectedLanguageId,
            orElse: () => {"label": "Unknown"},
          );
          return Scaffold(
            appBar: AppBarWidget(
              title: 'profile.setting'.tr(),
              onBackTap: _onWillPop,
            ),
            body: SafeArea(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  const SizedBox(height: 32),
                  _buildSectionTitle("PROFILE"),
                  const SizedBox(height: 8),

                  SettingsTile(
                    title: "Location",
                    trailing: CupertinoSwitch(
                      activeColor: AppColors.primary,
                      value: _allowedLocation,
                      onChanged:
                          (value) => setState(() => _allowedLocation = value),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // BlocBuilder<LanguageBloc, LanguageState>(
                  //   builder: (context, state) {
                  SettingsTile(
                    title: "Language",
                    onTap:
                        () => _showChangeLanguageSheet(
                          context,
                          state.selectedLanguageId,
                        ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          selectedLang['label'],
                          style: const TextStyle(
                            fontSize: FontSizes.body,
                            color: AppColors.neutral100,
                          ),
                        ),
                        const Icon(Icons.chevron_right_rounded),
                      ],
                    ),
                  ),

                  //   },
                  // ),
                  const SizedBox(height: 66),
                  _buildSectionTitle("OTHER"),
                  const SizedBox(height: 8),

                  const SettingsTile(
                    title: "About Ticketis",
                    trailing: Icon(Icons.chevron_right_rounded),
                  ),
                  const SizedBox(height: 8),

                  const SettingsTile(
                    title: "Privacy Policy",
                    trailing: Icon(Icons.chevron_right_rounded),
                  ),
                  const SizedBox(height: 8),

                  const SettingsTile(
                    title: "Terms and Conditions",
                    trailing: Icon(Icons.chevron_right_rounded),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: FontSizes.sm,
        color: AppColors.neutral60,
      ),
    );
  }

  void _showChangeLanguageSheet(BuildContext context, String selectedId) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.neutral10,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleText(
                text: "Select Language",
                fontSize: FontSizes.heading2,
              ),
              const SizedBox(height: 16),
              ListView.builder(
                itemCount: languages.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final lang = languages[index];
                  return LanguageTile(
                    iconPath: lang['icon'],
                    label: lang['label'],
                    isSelected: selectedId == lang['id'],
                    onTap: () {
                      context.setLocale(Locale(lang['id']));
                      context.read<LanguageBloc>().add(
                        SetLanguageEvent(lang['id']),
                      );
                      Navigator.pop(context);
                    },
                  );
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: CustomPrimaryButton(
                  text: "Close",
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class LanguageTile extends StatelessWidget {
  final String iconPath;
  final String label;
  final bool? isSelected;
  final VoidCallback? onTap;

  const LanguageTile({
    super.key,
    required this.iconPath,
    required this.label,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected == true ? AppColors.primary : AppColors.neutral30,
        ),
      ),
      child: ListTile(
        focusColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                shape: BoxShape.circle,
              ),
              child: Image.asset(iconPath, width: 24, height: 24),
            ),
            const SizedBox(width: 16),
            Text(
              label,
              style: const TextStyle(
                fontSize: FontSizes.body,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        trailing:
            isSelected == true
                ? const Icon(Icons.check_circle, color: AppColors.primary)
                : null,
        onTap: onTap,
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  final String title;
  final Widget trailing;
  final VoidCallback? onTap;

  const SettingsTile({
    super.key,
    required this.title,
    required this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: FontSizes.body,
          color: AppColors.neutral100,
        ),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
