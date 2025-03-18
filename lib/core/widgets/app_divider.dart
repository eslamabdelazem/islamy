import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy/core/extensions/padding_extension.dart';

class AppDivider extends StatelessWidget {
  final Color? color;
  final double? height;
  const AppDivider({super.key,
    this.color,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: height,
      color: color?? Colors.grey[200],
    );
  }
}

class SheetDivider extends StatelessWidget {
  const SheetDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDivider(
      height: 5.h,
    ).paddingSymmetric(horizontal: 120.w, vertical: 7.h);
  }
}

