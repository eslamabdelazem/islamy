import '../navifation/go.dart';

extension NavigationHelper on int {
  void popUntil() {
    for (var i = 0; i < this; i++) {
      Go.back();
    }
  }
}