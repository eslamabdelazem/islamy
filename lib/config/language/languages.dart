import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/navifation/go.dart';


enum Languages {
  english(Locale('en'), 'English', "en"),
  arabic(Locale('ar'), 'Arabic', "ar");

  final String title;
  final Locale locale;
  final String languageCode;

  const Languages(
    this.locale,
    this.title,
    this.languageCode,
  );

  static List<Locale> get suppoerLocales =>
      Languages.values.map((e) => e.locale).toList();

  static List<String> get titles =>
      Languages.values.map((e) => e.title).toList();

  static setLocale(Languages lang) {
    Go.navigatorKey.currentContext!.setLocale(lang.locale);
  }

  static setLocaleWithContext(BuildContext context, Languages lang) {
    context.setLocale(lang.locale);
  }

  static String getLanguageCode(Languages language) {
    return language.locale.languageCode;
  }

  static Languages get currentLanguage {
    final currentLocale =
        EasyLocalization.of(Go.navigatorKey.currentContext!)!.locale;
    return Languages.values
        .firstWhere((element) => element.locale == currentLocale);
  }
}
