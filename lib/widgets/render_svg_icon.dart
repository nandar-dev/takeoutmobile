import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RenderSvgIcon extends StatelessWidget {
  final String assetName;
  final double size;
  final Color color;

  const RenderSvgIcon({
    super.key,
    required this.assetName,
    this.size = 24.0,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      height: size,
      width: size,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}
