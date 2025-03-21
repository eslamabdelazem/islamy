import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy/config/res/color_manager.dart';
import 'package:islamy/core/widgets/app_text.dart';

class CustomAppBar extends StatelessWidget {

  final String title;
  const CustomAppBar({super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: Size(double.infinity, 60.h),
        child: AppBar(
          backgroundColor: Colors.white,
          title: AppText(
              title,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w900,
          ),
        )
    );
  }
}
