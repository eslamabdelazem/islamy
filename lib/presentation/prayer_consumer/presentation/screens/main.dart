import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy/core/extensions/padding_extension.dart';
import 'package:islamy/core/shared/base_status.dart';
import 'package:islamy/core/widgets/custom_loading.dart';
import 'package:islamy/core/widgets/text_fields/app_bar.dart';
import 'package:islamy/generated/locale_keys.g.dart';
import 'package:islamy/presentation/prayer_consumer/presentation/provider/provider.dart';
import 'package:islamy/presentation/prayer_consumer/presentation/widgets/date_widget.dart';
import 'package:islamy/presentation/prayer_consumer/presentation/widgets/select_date_type.dart';
import 'package:provider/provider.dart';
import '../../data/models/get_prayers_request.dart';
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

  ValueNotifier<YearType> currentYearType = ValueNotifier(YearType.gregorian);

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
            onSelectYearType: (yearType) => setState(() {
              currentYearType.value = yearType;
              _getPrayers(DateTime.now());
            })
        ),

        Column(
          spacing: 10.h,
          children: [
            ValueListenableBuilder(
              valueListenable: currentYearType,
              builder: (context, value, child) => Column(
                children: [
                  if(value == YearType.hijiri)
                    AppCalender.hijri(
                        onSelectHijriDate: (date) => _getPrayers(date.dateTime)
                    )
                  else
                    AppCalender.gregorian(
                      onSelectGregorianDate: (date) async => await _getPrayers(date)
                    )
                ],
              ),
            ),


            Consumer<TimingProvider>(
                builder: (context, value, child) => value.status == BaseStatus.loading?
                CustomLoading.showLoadingView() :
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