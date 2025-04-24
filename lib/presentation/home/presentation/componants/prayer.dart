import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrayerItem extends StatelessWidget {
  final String icon;
  final String prayerName;
  final String time;

  const PrayerItem(
      {super.key,
      required this.icon,
      required this.prayerName,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          icon,
          height: 22.h,
          width: 22.w,
          // color: ColorManager.prayer.withOpacity(0.56),
        ),
        Text(
          prayerName,
          // style: TextStyles.prayerColor14Light,
        ),
        Text(
          time,
          // style: TextStyles.prayerColor14Light.copyWith(
          //   fontSize: 9,
          // ),
        ),
      ],
    );
  }
}
