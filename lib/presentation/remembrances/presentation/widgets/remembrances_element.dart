import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy/core/extensions/padding_extension.dart';
import 'package:islamy/core/widgets/app_text.dart';
import 'package:islamy/generated/assets.dart';

class RemembrancesElement extends StatelessWidget {

  final String remembrancesText;
  const RemembrancesElement({super.key,
    required this.remembrancesText
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3,
      child: Column(
        spacing: 10.h,
        children: [
          Image.asset(Assets.imagesRemembrancesSeparator),
          AppText(remembrancesText),
          Image.asset(Assets.imagesRemembrancesSeparator),
        ],
      ).paddingAll(10.r),
    );
  }
}
