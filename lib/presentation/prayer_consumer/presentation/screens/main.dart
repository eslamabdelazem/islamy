import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:islamy/core/extensions/padding_extension.dart';
import 'package:islamy/core/widgets/text_fields/app_bar.dart';
import 'package:islamy/generated/locale_keys.g.dart';
import 'package:islamy/presentation/prayer_consumer/presentation/widgets/date_widget.dart';
import 'package:islamy/presentation/prayer_consumer/presentation/widgets/select_date_type.dart';
import '../widgets/prayers_time_widget.dart';

class PrayerConsumer extends StatefulWidget {
  const PrayerConsumer({super.key});

  @override
  State<PrayerConsumer> createState() => _PrayerConsumerState();
}

class _PrayerConsumerState extends State<PrayerConsumer> {

  YearType currentYearType = YearType.gregorian;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomAppBar(title: LocaleKeys.Prayer_Consumer.tr()),
      ),
      body: ListView(
        children: [
          SelectDateType(
              onSelectYearType: (yearType) => setState(()  {
                currentYearType = yearType;
                log(currentYearType.name);
              })
          ),
          Column(
            children: [
              if(currentYearType == YearType.hijiri)
                const HijriTableCalendar()
              else
                CalendarWidget(onSelectDate: (selectedDay) {},),

              const PrayersTimeWidget(),
            ],
          ).defaultAppScreenPadding()

        ],
      ),
    );
  }
}
