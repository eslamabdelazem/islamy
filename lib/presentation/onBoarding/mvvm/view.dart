// lib/presentation/onboarding/mvvm/onboarding_view.dart
import 'package:flutter/material.dart';
import 'package:islamy/presentation/onBoarding/mvvm/page.dart';
import 'package:islamy/presentation/onBoarding/mvvm/view_model.dart';
import 'package:provider/provider.dart';


class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OnBoardingViewModel(),
      child: Consumer<OnBoardingViewModel>(
        builder: (context, viewModel, _) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: PageView.builder(
              controller: viewModel.pageController,
              itemCount: viewModel.onBoardingPages.length,
              onPageChanged: viewModel.updatePageIndex,
              itemBuilder: (context, index) {
                return OnBoardingPage(
                  model: viewModel.onBoardingPages[index],
                  currentIndex: viewModel.currentPageIndex,
                  totalPages: viewModel.onBoardingPages.length,
                  onButtonPressed: () => viewModel.handleButtonPress(context),
                );
              },
            ),
          );
        },
      ),
    );
  }
}