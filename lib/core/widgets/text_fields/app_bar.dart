import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy/config/res/color_manager.dart';
import 'package:islamy/core/widgets/app_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{

  final String title;
  final List<Widget> actions;

  const CustomAppBar({super.key,
    required this.title,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: Size(double.infinity, 60.h),
        child: AppBar(
          backgroundColor: Colors.white,
          actions: actions,
          title: AppText(
              title,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w900,
          ),
        )
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}
