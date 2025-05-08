import 'package:adhan/adhan.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:islamy/core/extensions/context_extension.dart';
import 'package:islamy/core/extensions/padding_extension.dart';
import 'package:islamy/core/helpers/helpers.dart';
import 'package:islamy/core/helpers/location.dart';
import 'package:islamy/core/navifation/go.dart';
import 'package:islamy/core/widgets/app_text.dart';
import 'package:islamy/core/widgets/custom_loading.dart';
import 'package:islamy/generated/assets.dart';
import 'package:islamy/generated/locale_keys.g.dart';
import 'package:islamy/presentation/home/presentation/componants/home_category.dart';
import 'package:islamy/presentation/remembrances/presentation/screens/choose_remembrances_type.dart';
import '../../../../../config/res/constants_manager.dart';
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
  PrayerTimes? prayerTimes;

  LocationModel? location;

  Future<void> getLocation()async{
    setState(() => isLoading = true);
    location = await Helpers.handleGetLocation();
    getHomePrayerTimes();
    setState(() => isLoading = false);
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

  String _getPrayerTime(Prayer prayer){
    switch(prayer){
      case Prayer.fajr:
        return _formatDateToHoursAndMinutes(prayerTimes!.fajr);
      case Prayer.dhuhr:
        return _formatDateToHoursAndMinutes(prayerTimes!.dhuhr);
      case Prayer.asr:
        return _formatDateToHoursAndMinutes(prayerTimes!.asr);
      case Prayer.maghrib:
        return _formatDateToHoursAndMinutes(prayerTimes!.maghrib);
      case Prayer.isha:
        return _formatDateToHoursAndMinutes(prayerTimes!.isha);
      default:
        return '';
    }
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
                    prayerName: LocaleKeys.isha.tr(),
                    time: _formatDateToHoursAndMinutes(prayerTimes!.isha),
                  ),
                  PrayerItem(
                    icon: Assets.imagesMaghrib,
                    prayerName: LocaleKeys.maghrib.tr(),
                    time: _formatDateToHoursAndMinutes(prayerTimes!.maghrib),
                  ),
                  PrayerItem(
                    icon: Assets.imagesAsr,
                    prayerName: LocaleKeys.asr.tr(),
                    time: _formatDateToHoursAndMinutes(prayerTimes!.asr),
                  ),

                  PrayerItem(
                    icon: Assets.imagesAsr,
                    prayerName: LocaleKeys.dhuhr.tr(),
                    time: _formatDateToHoursAndMinutes(prayerTimes!.dhuhr),
                  ),
                  PrayerItem(
                    icon: Assets.imagesShorouk,
                    prayerName: LocaleKeys.sunrise.tr(),
                    time: _formatDateToHoursAndMinutes(prayerTimes!.sunrise),
                  ),
                  PrayerItem(
                    icon: Assets.imagesFagr,
                    prayerName: LocaleKeys.fajr.tr(),
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        AppText(
                          prayerTimes!.currentPrayer().name,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        AppText(
                          _getPrayerTime(prayerTimes!.currentPrayer()),
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                        ),
                        AppText(
                          '${LocaleKeys.next_prayer.tr()}: ${prayerTimes!.nextPrayer().name}',
                          fontWeight: FontWeight.w500,
                        ),
                        AppText(
                          _getPrayerTime(prayerTimes!.nextPrayer()),
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        ),
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(17),
                    ),
                    child: SizedBox(
                      width: context.width/2.2,
                      height: 137.h,
                      child: Image.asset(
                        Assets.imagesMasjid,
                        width: 218.w,
                        height: 137.h,
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
                  LocaleKeys.all_religious_worship.tr(),
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
              itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    switch(index){
                      case 0:
                        Go.to(const ChooseRemembrancesType());
                        
                      case 1:
                        key.currentState!.changeScreen(1);
                    }
                  },
                  child: HomeCategory(icon: Assets.iconsTimeclock, text: categories[index].tr())),
              itemCount: categories.length,
            ),
          )
        ],
      ),
    );
  }
}