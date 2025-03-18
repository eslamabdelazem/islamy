import 'package:flutter/material.dart';
import '../../../config/res/app_sizes.dart';
import '../../../config/res/color_manager.dart';
import '../../../config/res/constants_manager.dart';

class DefaultButton extends StatelessWidget {
  final String? title;
  final Function()? onTap;
  final Color? textColor;
  final Color? color;
  final Color? borderColor;
  final BorderRadius? borderRadius;
  final EdgeInsets? margin;
  final double? width;
  final double? fontSize;
  final double? height;
  final double? elevation;
  final bool? disabled;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final Widget? customChild;
  final bool isFitted;

  const DefaultButton({
    super.key,
    this.title,
    this.onTap,
    this.color,
    this.disabled,
    this.textColor,
    this.borderRadius,
    this.margin,
    this.borderColor,
    this.fontFamily,
    this.fontSize,
    this.width,
    this.height,
    this.fontWeight,
    this.elevation,
    this.customChild,
    this.isFitted = true,
  });

  Widget get _defaultChild => Text(
        title ?? 'Click!',
        style: TextStyle(
          color: textColor ?? Colors.white,
          fontSize: fontSize ?? FontSize.s16,
          fontFamily: fontFamily,
          fontWeight: fontWeight ?? FontWeight.w500,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ??
          EdgeInsets.symmetric(
            horizontal: AppMargin.mW10,
            vertical: AppMargin.mH4,
          ),
      child: SizedBox(
        width: width ?? MediaQuery.of(context).size.width,
        height: height ?? AppSize.sH60,
        child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              splashFactory: InkRipple.splashFactory,
              surfaceTintColor: color ?? AppColors.primaryColor,
              foregroundColor: color ?? AppColors.primaryColor,
              backgroundColor: color ?? AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius:
                    borderRadius ?? BorderRadius.circular(AppSize.sH10),
                side: borderColor != null
                    ? BorderSide(
                        color: borderColor ?? AppColors.primaryColor,
                        width: 1,
                      )
                    : BorderSide.none,
              ),
              elevation: elevation ?? ConstantManager.zeroAsDouble,
            ),
            child: isFitted
                ? FittedBox(child: customChild ?? _defaultChild)
                : customChild ?? _defaultChild),
      ),
    );
  }
}
