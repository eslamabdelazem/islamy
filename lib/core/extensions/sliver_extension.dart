import 'package:flutter/material.dart';

extension SliverExtension on Widget {
  SliverToBoxAdapter toSliver() => SliverToBoxAdapter(child: this);
}