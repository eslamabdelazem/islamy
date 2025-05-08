import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:islamy/core/helpers/helpers.dart';
import 'package:islamy/core/helpers/location.dart';
import 'package:islamy/core/navifation/go.dart';
import 'package:islamy/generated/locale_keys.g.dart';
import 'package:islamy/presentation/Settings/settings2.dart';
import 'package:islamy/presentation/resources/color_manager.dart';

import '../../config/language/languages.dart';
import '../../core/shared/models/location.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  LocationModel? location;
  Future<void> getLocation()async{
    location = await Helpers.handleGetLocation();
  }

  bool isEnglish = false;
  final _controller = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      setState(() {
        if (_controller.value) {
          isEnglish = true;
        } else {
          isEnglish= false;
        }
      });
    });
  }

  Future<void> changeLang(bool isEnglish)async{
    if(isEnglish){
      await Helpers.changeAppLang(context, newLang: Languages.english.locale);
    }else{
      await Helpers.changeAppLang(context, newLang: Languages.arabic.locale);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            LocaleKeys.setting.tr(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              fontFamily: 'Poppins',
              color: ColorManager.blueTeal09,
            )),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: ColorManager.blueTeal09),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Container( color: Colors.grey.withOpacity(0.1), height: 50,
              child: Builder(
                builder: (context) => ListTile(
                  leading: Text(LocaleKeys.prayer_times.tr(), style: const TextStyle(fontSize: 16)),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PrayerSettings(),
                      ),
                    );
                  },
                ),
              ),

            ),
          ),
          Container(color: Colors.grey.withOpacity(0.1),
            child: ListTile(
                leading: Text(LocaleKeys.is_English.tr(),style: TextStyle(fontSize: 16)),
                trailing: AdvancedSwitch(
                    initialValue: Languages.currentLanguage == Languages.english,
                    activeColor: ColorManager.blueTeal09,
                    controller: _controller,
                    onChanged: (value) => changeLang(value),
                    height: 20, width: 40
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20,bottom: 20),
            child: InkWell(
              onTap: () async{
                final result = await Go.to(
                    const LocationScreenWithNamed.detectCurrentUserLocation(method: NavigationMethod.pop)
                );
                if(result == 'locationChanged'){
                  getLocation();
                }
              },
              child: Container( color: Colors.grey.withOpacity(0.1),height: 50,
                child: ListTile(
                  leading: Text(LocaleKeys.location.tr(),style: TextStyle(fontSize: 16)),
                  title: Row(
                    children: [
                      Text(
                        location == null?
                        LocaleKeys.cannot_detect_your_location.tr() :
                        location!.countryName!,
                        style: const TextStyle(fontSize: 8),
                      ),
                      Icon(Icons.refresh,color: ColorManager.blueTeal09,)
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container( color: ColorManager.blueTeal09.withOpacity(0.1),
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(LocaleKeys.app_version.tr(), style: TextStyle(color: ColorManager.blueTeal09)),
                  Text('1.0.0 ${LocaleKeys.version.tr()}',style: TextStyle(color: ColorManager.blueTeal09)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}