import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../config/res/app_sizes.dart';
import '../../config/res/assets.gen.dart';
import '../../config/res/color_manager.dart';
import '../../generated/locale_keys.g.dart';
import 'buttons/default_button.dart';
//
// class ExceptionView extends StatelessWidget {
//   final String errorMsg;
//   const ExceptionView({super.key,
//       required this.errorMsg,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         AppAssets.lottie.error.lottie(
//           width: MediaQuery.of(context).size.width * .7,
//           height: MediaQuery.of(context).size.height * .3,
//         ),
//         Container(
//           margin: EdgeInsets.symmetric(vertical: AppMargin.mH20),
//           child: Center(
//             child: Text(errorMsg),
//           ),
//         ),
//         DefaultButton(
//           width: MediaQuery.of(context).size.width * .45,
//           title: LocaleKeys.contact_us.tr(),
//           textColor: AppColors.buttonText,
//           fontSize: FontSize.s12,
//           onTap: () {},
//         ),
//       ],
//     );
//   }
// }

class ExceptionView extends StatelessWidget {
  const ExceptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppAssets.lottie.error.lottie(
            width: MediaQuery.of(context).size.width * .7,
            height: MediaQuery.of(context).size.height * .3,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: AppMargin.mH20),
            child: Center(
              child: Text(LocaleKeys.exception_error.tr()),
            ),
          ),
          DefaultButton(
            width: MediaQuery.of(context).size.width * .45,
            title: LocaleKeys.contact_us.tr(),
            textColor: AppColors.buttonText,
            fontSize: FontSize.s12,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
