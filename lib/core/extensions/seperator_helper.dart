import 'package:flutter/material.dart';

extension SeparatorExtension on List<Widget> {
  List<Widget> joinWith(Widget separator) {
    if (isEmpty) return [];
    if (length == 1) return toList();
    return expand((element) => [element, separator]).toList()..removeLast();
  }
}
