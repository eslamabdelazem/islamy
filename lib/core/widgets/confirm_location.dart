import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy/core/extensions/padding_extension.dart';
import '../../generated/locale_keys.g.dart';
import 'app_text.dart';
import 'buttons/loading_button.dart';

class ConfirmLocation extends StatelessWidget {
  final String location;
  final Future<void> Function() onConfirmLocation;
  const ConfirmLocation({super.key,
    required this.location,
    required this.onConfirmLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 10.h,
        children: [
          Expanded(child: AppText(location, color: Colors.black87)),
          LoadingButton(title: LocaleKeys.confirm_location.tr(), onTap: onConfirmLocation)
        ],
      ).paddingAll(10),
    );
  }
}