
import 'package:flutter/material.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class AppbarWidget2 extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget2({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: const Icon(Icons.chevron_left),
      ),
      centerTitle: true,
      backgroundColor: AppColors.background,
      elevation: 0,
      title: SubText(
        text: title,
        fontSize: FontSizes.heading3,
        color: AppColors.textPrimary,
      ),
    );
  }
}