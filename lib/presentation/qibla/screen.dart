import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy/config/res/assets.gen.dart';
import 'package:islamy/core/extensions/sized_box_helper.dart';
import 'package:islamy/core/widgets/custom_loading.dart';
import 'package:islamy/generated/assets.dart';
import 'package:islamy/generated/locale_keys.g.dart';
import 'package:islamy/presentation/qibla/compass.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smooth_compass_plus/utils/src/compass_ui.dart';

class QiblaScreen extends StatefulWidget {
  const QiblaScreen({super.key});


  @override
  State<QiblaScreen> createState() => _QiblaScreenState();
}

class _QiblaScreenState extends State<QiblaScreen> {
  @override
  void initState() {
    super.initState();
    checkPermissions();
  }

  Future<void> checkPermissions() async {
    final status = await Permission.locationWhenInUse.status;
    if (!status.isGranted) {
      await Permission.locationWhenInUse.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.qibla_direction.tr()),),
      body: FutureBuilder(
        future: FlutterQiblah.requestPermissions(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // return QiblaCompassScreen();
          return Center(
            child: SmoothCompassWidget(
              compassAsset: Image.asset(Assets.compassNeedle, fit: BoxFit.fill,),
              rotationSpeed: 200,
              height: 300,
              isQiblahCompass: true,
              width: 300,
              compassBuilder: (context,AsyncSnapshot<CompassModel>? compassData,Widget compassAsset){
                return AnimatedRotation(
                  turns: compassData?.data?.turns??0/360,
                  duration: const Duration(milliseconds: 400),
                  child: SizedBox(
                    height: 200,
                    width: 200,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        //put your compass here
                        SizedBox.square(
                            dimension: 200.r,
                            child: Expanded(child: compassAsset)),

                        30.szH,
                        //put your qiblah needle here
                        SizedBox.square(
                          dimension: 50.r,
                          child: Positioned(
                            top: 10,
                            left: 0,
                            right: 0,
                            bottom: 10,
                            child: AnimatedRotation(
                              turns: (compassData?.data?.qiblahOffset??0)/5000,
                              duration: const Duration(milliseconds: 400),
                              child: Image.asset(Assets.compassQiblaNeedle),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
          } else {
            return CustomLoading.showLoadingView();
          }
        },
      ),
    );
  }
}
