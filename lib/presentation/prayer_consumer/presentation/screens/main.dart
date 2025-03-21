import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:islamy/core/widgets/app_text.dart';
import 'package:islamy/core/widgets/text_fields/app_bar.dart';
import 'package:islamy/generated/locale_keys.g.dart';
import 'package:islamy/presentation/prayer_consumer/presentation/widgets/date_widget.dart';

import '../../../../config/res/color_manager.dart';
import '../widgets/prayers_time_widget.dart';

class PrayerConsumer extends StatelessWidget {
  const PrayerConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomAppBar(title: LocaleKeys.Prayer_Consumer.tr()),
      ),
      body: ListView(
        children: [
          HijriTableCalendar(),
          // CalendarWidget(onSelectDate: (selectedDay) {log(selectedDay.toString());}),
          PrayersTimeWidget()
        ],
      ),
    );
  }
}
