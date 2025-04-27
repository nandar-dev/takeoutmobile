import 'package:easy_localization/easy_localization.dart';
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
import 'package:takeout/widgets/render_svg_icon.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<Map<String, dynamic>> languages = [
    {"id": 'en', "label": "English", "icon": "🇺🇸"},
    {"id": 'zh', "label": "Chinese", "icon": "🇨🇳"},
    {"id": 'my', "label": "Myanmar", "icon": "🇲🇲"},
    {"id": 'th', "label": "Thai", "icon": "🇹🇭"},
  ];

  void _handleCustomPop() {
    Navigator.pushNamed(
      context,
      AppRoutes.appNavigation,
      arguments: {'initialIndex': 2},
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _handleCustomPop();
        }
      },
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          final selectedLang = languages.firstWhere(
            (lang) => lang['id'] == state.selectedLanguageId,
            orElse: () => {"label": "Unknown"},
          );
          return Scaffold(
            appBar: AppBarWidget(
              title: 'profile.setting'.tr(),
              onBackTap: _handleCustomPop,
            ),
            body: SafeArea(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  const SizedBox(height: 12),
                  _buildSectionTitle("profile.profile".tr()),
                  const SizedBox(height: 5),
                  SettingsTile(
                    title: "profile.language".tr(),
                    onTap: () => _showChangeLanguageSheet(
                      context,
                      state.selectedLanguageId,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SubText(
                          text: selectedLang['label'],
                          fontSize: FontSizes.body,
                        ),
                        const SizedBox(width: 15),
                        RenderSvgIcon(
                          assetName: "assets/icons/chevron_right.svg",
                          color: AppColors.neutral90,
                          size: 12,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildSectionTitle("profile.other".tr()),
                  const SizedBox(height: 5),
                  SettingsTile(
                    title: "profile.aboutTicket".tr(),
                    trailing: RenderSvgIcon(
                      assetName: "assets/icons/chevron_right.svg",
                      color: AppColors.neutral90,
                      size: 12,
                    ),
                  ),
                  const SizedBox(height: 5),
                  SettingsTile(
                    title: "profile.privacyPolicy",
                    trailing: RenderSvgIcon(
                      assetName: "assets/icons/chevron_right.svg",
                      color: AppColors.neutral90,
                      size: 12,
                    ),
                  ),
                  const SizedBox(height: 5),
                  SettingsTile(
                    title: "profile.termsConditions",
                    trailing: RenderSvgIcon(
                      assetName: "assets/icons/chevron_right.svg",
                      color: AppColors.neutral90,
                      size: 12,
                    ),
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
      isScrollControlled: true,
      backgroundColor: AppColors.neutral10,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.55,
          minChildSize: 0.3,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleText(
                    text: "Select Language",
                    fontSize: FontSizes.heading2,
                  ),
                  const SizedBox(height: 16),
                  ...languages.map((lang) {
                    return LanguageTile(
                      icon: lang['icon'],
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
                  }),
                  const SizedBox(height: 12),
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
      },
    );
  }
  
}

class LanguageTile extends StatelessWidget {
  final String icon;
  final String label;
  final bool? isSelected;
  final VoidCallback? onTap;

  const LanguageTile({
    super.key,
    required this.icon,
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
              child: TitleText(text: icon, fontSize: FontSizes.heading3,),
            ),
            const SizedBox(width: 16),
            SubText(
              text: label,
              fontSize: FontSizes.body,
              color: AppColors.neutral70,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
        trailing: isSelected == true
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
        title.tr(),
        style: const TextStyle(
          fontSize: FontSizes.body,
          color: AppColors.textPrimary,
        ),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
