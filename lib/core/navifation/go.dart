import 'package:flutter/material.dart';



class Go{
  static final GlobalKey<NavigatorState> _navigatorKey =
  GlobalKey<NavigatorState>();

  static GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
  static BuildContext get context => _navigatorKey.currentContext!;

  BuildContext get navigatorKeyContext => _navigatorKey.currentContext!;

  static Future<T?> to<T extends Object?>(Widget screen){
    return _navigatorKey.currentState!.push<T>(
        MaterialPageRoute(
          builder: (context) => screen,
        )
    );
  }

  static Future<T?> offAll<T extends Object?>(Widget screen){
    return _navigatorKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => screen
        ), (route) => false,
    );
  }

  static Future<T?> replacementBy<T extends Object?, TO extends Object?>(Widget screen){
    return _navigatorKey.currentState!.pushReplacement<T, TO>(
        MaterialPageRoute(
          builder: (context) => screen,
        )
    );
  }

  static void back<T extends Object?>([T? result]) {
    _navigatorKey.currentState!.pop(result);
  }

  static void backToInitial<T extends Object?>([T? result]) {
      _navigatorKey.currentState!.popUntil((e) => e.isFirst);
  }
}