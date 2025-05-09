import 'package:flutter/material.dart';
import 'package:islamy/core/helpers/cache_service.dart';
import 'package:islamy/core/helpers/location.dart';
import 'package:islamy/core/navifation/go.dart';
import 'package:islamy/presentation/app_bottom_bar/screen.dart';
import 'package:islamy/presentation/resources/assets_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/res/constants_manager.dart';
import '../onBoarding/mvvm/view.dart';
import '../resources/routes_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  void _startSplash() async {
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      try {
        final prefs = await SharedPreferences.getInstance();
        bool seenOnboarding = prefs.getBool('seen_onboarding') ?? false;


        if (seenOnboarding) {
          // Navigator.pushReplacementNamed(context, Routes.home);
          Go.offAll(AppBottomBar(key: key));
        } else {
          // Navigator.pushReplacementNamed(context, Rxoutes.onBoardingRoute);
          Go.offAll(const OnBoardingView());
        }
      } catch (e) {
        // Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
        Go.offAll(const OnBoardingView());
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _startSplash();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(ImageAssets.splashLogo),
      ),
    );
  }
}