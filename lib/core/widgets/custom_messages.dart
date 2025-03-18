import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:islamy/config/res/constants_manager.dart';
import '../../config/res/app_sizes.dart';
import '../../config/res/color_manager.dart';
import '../navifation/go.dart';

class MessageUtils {
  static void showSnackBar(
    String message, {
    Color? backgroundColor,
    Color? textColor,
    BuildContext? context,
  }) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: ConstantManager.snackbarDuration),
      content: Text(
        message,
        style:
            TextStyle(color: textColor ?? Colors.red, fontSize: FontSize.s14),
      ),
      backgroundColor: backgroundColor ?? AppColors.white,
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context ?? Go.navigatorKey.currentContext!)
        .showSnackBar(snackBar);
  }

  static void showSimpleToast({
    required String msg,
    Color? color,
    Color? textColor,
  }) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: color ?? AppColors.primaryColor,
      textColor: textColor ?? AppColors.white,
      fontSize: FontSize.s16,
    );
  }
}
