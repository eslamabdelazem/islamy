import 'package:flutter/material.dart';
import 'package:islamy/presentation/resources/routes_manager.dart';
import 'package:islamy/presentation/resources/theme_manager.dart';
import 'core/helpers/state_builder/provider_state_builder.dart';
import 'presentation/splash/splash_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      minTextAdapt: true,
      child: MaterialApp(

        theme: getApplicationTheme(),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('ar'),
        ],
        locale: Locale('ar'),
        onGenerateRoute: RoutesGenerator.getRoute,
        initialRoute: Routes.splashRoute,
        debugShowCheckedModeBanner: false,
        home: const SplashView(),
      ),
    );
  }
}