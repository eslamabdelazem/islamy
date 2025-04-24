import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy/config/res/color_manager.dart';

import '../resources/text_styles.dart';

class HomeCategory extends StatelessWidget {
  final String icon;
  final String text;

  const HomeCategory({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 82.w,
      height: 80.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: Offset(0, 2.5),
            blurRadius: 20,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            icon,
            width: 44.w,
            height: 44.h,
            color: AppColors.primaryColor,
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            text,
            style: TextStyles.black18SemiBold
                .copyWith(fontSize: 14, color: AppColors.primaryColor),
          ),
        ],
      ),
    );
  }
}
