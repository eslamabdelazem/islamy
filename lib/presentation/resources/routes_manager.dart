import 'package:flutter/material.dart';
import 'package:islamy/presentation/home/home.dart';
import 'package:islamy/presentation/resources/strings_manager.dart';
import 'package:provider/provider.dart';
import '../onBoarding/mvvm/view.dart';
import '../onBoarding/mvvm/view_model.dart';
import '../splash/splash_view.dart';
class Routes {
  static const String splashRoute = '/';
  static const String onBoardingRoute = '/onBoarding';
  static const String home = '/home';
}

class RoutesGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => OnBoardingViewModel(),
            child: const OnBoardingView(),
          ),
        );
      case Routes.home:
        return MaterialPageRoute(builder: (_) =>  const Home());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.noRouteFound),
        ),
        body: const Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}
