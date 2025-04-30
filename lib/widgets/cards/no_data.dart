import 'package:flutter/material.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/render_svg_icon.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class NoData extends StatelessWidget {
  const NoData({
    super.key,
    required this.noData,
    required this.noDataDes,
    this.icon,
    this.backgroundColor,
  });

  final String noData;
  final String noDataDes;
  final dynamic icon;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    Widget iconWidget;

    if (icon is IconData) {
      iconWidget = Icon(icon, color: AppColors.neutral50);
    } else if (icon is String) {
      iconWidget = RenderSvgIcon(
        assetName: icon,
        color: AppColors.neutral50,
      );
    } else {
      iconWidget = Icon(Icons.calendar_month_outlined, color: AppColors.neutral50);
    }

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.neutral20,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              iconWidget,
              SizedBox(height: 12),
              SubText(text: noData),
              SizedBox(height: 8),
              SubText(
                text: noDataDes,
                fontSize: FontSizes.sm,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
