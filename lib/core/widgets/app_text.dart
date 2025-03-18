import 'package:flutter/material.dart';

import '../../config/res/app_sizes.dart';
import '../../config/res/constants_manager.dart';

class AppText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final double? height;
  const AppText(
    this.text, {
    super.key,
    this.color,
    this.fontSize,
    this.fontWeight = FontWeight.normal,
    this.overflow,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
        fontFamily: ConstantManager.fontFamily,
        color: color,
        fontSize: fontSize ?? FontSize.s16,
        fontWeight: fontWeight,
        height: height,
      ),
    );
  }
}
