import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A reusable widget for displaying custom SVG icons
/// 
/// Usage:
/// ```dart
/// CustomSvgIcon(
///   assetName: 'assets/icons/home.svg',
///   size: 24,
///   color: Colors.blue,
/// )
/// ```
class CustomSvgIcon extends StatelessWidget {
  /// The path to the SVG asset file
  final String assetName;

  /// The size of the icon (width and height will be the same)
  final double? size;

  /// The width of the icon (overrides size if specified)
  final double? width;

  /// The height of the icon (overrides size if specified)
  final double? height;

  /// The color to apply to the icon
  final Color? color;

  /// The fit mode for the SVG
  final BoxFit fit;

  /// The alignment of the SVG
  final Alignment alignment;

  /// Semantic label for accessibility
  final String? semanticsLabel;

  const CustomSvgIcon({
    super.key,
    required this.assetName,
    this.size,
    this.width,
    this.height,
    this.color,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      width: (width ?? size ?? 24).w,
      height: (height ?? size ?? 24).h,
      colorFilter: color != null
          ? ColorFilter.mode(color!, BlendMode.srcIn)
          : null,
      fit: fit,
      alignment: alignment,
      semanticsLabel: semanticsLabel,
      placeholderBuilder: (BuildContext context) => Container(
        width: (width ?? size ?? 24).w,
        height: (height ?? size ?? 24).h,
        color: Colors.grey.withAlpha(10),
      ),
    );
  }
}

/// A convenient extension for quick icon creation
extension CustomSvgIconExtension on String {
  /// Convert a string path to a CustomSvgIcon widget
  /// 
  /// Example: 'assets/icons/home.svg'.toSvgIcon(size: 24, color: Colors.blue)
  Widget toSvgIcon({
    double? size,
    double? width,
    double? height,
    Color? color,
    BoxFit fit = BoxFit.contain,
    Alignment alignment = Alignment.center,
    String? semanticsLabel,
  }) {
    return CustomSvgIcon(
      assetName: this,
      size: size,
      width: width,
      height: height,
      color: color,
      fit: fit,
      alignment: alignment,
      semanticsLabel: semanticsLabel,
    );
  }
}
