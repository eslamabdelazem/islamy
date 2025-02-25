
import 'package:flutter/painting.dart';

import 'font_manager.dart';

  TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
    return TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight);
  }
  TextStyle getRegularStyle(
      {double fontSize = FontSize.s12, required Color color}) {
    return _getTextStyle(fontSize, FontWeightManager.regular, color);
  }

  TextStyle getSemiBoldStyle(
      {double fontSize = FontSize.s12, required Color color}) {
    return _getTextStyle(fontSize, FontWeightManager.semiBold, color);
  }

  TextStyle getMediumStyle(
      {double fontSize = FontSize.s12, required Color color}) {
    return _getTextStyle(fontSize, FontWeightManager.medium, color);
  }

  TextStyle getLightStyle(
      {double fontSize = FontSize.s12, required Color color}) {
    return _getTextStyle(fontSize, FontWeightManager.light, color);
  }

