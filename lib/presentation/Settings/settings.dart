import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:islamy/presentation/Settings/settings2.dart';
import 'package:islamy/presentation/resources/color_manager.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp( debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold( backgroundColor: Colors.white,
          appBar: AppBar(
            title: Row( spacing: 3,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [  Icon(Icons.settings, color: ColorManager.blueTeal09,),
                Text(
                  'الإعدادات',
                 style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  color: ColorManager.blueTeal09,
                )),
                const SizedBox(width: 8),
      
              ],
            ),
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
                      leading: const Text('مواقيت الصلاة', style: TextStyle(fontSize: 16)),
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
                  leading: const Text('الانجليزية',style: TextStyle(fontSize: 16)),
                 trailing: AdvancedSwitch(activeColor: ColorManager.blueTeal09,controller: _controller,height: 20,width: 40)
                ),
              ),
      
              Padding(
                padding: const EdgeInsets.only(top: 20,bottom: 20),
                child: Container( color: Colors.grey.withOpacity(0.1),height: 50,
                  child: ListTile(
                    leading: const Text('تحديث الموقع',style: TextStyle(fontSize: 16)),
                   title: Padding(
                     padding: const EdgeInsets.only(right: 151),
                     child: Row(
                       children: [
                         const Text('القاهرة، مصر',style: TextStyle(fontSize: 8),), Icon(Icons.refresh,color: ColorManager.blueTeal09,)
                       ],
                     ),
                   ),
      
                    onTap: () {
                    },
                  ),
                ),
              ),
              Container( color: ColorManager.blueTeal09.withOpacity(0.1),
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('إصدار التطبيق', style: TextStyle(color: ColorManager.blueTeal09)),
                      Text('1.0.0 إصدار',style: TextStyle(color: ColorManager.blueTeal09)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}