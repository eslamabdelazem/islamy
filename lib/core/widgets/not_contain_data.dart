import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../config/res/app_sizes.dart';
import '../../config/res/assets.gen.dart';
import '../../generated/locale_keys.g.dart';

class NotContainData extends StatelessWidget {
  const NotContainData({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppAssets.lottie.noData.lottie(
          width: MediaQuery.of(context).size.width * .7,
          height: MediaQuery.of(context).size.height * .3,
        ),
        SizedBox(height: AppSize.sH10),
        Text(LocaleKeys.error_exeption_noconnection.tr()),
        SizedBox(height: AppSize.sH10),
        Text(LocaleKeys.errorexception_notcontaindesc.tr()),
      ],
    );
  }
}
