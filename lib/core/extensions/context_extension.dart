import 'package:flutter/material.dart';

import '../../config/language/languages.dart';
import '../../config/res/constants_manager.dart';

extension ContextExtension on BuildContext {
  void hideKeyboard() {
    FocusScope.of(this).unfocus();
  }

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  double get width => mediaQuery.size.width;

  double get height => mediaQuery.size.height;

  bool get isKeyboardOpen =>
      MediaQuery.of(this).viewInsets.bottom > ConstantManager.zero;

  bool get isPortrait => mediaQuery.orientation == Orientation.portrait;

  bool get isDark => theme.brightness == Brightness.dark;

  bool get isLight => theme.brightness == Brightness.light;

  bool get isMaterial => theme.platform == TargetPlatform.android;
}

extension LanguageExtension on Widget {
  Widget overRideLocalization(
      {required BuildContext context, required Languages lang}) {
    return Localizations.override(
      context: context,
      locale: lang.locale,
      child: this,
    );
  }
}
