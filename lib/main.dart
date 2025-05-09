import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy/core/helpers/helpers.dart';
import 'package:islamy/presentation/fav/data/data_src/data_source.dart';
import 'package:islamy/presentation/fav/data/data_src/repo.dart';
import 'config/language/languages.dart';
import 'core/helpers/cache_service.dart';
import 'core/shared/service_locator.dart';
import 'my_app.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final objectBox = await LocalDatabase.create();
  Helpers.setFavRepo(objectBox);

  await Future.wait(
    [
      Helpers.initWorkManager(),
      EasyLocalization.ensureInitialized(),
      CacheStorage.init(),
      ScreenUtil.ensureScreenSize()
    ],
  );
  setUpServiceLocator();
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
      child:const MyApp()
    ),
  );
}