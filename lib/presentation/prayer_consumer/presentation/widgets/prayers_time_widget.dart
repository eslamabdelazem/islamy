import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy/config/res/color_manager.dart';
import 'package:islamy/core/extensions/padding_extension.dart';
import 'package:islamy/core/widgets/app_text.dart';

class PrayersTimeWidget extends StatelessWidget {
  const PrayersTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12.h,
      children: List.generate(
        5,
            (index) => PrayerCard(prayerName: 'test', prayerTime: '11/3/2024'),
      ),
    );
  }
}

class PrayerCard extends StatelessWidget {

  final String prayerName;
  final String prayerTime;
  
  const PrayerCard({super.key,
    required this.prayerName,
    required this.prayerTime
  });
  
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.whiteGrey,
      child: Row(
        children: [
          AppText(prayerName, color: AppColors.secondary),
          const Spacer(),
          AppText(prayerTime, color: AppColors.secondary,),
        ],
      ).paddingAll(14),
    );
  }
}
