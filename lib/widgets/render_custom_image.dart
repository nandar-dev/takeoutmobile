import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:takeout/theme/app_colors.dart';

class RenderCustomImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double height;
  final double? rounded;

  const RenderCustomImage({
    super.key,
    required this.imageUrl,
    this.width,
    required this.height,
    this.rounded,
  });

  bool get isNetworkImage =>
      imageUrl.startsWith('http') || imageUrl.startsWith('https');

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(rounded ?? 5);

    final bool isEmpty = imageUrl.trim().isEmpty;

    return ClipRRect(
      borderRadius: borderRadius,
      child:
          isEmpty
              ? NoImage(width: width, height: height, rounded: rounded)
              : isNetworkImage
              ? CachedNetworkImage(
                imageUrl: imageUrl,
                width: width ?? double.infinity,
                height: height,
                fit: BoxFit.cover,
                placeholder:
                    (context, url) =>
                        NoImage(width: width, height: height, rounded: rounded),
                errorWidget:
                    (context, url, error) =>
                        NoImage(width: width, height: height, rounded: rounded),
              )
              : Image.asset(
                imageUrl.isEmpty
                    ? 'assets/images/image_placeholder.jpg'
                    : imageUrl,
                width: width ?? double.infinity,
                height: height,
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) =>
                        NoImage(width: width, height: height, rounded: rounded),
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
