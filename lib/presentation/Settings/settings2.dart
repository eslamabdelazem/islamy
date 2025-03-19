
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
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
    return MaterialApp( debugShowCheckedModeBanner: false,
      home: Scaffold( backgroundColor: Colors.white,
         appBar:  AppBar(
           title: Row( spacing: 3,
             mainAxisAlignment: MainAxisAlignment.end,
             children: [
               Text(
                   'وقت الصلاة',
                   style: TextStyle(
                     fontWeight: FontWeight.bold,
                     fontSize: 20,
                     fontFamily: 'Poppins',
                     color: ColorManager.blueTeal09,
                   )
               ),
               SizedBox(width: 8),
               IconButton(
                 icon: Icon(Icons.arrow_forward, color: ColorManager.blueTeal09),
                 onPressed: () {
                   Navigator.push(
                     context,
                     MaterialPageRoute(
                       builder: (context) => SettingsScreen(),
                     ),
                   );
                 },
               ),



             ],
           ),
           backgroundColor: Colors.white,
           elevation: 0,
           iconTheme: IconThemeData(color: ColorManager.blueTeal09),
         ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: ListView(children: const [
            PrayerTimeTile( prayerName: 'الفجر',  ),
            SizedBox(height: 20),
            PrayerTimeTile( prayerName: 'الظهر',  ),
            SizedBox(height: 20),
            PrayerTimeTile( prayerName: 'العصر',  ),
            SizedBox(height: 20),
            PrayerTimeTile( prayerName: 'المغرب',  ),
            SizedBox(height: 20),
            PrayerTimeTile( prayerName: 'العشاء',  )

          ],),
        ),
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
  _PrayerTimeTileState createState() => _PrayerTimeTileState();
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
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 170,),

              Text(
                widget.prayerName,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _controller.value? ColorManager.blueTeal:ColorManager.greyA1,
                ),
              ),
              SizedBox(width: 8),

              Image.asset(
                _controller.value
                    ? 'assets/icons/home/status_bar/volume.png'
                    : 'assets/icons/home/status_bar/muted.png',
                width: 25,
              ),


            ],
          ),
          leading:  AdvancedSwitch(
            controller: _controller,
            activeColor: ColorManager.blueTeal09,
            inactiveColor: ColorManager.greyA1,
            borderRadius: BorderRadius.circular(20),
            width: 40,
            height: 20,
          ),

        ),
      ),
    );
  }
}