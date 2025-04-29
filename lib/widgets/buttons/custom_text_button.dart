import 'package:flutter/material.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/typography_widgets.dart';
import 'package:takeout/widgets/render_svg_icon.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback onTapCallback;
  final String btnLabel;
  final Color? textColor;
  final Color? iconColor;
  final IconData? startIcon;
  final IconData? endIcon;
  final String? startSvgIcon;
  final String? endSvgIcon;

  const CustomTextButton({
    super.key,
    required this.btnLabel,
    required this.onTapCallback,
    this.textColor,
    this.iconColor,
    this.startIcon,
    this.endIcon,
    this.startSvgIcon,
    this.endSvgIcon,
  });

  Widget? _buildIcon({
    IconData? iconData,
    String? svgAsset,
    required Color color,
  }) {
    if (iconData != null) {
      return Icon(iconData, size: 10, color: color);
    } else if (svgAsset != null) {
      return RenderSvgIcon(assetName: svgAsset, size: 10, color: color);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final Color resolvedTextColor = textColor ?? AppColors.primary;
    final Color resolvedIconColor = iconColor ?? resolvedTextColor;

    final Widget? leading = _buildIcon(
      iconData: startIcon,
      svgAsset: startSvgIcon,
      color: resolvedIconColor,
    );

    final Widget? trailing = _buildIcon(
      iconData: endIcon,
      svgAsset: endSvgIcon,
      color: resolvedIconColor,
    );

    return GestureDetector(
      onTap: onTapCallback,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (leading != null) ...[
            leading,
            const SizedBox(width: 8),
          ],
          SubText(
            text: btnLabel,
            color: resolvedTextColor,
            fontSize: FontSizes.body,
            fontWeight: FontWeight.w600,
          ),
          if (trailing != null) ...[
            const SizedBox(width: 8),
            trailing,
          ],
        ],
      ),
    );
  }
}
