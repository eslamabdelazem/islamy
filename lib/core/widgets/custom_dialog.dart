import 'package:flutter/material.dart';

import '../../config/res/app_sizes.dart';
import '../../config/res/color_manager.dart';
import '../../config/res/constants_manager.dart';

Future showCustomDialog(BuildContext context,
    {required Widget child,
      Duration? duration,
      Function? actionWhenPop,
    BorderRadiusGeometry? borderRadius,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    bool barrierDismissible = true,
    Color? color}) async {
  showGeneralDialog(
    context: context,
    barrierLabel: ConstantManager.emptyText,
    barrierDismissible: barrierDismissible,
    barrierColor: Colors.black.withValues(alpha: 0.5),
    transitionDuration: const Duration(milliseconds: 250),
    pageBuilder: (_, __, ___) {
      return Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: double.infinity,
            margin: margin ?? EdgeInsets.symmetric(horizontal: AppPadding.pH20),
            padding: padding ?? EdgeInsets.all(AppPadding.pH20),
            decoration: BoxDecoration(
              color: color ?? AppColors.white,
              borderRadius: borderRadius ?? BorderRadius.circular(AppSize.sH25),
            ),
            child: child,
          ),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      return ScaleTransition(
        scale: anim,
        child: FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    },
  );

  if(duration != null){
    Future.delayed(
        duration, () {
      if (context.mounted) {
        Navigator.pop(context);
        if(actionWhenPop != null){
          actionWhenPop();
        }
      }
    });
  }
}
