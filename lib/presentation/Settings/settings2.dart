
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:islamy/generated/assets.dart';
import 'package:islamy/generated/locale_keys.g.dart';
import 'package:islamy/presentation/Settings/settings.dart';

import '../resources/color_manager.dart';


class PrayerSettings extends StatefulWidget {
  const PrayerSettings({super.key});

  @override
  State<PrayerSettings> createState() => _PrayerSettingsState();
}

class _PrayerSettingsState extends State<PrayerSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor: Colors.white,
      appBar:  AppBar(
        title: Text(
            LocaleKeys.prayer_times.tr(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: 'Poppins',
              color: ColorManager.blueTeal09,
            )
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: ColorManager.blueTeal09),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ListView(children:  [
          PrayerTimeTile( prayerName: LocaleKeys.fajr.tr(),  ),
          SizedBox(height: 20),
          PrayerTimeTile( prayerName: LocaleKeys.dhuhr.tr(),  ),
          SizedBox(height: 20),
          PrayerTimeTile( prayerName: LocaleKeys.asr.tr(),  ),
          SizedBox(height: 20),
          PrayerTimeTile( prayerName: LocaleKeys.maghrib.tr(),  ),
          SizedBox(height: 20),
          PrayerTimeTile( prayerName: LocaleKeys.isha.tr(),  )

        ],),
      ),
    );
  }
}




class PrayerTimeTile extends StatefulWidget {
  final String prayerName;


  const PrayerTimeTile({
    Key? key,
    required this.prayerName,
  }) : super(key: key);

  @override
  State<PrayerTimeTile> createState() => _PrayerTimeTileState();
}

class _PrayerTimeTileState extends State<PrayerTimeTile> {
  final _controller = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container( height: 45,
        color: ColorManager.greyA1.withOpacity(0.1),
        child: ListTile(
          trailing: AdvancedSwitch(
            controller: _controller,
            activeColor: ColorManager.blueTeal09,
            inactiveColor: ColorManager.greyA1,
            borderRadius: BorderRadius.circular(20),
            width: 40,
            height: 20,
          ),
          leading:  Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.prayerName,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _controller.value? ColorManager.blueTeal:ColorManager.greyA1,
                ),
              ),
              const SizedBox(width: 8),
              Image.asset(
                _controller.value
                    ? Assets.iconsVolume
                    : Assets.iconsMuted,
                width: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}