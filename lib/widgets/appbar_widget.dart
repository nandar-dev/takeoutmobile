import 'package:flutter/material.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/buttons/iconbutton_one_widget.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackTap;
  final Widget? rightAction;
  final bool showBackNavigator;
  final bool borderedBack;

  const AppBarWidget({
    super.key,
    required this.title,
    this.onBackTap,
    this.rightAction,
    this.showBackNavigator = true,
    this.borderedBack = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      surfaceTintColor: AppColors.background,
      backgroundColor: AppColors.background,
      elevation: 0,
      centerTitle: true,
      title: Row(
        children: [
          if (showBackNavigator)
            borderedBack
                ? IconButtonOneWidget(
                  icon: "assets/icons/chevron_left.svg",
                  onTap: onBackTap ?? () => Navigator.of(context).pop(),
                  borderColor: AppColors.neutral40,
                  iconColor: AppColors.neutral90,
                  iconSize: 15,
                )
                : IconButtonOneWidget(
                  icon: "assets/icons/chevron_left.svg",
                  onTap: onBackTap ?? () => Navigator.of(context).pop(),
                  iconColor: AppColors.neutral90,
                  iconSize: 15,
                )
          else
            const SizedBox(width: 50),

          const Spacer(),

          SizedBox(
            width: 250,
            child: Center(
              child: TitleText(
                text: title,
                color: AppColors.textPrimary,
                fontSize: FontSizes.md,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
            ),
          ),

          const Spacer(),

          rightAction ?? const SizedBox(width: 50),
        ],
      ),
    );
  }
}
