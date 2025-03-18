import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

import '../network/log_interceptor.dart';
import 'image_widgets/cached_image.dart';

/// A versatile widget that handles different types of icons (IconData, SVG, network images, Lottie animations, and asset images)
class IconWidget extends StatelessWidget {
  final dynamic icon;
  final Color? color;
  final double? height;
  final double? width;
  final BoxFit? fit;

  const IconWidget({
    super.key,
    required this.icon,
    this.color,
    this.height,
    this.width,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    try {
      if (icon is IconData) {
        return Icon(
          icon as IconData,
          size: height ?? 24.r,
          color: color,
        );
      }

      if (icon is! String) {
        logDebug(
          'IconWidget: Unsupported icon type ${icon.runtimeType}',
          level: Level.error,
        );
        return const SizedBox.shrink();
      }

      final String iconPath = icon as String;
      final double defaultSize = 24.r;

      if (iconPath.endsWith('.svg')) {
        return SvgPicture.asset(
          iconPath,
          height: height ?? defaultSize,
          width: width ?? defaultSize,
          fit: fit ?? BoxFit.contain,
          colorFilter:
              color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        );
      }

      if (iconPath.startsWith('http')) {
        return CachedImage(
          url: iconPath,
          height: height ?? defaultSize,
          width: width ?? defaultSize,
          fit: fit,
        );
      }

      if (iconPath.endsWith('.json')) {
        return Lottie.asset(
          iconPath,
          height: height ?? defaultSize,
          width: width ?? defaultSize,
          fit: fit ?? BoxFit.contain,
        );
      }

      return Image.asset(
        iconPath,
        height: height ?? defaultSize,
        width: width ?? defaultSize,
        fit: fit,
      );
    } catch (e) {
      logDebug('IconWidget: Error rendering icon - $e', level: Level.error);
      return const SizedBox.shrink();
    }
  }
}
