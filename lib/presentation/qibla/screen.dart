import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:islamy/config/res/assets.gen.dart';
import 'package:islamy/core/widgets/custom_loading.dart';
import 'package:islamy/generated/assets.dart';
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
      appBar: AppBar(title: Text('Qibla Direction')),
      body: FutureBuilder(
        future: FlutterQiblah.requestPermissions(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // return QiblaCompassScreen();
          return SmoothCompassWidget(
            compassAsset: Image.asset(Assets.compassNeedle),
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
                    children: [
                      //put your compass here
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Image.asset("Your Compass Asset Here",
                            fit: BoxFit.fill),
                      ),

                      //put your qiblah needle here
                      Positioned(
                        top: 20,
                        left: 0,
                        right: 0,
                        bottom: 20,
                        child: AnimatedRotation(
                          turns: (compassData?.data?.qiblahOffset??0)/360,
                          duration: const Duration(milliseconds: 400),
                          child: Image.asset("Your needle asset here",
                              fit: BoxFit.fitHeight),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
          } else {
            return CustomLoading.showLoadingView();
          }
        },
      ),
    );
  }
}
