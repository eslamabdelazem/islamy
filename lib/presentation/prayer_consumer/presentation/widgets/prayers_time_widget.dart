import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy/config/res/color_manager.dart';
import 'package:islamy/core/extensions/padding_extension.dart';
import 'package:islamy/core/widgets/app_text.dart';

class PrayersTimeWidget extends StatelessWidget {
  PrayersTimeWidget({super.key,
    required this.prayersTimes
  });
  final List<String> prayersTimes;
  final List<String> prayers = [
    'Fajr',
    'Sunrise',
    'Dhuhr',
    'Asr',
    'Maghreb',
    'Isha',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12.h,
      children: List.generate(
        prayers.length,
            (index) => PrayerCard(prayerName: prayers[index], prayerTime: prayersTimes[index]),
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
