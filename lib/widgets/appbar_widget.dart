import 'package:flutter/material.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';

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
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Row(
        children: [
          if (showBackNavigator)
            GestureDetector(
              onTap: onBackTap ?? () => Navigator.of(context).pop(),
              child:
                  borderedBack
                      ? Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            width: 2,
                            color: AppColors.backkeyborder,
                          ),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_outlined,
                          size: 20,
                        ),
                      )
                      : const Icon(Icons.chevron_left, size: 28),
            )
          else
            const SizedBox(width: 50),

          const Spacer(),

          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: FontSizes.md,
              color: AppColors.neutral100,
            ),
          ),

          const Spacer(),

          rightAction ?? const SizedBox(width: 50),
        ],
      ),
    );
  }
}
