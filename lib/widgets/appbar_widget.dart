import 'package:flutter/material.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackTap;
  final Widget? rightAction;
  final bool showBackNavigator;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onBackTap,
    this.rightAction,
    this.showBackNavigator = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          showBackNavigator
              ? GestureDetector(
                onTap: onBackTap ?? () => Navigator.of(context).pop(),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      width: 2,
                      color: AppColors.backkeyborder,
                    ),
                  ),
                  child: const Icon(Icons.arrow_back_ios_outlined, size: 20),
                ),
              )
              : SizedBox(width: 50),
          const Spacer(),

          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: FontSizes.heading3,
              color: AppColors.neutral100,
            ),
          ),

          const Spacer(),

          rightAction ?? const SizedBox(width: 50),
        ],
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
