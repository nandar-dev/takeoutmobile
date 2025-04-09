import 'package:flutter/material.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RenderNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double height;
  final double? rounded;

  const RenderNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    required this.height,
    this.rounded,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(rounded ?? 5),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width ?? double.infinity,
        height: height,
        fit: BoxFit.cover,
        placeholder: (context, url) => NoImage(width: width, height: height, rounded: rounded),
        errorWidget: (context, url, error) => NoImage(width: width, height: height, rounded: rounded),
      ),
    );
  }
}

class NoImage extends StatelessWidget {
  final double? width;
  final double height;
  final double? rounded;
  final IconData? icon;

  const NoImage({
    super.key,
    this.icon,
    this.width,
    this.rounded,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.neutral20,
        borderRadius: BorderRadius.circular(rounded ?? 5),
      ),
      width: width ?? double.infinity,
      height: height,
    );
  }
}
