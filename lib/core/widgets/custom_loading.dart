import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../config/res/app_sizes.dart';
import '../../config/res/color_manager.dart';
import '../helpers/loading_manager.dart';

class CustomLoading {
  static showLoadingView() {
    return Align(
      alignment: Alignment.center,
      child: SpinKitDoubleBounce(
        color: AppColors.primaryColor,
        size: AppSize.sH40,
      ),
    );
  }

  static showFullScreenLoading() {
    FullScreenLoadingManager.show();
  }

  static hideFullScreenLoading() {
    return FullScreenLoadingManager.hide();
  }
}
