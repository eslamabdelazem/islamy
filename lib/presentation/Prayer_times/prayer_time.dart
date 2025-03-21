import 'package:flutter/material.dart';
import '../resources/color_manager.dart';


class PrayerTimeScreen extends StatefulWidget {
  const PrayerTimeScreen({super.key});

  @override
  State<PrayerTimeScreen> createState() => _PrayerTimeScreenState();
}

class _PrayerTimeScreenState extends State<PrayerTimeScreen> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp( debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [ Text(
                    'وقت الصلاة',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        color: ColorManager.blueTeal09
                    ),
                  ),
                    SizedBox(width: 4),
                    Image.asset('assets/icons/timeclock.png', width: 24),


                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30,right: 50,left: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Text(
                        'المكان',
                        style: TextStyle(
                          color: ColorManager.greyA1 ,
                          fontSize: 12,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Text(
                        '12 الثلاثاء ديسمبر 2024',
                        style: TextStyle(
                          color: ColorManager.greyA1 ,
                          fontSize: 12,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:10,right: 50,left: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [  Text(
                      'القاهرة, مصر',
                      style: TextStyle(
                        color: ColorManager.blueTeal09 ,
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                      Text(
                        'الأحد ربيع الأول 1445',
                        style: TextStyle(
                          color: ColorManager.blueTeal09 ,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),

                    ],
                  ),
                ),
                Center(
                  child: Image.asset(
                    'assets/images/clock.png',
                    width: 130,
                    height: 130,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 80),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 80),
                        child: Text('4:55-',style: TextStyle(fontSize: 20,color: ColorManager.greyA1),),
                      ),
                      const SizedBox(width: 30,),
                      Column(
                        children: [
                          Text(
                            'الوقت المتبقي',
                            style: TextStyle(
                              color: ColorManager.greyA1 ,
                              fontSize: 12,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          Text(
                            'لصلاة الظهر',
                            style: TextStyle(
                              color: ColorManager.blueTeal09 ,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                        ],
                      ),


                    ],
                  ),
                ),

                Expanded(
                  child: ListView(
                    children: [
                      PrayerTimeTile(
                        time: ' 04:55',
                        prayerName: "الفجر   ",
                        imagePath: 'assets/icons/home/status_bar/fajr.png',
                        isCurrent: selectedIndex == 0,
                        onTap: () => setState(() => selectedIndex = 0), volumeIcon: 'assets/icons/home/status_bar/muted.png',
                      ),
                      const SizedBox(height: 8),
                      PrayerTimeTile(
                        time: '05:55',
                        prayerName: 'الشروق',
                        imagePath: 'assets/icons/home/status_bar/sunrise.png',
                        isCurrent: selectedIndex == 1,
                        onTap: () => setState(() => selectedIndex = 1), volumeIcon: 'assets/icons/home/status_bar/muted.png',
                      ),
                      const SizedBox(height: 8),
                      PrayerTimeTile(
                        time: '  11:38',
                        prayerName: 'الظهر  ',
                        imagePath: 'assets/icons/home/status_bar/dhur.png',
                        isCurrent: selectedIndex == 2,
                        onTap: () => setState(() => selectedIndex = 2), volumeIcon: 'assets/icons/home/status_bar/volume.png',
                      ),
                      const SizedBox(height: 8),
                      PrayerTimeTile(
                        time: '  15:00',
                        prayerName: ' العصر ',
                        imagePath: 'assets/icons/home/status_bar/asr.png',
                        isCurrent: selectedIndex == 3,
                        onTap: () => setState(() => selectedIndex = 3), volumeIcon: 'assets/icons/home/status_bar/muted.png',
                      ),
                      const SizedBox(height: 8),
                      PrayerTimeTile(
                        time: '  17:45',
                        prayerName: ' المغرب',
                        imagePath: 'assets/icons/home/status_bar/maghreb.png',
                        isCurrent: selectedIndex == 4,
                        onTap: () => setState(() => selectedIndex = 4), volumeIcon: 'assets/icons/home/status_bar/muted.png',
                      ),
                      const SizedBox(height: 8),
                      PrayerTimeTile(
                        time: '  19:00',
                        prayerName: ' العشاء',
                        imagePath: 'assets/icons/home/status_bar/ishaa.png',
                        isCurrent: selectedIndex == 5,
                        onTap: () => setState(() => selectedIndex = 5), volumeIcon: 'assets/icons/home/status_bar/muted.png',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PrayerTimeTile extends StatelessWidget {
  final String time;
  final String imagePath;
  final String volumeIcon;
  final String prayerName;
  final bool isCurrent;
  final VoidCallback onTap;

  const PrayerTimeTile({
    Key? key,
    required this.time,
    required this.prayerName,
    required this.imagePath,
    this.isCurrent = false,
    required this.onTap,
    required this.volumeIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: isCurrent ? ColorManager.blueTeal09.withOpacity(0.1) : ColorManager.greyA1.withOpacity(0.1),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(left: 109),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [


                Text(prayerName,  style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:isCurrent ? ColorManager.blueTeal09: ColorManager.greyA1)),
                const SizedBox(width: 8),
                Image.asset(
                  imagePath,
                  width: 25,
                  color: isCurrent ? ColorManager.blueTeal09 : ColorManager.greyA1,
                ), ],
            ),
          ),
          leading: Row( mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(volumeIcon, width: 25),
              const SizedBox(width: 8),
              Text(time, style: TextStyle(fontSize: 18,color:isCurrent ? ColorManager.blueTeal09 : ColorManager.greyA1)),
            ],
          ),
        ),
      ),
    );
  }
}