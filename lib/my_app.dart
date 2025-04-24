import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:islamy/core/helpers/loading_manager.dart';
import 'package:islamy/core/widgets/offline_widget.dart';
import 'package:islamy/presentation/app_bottom_bar/screen.dart';
import 'package:islamy/presentation/home/presentation/screens/home_screen/home.dart';
import 'package:islamy/presentation/prayer_consumer/presentation/screens/main.dart';
import 'package:islamy/presentation/remembrances/presentation/screens/choose_remembrances_type.dart';
import 'config/res/constants_manager.dart';
import 'core/navifation/go.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MaterialApp(
        title: ConstantManager.projectName,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        navigatorKey: Go.navigatorKey,
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
        builder: (context, child) {
          return OfflineWidget(
            child: FullScreenLoadingManager(child: child!),
          );
        },

      ),
    );
  }
}