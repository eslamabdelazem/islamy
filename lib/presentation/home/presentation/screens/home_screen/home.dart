import 'dart:convert';
import 'package:adhan/adhan.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:islamy/core/extensions/padding_extension.dart';
import 'package:islamy/core/helpers/helpers.dart';
import 'package:islamy/core/helpers/location.dart';
import 'package:islamy/core/navifation/go.dart';
import 'package:islamy/core/widgets/app_text.dart';
import 'package:islamy/core/widgets/custom_loading.dart';
import 'package:islamy/generated/assets.dart';
import 'package:islamy/generated/locale_keys.g.dart';
import 'package:islamy/presentation/home/presentation/componants/home_category.dart';
import '../../../../../config/res/constants_manager.dart';
import '../../../../../core/helpers/cache_service.dart';
import '../../../../../core/shared/models/location.dart';
import '../../componants/prayer.dart';
import '../../resources/color_manager.dart';
import 'package:jhijri/jHijri.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool isLoading = false;
  LocationModel? location;
  PrayerTimes? prayerTimes;
  Future<void> getLocation()async{
    setState(() => isLoading = true);
    await handleGetLocation();
    getHomePrayerTimes();
    setState(() => isLoading = false);
  }

  Future<void> handleGetLocation()async{
    try{
      final Map<String, dynamic> locationJson = jsonDecode(await CacheStorage.read(CacheConstants.lastLocation));
      LocationModel? locationModel = LocationModel.fromJson(locationJson);
      location = locationModel;
    }catch(e){
      return;
    }
  }
  
  String _formatDateToHoursAndMinutes(DateTime date){
    return DateFormat.Hm().format(date);
  }


  String _formatDateToNormalDate(DateTime dateTime){
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }

  String _formatDateToHijriDate(){
    return JHijri.now().fullDate;
  }

  void getHomePrayerTimes(){
    prayerTimes = Helpers.calcPrayerTimesBasedAdhan(
        location == null?
        const LatLng(30, 30) :
        LatLng(
            location!.lat!.toDouble(),
            location!.lng!.toDouble()
        )
    );
  }

  @override
  void initState() {
    getLocation();
    super.initState();
  }
  final List<String> categories = [
    LocaleKeys.Remembrances,
    LocaleKeys.prayer_times,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    return SafeArea(
      child: isLoading? CustomLoading.showLoadingView() :
      Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 33.5.w, vertical: 8.0.h),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AppText(
                      LocaleKeys.Location.tr(),
                      color: Colors.grey,
                      fontSize: 12.sp,
                    ),
                    InkWell(
                      onTap: ()async {
                        final result = await Go.to(
                            const LocationScreenWithNamed.detectCurrentUserLocation(method: NavigationMethod.pop)
                        );
                        if(result == 'locationChanged'){
                          getLocation();
                        }
                      },
                      child: AppText(
                        location?.street?? LocaleKeys.cannot_access_location.tr(),
                        // style: TextStyles.black18Medium,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AppText(
                      _formatDateToNormalDate(DateTime.now()),
                      fontSize: 14.sp,
                      color: Colors.grey,
                    ),
                    AppText(
                      _formatDateToHijriDate(),
                      fontSize: 16.sp,
                      // style: TextStyles.black15Light,
                    ),
                  ],
                ),
              ],
            ),
          ),
          IntrinsicHeight(
            child: Container(
              color: ColorManager.background_prayer,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  PrayerItem(
                    icon: Assets.imagesIsha,
                    prayerName: 'عشاء',
                    time: _formatDateToHoursAndMinutes(prayerTimes!.isha),
                  ),
                  PrayerItem(
                    icon: Assets.imagesMaghrib,
                    prayerName: 'المغرب',
                    time: _formatDateToHoursAndMinutes(prayerTimes!.maghrib),
                  ),
                  PrayerItem(
                    icon: Assets.imagesAsr,
                    prayerName: 'العصر',
                    time: _formatDateToHoursAndMinutes(prayerTimes!.asr),
                  ),

                  PrayerItem(
                    icon: Assets.imagesAsr,
                    prayerName: 'الظهر',
                    time: _formatDateToHoursAndMinutes(prayerTimes!.dhuhr),
                  ),
                  // Container(
                  //   height: 71.h,
                  //   decoration: BoxDecoration(
                  //     color: ColorManager.prayerselection,
                  //     borderRadius: BorderRadius.circular(4),
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(
                  //         horizontal: 8.0, vertical: 7.0),
                  //     child: Column(
                  //       mainAxisSize: MainAxisSize.min,
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //         Image.asset(
                  //           Assets.imagesThohur,
                  //           height: 24.h,
                  //           width: 24.w,
                  //           color: ColorManager.white,
                  //         ),
                  //         Text(
                  //           'الظهر',
                  //           // style: TextStyles.prayerColor14Light.copyWith(
                  //           //   fontWeight: FontWeight.w600,
                  //           //   color: ColorManager.white,
                  //           // ),
                  //         ),
                  //         Text(
                  //           '12:30',
                  //           // style: TextStyles.prayerColor14Light.copyWith(
                  //           //   fontWeight: FontWeight.w600,
                  //           //   fontSize: 9,
                  //           //   color: ColorManager.white,
                  //           // ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  PrayerItem(
                    icon: Assets.imagesShorouk,
                    prayerName: 'الشروق',
                    time: _formatDateToHoursAndMinutes(prayerTimes!.sunrise),
                  ),
                  PrayerItem(
                    icon: Assets.imagesFagr,
                    prayerName: 'الفجر',
                    time: _formatDateToHoursAndMinutes(prayerTimes!.fajr),
                  ),
                ],
              ).paddingAll(8.r),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 18.0.w, right: 18.0.w, top: 14.0.w),
            child: Container(
              height: 165.h,
              width: 339.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF005773),
                    const Color(0xFFB2EBF2).withOpacity(0.7),
                  ],
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 16.h,
                      left: 10.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          prayerTimes!.currentPrayer().name,
                          // style: TextStyles.prayerColor14Light.copyWith(
                          //   color: ColorManager.prayerMain,
                          //   fontWeight: FontWeight.w600,
                          //   fontSize: 16,
                          // ),
                        ),
                        Text(
                          '12:30',
                          // style: TextStyles.prayerColor14Light.copyWith(
                          //   color: ColorManager.prayerMain,
                          //   fontWeight: FontWeight.w600,
                          //   fontSize: 36,
                          // ),
                        ),
                        Text(
                          'الصلاة القادمة: ${prayerTimes!.nextPrayer().name}',
                          // style: TextStyles.prayerColor14Light.copyWith(
                          //   color: ColorManager.prayerMain,
                          //   fontWeight: FontWeight.w500,
                          // ),
                        ),
                        Text(
                          '3:30 مساءً',
                          // style: TextStyles.prayerColor14Light.copyWith(
                          //   color: ColorManager.prayerMain,
                          //   fontWeight: FontWeight.w600,
                          //   fontSize: 14,
                          // ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(17),
                      ),
                      child: Container(
                        width: 218.w,
                        height: 137.h,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            // Positioned(
                            //   right: -16.w,
                            //   bottom: 3.h,
                            //   child: Image.asset(
                            //     ImageManager.masjid_png,
                            //     color: ColorManager.gray,
                            //     width: 211.w,
                            //     height: 129.h,
                            //   ),
                            // ),
                            // Image.asset(
                            //   ImageManager.masjid_png,
                            //   width: 218.w,
                            //   height: 137.h,
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 18.0.h),
            child: GestureDetector(
              child: Container(
                alignment: Alignment.center,
                width: 295.w,
                height: 32.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(width: 0.8, color: ColorManager.black)),
                child: AppText(
                  'جميع العبادات',
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 33.0.w),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 8.w),
              itemBuilder: (context, index) => HomeCategory(icon: Assets.iconsTimeclock, text: categories[index].tr()),
              itemCount: categories.length,
            ),
          )
        ],
      ),
    );
  }
}
