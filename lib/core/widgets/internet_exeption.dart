import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:islamy/core/extensions/context_extension.dart';
import '../../config/language/locale_keys.g.dart';
import '../../config/res/app_sizes.dart';
import '../../config/res/assets.gen.dart';
import '../../config/res/color_manager.dart';
import '../../generated/locale_keys.g.dart';

class InternetExpetion extends StatelessWidget {
  const InternetExpetion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: context.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppAssets.lottie.noInternet.lottie(
              width: MediaQuery.of(context).size.width * .7,
              height: MediaQuery.of(context).size.height * .3,
            ),
            SizedBox(height: AppSize.sH10),
            Text(
              LocaleKeys.error_exeption_noconnection.tr(),
              style: context.textTheme.titleLarge!.copyWith(
                color: AppColors.secondary,
              ),
            ),
            SizedBox(height: AppSize.sH10),
            Text(
              LocaleKeys.errorexception_notcontaindesc.tr(),
              style: context.textTheme.titleLarge!.copyWith(),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppSize.sH10),
          ],
        ),
      ),
    );
  }
}
