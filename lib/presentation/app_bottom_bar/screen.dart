import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy/config/res/color_manager.dart';
import 'package:islamy/presentation/home/presentation/screens/home_screen/home.dart';
import 'package:islamy/presentation/prayer_consumer/presentation/screens/main.dart';

import '../../generated/locale_keys.g.dart';
import '../Settings/settings.dart';
import '../qibla/screen.dart';

class AppBottomBar extends StatefulWidget {
  const AppBottomBar({super.key});

  @override
  State<AppBottomBar> createState() => AppBottomBarState();
}

class AppBottomBarState extends State<AppBottomBar> {
  final List<Widget> screens = const [
    HomeScreen(),
    QiblaScreen(),
    PrayerConsumer(),
    SettingsScreen()
  ];

  int currentPage = 0;
  void changeScreen(int newPage) => setState(() => currentPage = newPage);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 100.h,
        child: BottomNavigationBar(
          currentIndex: currentPage,
          unselectedIconTheme: IconThemeData(color: Colors.grey, size: 20.sp),
          selectedIconTheme: IconThemeData(color: AppColors.primaryColor, size: 30.sp),
          onTap: changeScreen,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.mosque_outlined),
                label: LocaleKeys.home.tr()
              ),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.directions),
                  label: 'LocaleKeys.qibla.tr()'
              ),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.watch_later_outlined),
                  label: LocaleKeys.prayer_times.tr()
              ),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.settings),
                  label: LocaleKeys.setting.tr()
              ),
            ]
        ),
      ),
      body: screens[currentPage],
    );
  }
}
