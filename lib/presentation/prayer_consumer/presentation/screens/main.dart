import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:islamy/core/base_model.dart';
import 'package:islamy/core/extensions/padding_extension.dart';
import 'package:islamy/core/helpers/state_builder/provider_state_builder.dart';
import 'package:islamy/core/shared/base_status.dart';
import 'package:islamy/core/widgets/app_text.dart';
import 'package:islamy/core/widgets/text_fields/app_bar.dart';
import 'package:islamy/generated/locale_keys.g.dart';
import 'package:islamy/presentation/prayer_consumer/presentation/provider/provider.dart';
import 'package:islamy/presentation/prayer_consumer/presentation/widgets/date_widget.dart';
import 'package:islamy/presentation/prayer_consumer/presentation/widgets/select_date_type.dart';
import 'package:provider/provider.dart';
import '../../data/date_source.dart';
import '../../data/models/get_prayers_request.dart';
import '../../data/models/prayers_timing.dart';
import '../widgets/prayers_time_widget.dart';

class PrayerConsumer extends StatelessWidget {
  const PrayerConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomAppBar(title: LocaleKeys.Prayer_Consumer.tr()),
      ),
      body: ChangeNotifierProvider(
          create: (context) => TimingProvider(),
          child: const _PrayerConsumerBody()
      )
    );
  }
}

class _PrayerConsumerBody extends StatefulWidget {
  const _PrayerConsumerBody({super.key});

  @override
  State<_PrayerConsumerBody> createState() => _PrayerConsumerBodyState();
}

class _PrayerConsumerBodyState extends State<_PrayerConsumerBody> {

  YearType currentYearType = YearType.gregorian;

  Future<void> _getPrayers(DateTime dateTime)async{
    String date = DateFormat('dd-MM-yyyy').format(dateTime);
    await context.read<TimingProvider>().getPrayersTiming(
        GetPrayersBasedChosenDateRequest(
            lng: 31.toString(),
            lat: 31.toString(),
            date: date
        ));
  }

  @override
  void initState() {
    _getPrayers(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  ListView(
      children: [
        SelectDateType(
            onSelectYearType: (yearType) => setState(()  => currentYearType = yearType)
        ),

        // ProviderStateBuilder.defaultLoading(
        //   asyncCall: () async => await context.read<TimingProvider>().getPrayersTiming(
        //       GetPrayersBasedChosenDateRequest(
        //           lng: 31.toString(),
        //           lat: 31.toString(),
        //           date: '01-01-2025'
        //       )),
        //   builder: (snapshot) => AppText(snapshot.data?.data.fajr?? 'no data'),
        // ),

        Column(
          children: [
            if(currentYearType == YearType.hijiri)
              const HijriTableCalendar()
            else
              CalendarWidget(
                onSelectDate: (selectedDay) async => await _getPrayers(selectedDay)
              ),

            Consumer<TimingProvider>(
                builder: (context, value, child) => value.status == BaseStatus.loading? CircularProgressIndicator() :
                PrayersTimeWidget(
                  prayersTimes: [
                    value.prayerTiming!.fajr,
                    value.prayerTiming!.sunrise,
                    value.prayerTiming!.dhuhr,
                    value.prayerTiming!.asr,
                    value.prayerTiming!.maghrib,
                    value.prayerTiming!.isha
                  ],
                ),
            ),
          ],
        ).defaultAppScreenPadding()
      ],
    );
  }
}

