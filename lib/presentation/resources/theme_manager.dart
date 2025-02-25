import 'package:flutter/material.dart';
import 'package:islamy/presentation/resources/styles_manager.dart';
import 'package:islamy/presentation/resources/values_manager.dart';


import 'color_manager.dart';
import 'font_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    //main colors
    primaryColor: ColorManager.primary,
    //appbar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.primary,
      elevation: AppSize.s4,
      titleTextStyle:
          getRegularStyle(color: ColorManager.primary, fontSize: FontSize.s16)
              as TextStyle?,
    ),
    //text theme
    textTheme: TextTheme(
        headlineLarge: getSemiBoldStyle(
            color: ColorManager.primary, fontSize: FontSize.s16),
        headlineMedium:getRegularStyle(
            color: ColorManager.primary, fontSize: FontSize.s14) ,
        titleMedium: getMediumStyle(
            color: ColorManager.primary, fontSize: FontSize.s14),
        bodySmall: getRegularStyle(color: ColorManager.primary),
        displayLarge:
            getSemiBoldStyle(color: ColorManager.primary, fontSize: FontSize.s16),
        bodyLarge: getRegularStyle(color: ColorManager.primary)),

  );
}
