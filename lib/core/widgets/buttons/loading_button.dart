import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../config/res/app_sizes.dart';
import '../../../config/res/color_manager.dart';
import '../../../config/res/constants_manager.dart';
import 'custom_animated_button.dart';

class LoadingButton extends StatelessWidget {
  final String title;
  final Future<void> Function() onTap;
  final Color? textColor;
  final Color? color;
  final BorderSide borderSide;
  final double? borderRadius;
  final EdgeInsets? margin;
  final double? width;
  final double? height;
  final double? fontSize;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final Color? loaderColor;

  const LoadingButton({
    super.key,
    required this.title,
    required this.onTap,
    this.color,
    this.textColor,
    this.borderRadius,
    this.margin,
    this.borderSide = BorderSide.none,
    this.fontFamily,
    this.fontSize,
    this.width,
    this.height,
    this.fontWeight,
    this.loaderColor
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ??
          EdgeInsets.symmetric(
            horizontal: AppMargin.mW10,
            vertical: AppMargin.mH10,
          ),
      child: CustomAnimatedButton(
        onTap: onTap,
        width: width ?? MediaQuery.sizeOf(context).width,
        minWidth: AppSize.sW50,
        height: height ?? AppSize.sH50,
        color: color ?? AppColors.primaryColor,
        borderRadius: borderRadius ?? AppSize.sH40,
        disabledColor: color ?? AppColors.primaryColor,
        borderSide: borderSide,
        loader: CupertinoActivityIndicator(
          color: loaderColor??Colors.white,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: fontWeight,
            fontFamily: ConstantManager.fontFamily,
            color: textColor ?? Colors.white,
            fontSize: fontSize ?? FontSize.s14,
          ),
        ),
      ),
    );
  }
}
