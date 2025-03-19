import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy/presentation/Prayer_times/prayer_time.dart';
import 'package:islamy/presentation/Settings/settings.dart';
import 'config/language/languages.dart';
import 'core/helpers/cache_service.dart';
import 'my_app.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait(
    [
      EasyLocalization.ensureInitialized(),
      CacheStorage.init(),
      ScreenUtil.ensureScreenSize()
    ],
  );
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  runApp(
    EasyLocalization(
      supportedLocales: Languages.suppoerLocales,
      path: 'assets/translations',
      startLocale: const Locale('ar'),
      saveLocale: true,
      fallbackLocale: const Locale('ar'),
      child:const PrayerTimeScreen()
    ),
  );
}

