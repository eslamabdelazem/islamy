import 'package:flutter/material.dart';
import 'package:islamy/core/navifation/go.dart';
import 'package:islamy/presentation/app_bottom_bar/screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model.dart';
import '../../resources/assets_manager.dart';
import '../../resources/strings_manager.dart';

class OnBoardingViewModel extends ChangeNotifier {
  final PageController pageController = PageController();
  int _currentPageIndex = 0;

  int get currentPageIndex => _currentPageIndex;
  bool get isLastPage => _currentPageIndex == onBoardingPages.length - 1;

  final List<OnBoardingModel> onBoardingPages = [
    OnBoardingModel(
      image: ImageAssets.onBoardingLogo1,
      title: AppStrings.onBoardingTitle1,
      description: AppStrings.onBoardingSubTitle1,
    ),
    OnBoardingModel(
      image: ImageAssets.onBoardingLogo2,
      title: AppStrings.onBoardingTitle2,
      description: AppStrings.onBoardingSubTitle2,
    ),
    OnBoardingModel(
      image: ImageAssets.onBoardingLogo3,
      title: AppStrings.onBoardingTitle3,
      description: AppStrings.onBoardingSubTitle3,
    ),
  ];

  void updatePageIndex(int index) {
    _currentPageIndex = index;
    notifyListeners();
  }

  Future<void> handleButtonPress(BuildContext context) async {
    try {
      if (_currentPageIndex < onBoardingPages.length - 1) {

        await pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {

        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('seen_onboarding', true);

        if (context.mounted) {
          Go.to(const AppBottomBar());
          // await Navigator.pushReplacementNamed(context, Routes.home);
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('حدث خطأ ما، حاول مرة أخرى')),
        );
      }
    }
  }

  Future<bool> checkOnboardingStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool('seen_onboarding') ?? false;
    } catch (e) {
      print("Error checking onboarding status: $e");
      return false;
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}