import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy/config/res/color_manager.dart';
import 'package:islamy/core/extensions/context_extension.dart';
import 'package:islamy/core/extensions/padding_extension.dart';
import 'package:islamy/core/widgets/app_text.dart';
import 'package:islamy/generated/locale_keys.g.dart';

enum YearType{hijiri, gregorian}

class SelectDateType extends StatefulWidget {

  void Function(YearType yearType) onSelectYearType;
  SelectDateType({super.key,
    required this.onSelectYearType
  });

  @override
  State<SelectDateType> createState() => _SelectDateTypeState();
}

class _SelectDateTypeState extends State<SelectDateType> {
  final List<String> titles = [
    LocaleKeys.Gregorian.tr(),
    LocaleKeys.Hijiri.tr()
  ];

  int currentIndex = 0;

  void changeIndex(int newIndex) {
    setState(() => currentIndex = newIndex);
  }

  void handleTap(int newIndex){
    changeIndex(newIndex);
    widget.onSelectYearType(currentIndex == 0? YearType.gregorian : YearType.hijiri);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        titles.length,
            (index) => InkWell(
              onTap: () => handleTap(index),
              child: AnimatedContainer(
                width: context.width / 2,
                duration: const Duration(milliseconds: 250),
                color: currentIndex == index? AppColors.primaryColor : AppColors.third,
                child: Center(
                  child: AppText(
                      titles[index],
                      fontWeight: currentIndex == index? FontWeight.bold : FontWeight.normal,
                      fontSize: 16.sp,
                      color: currentIndex == index?
                      AppColors.white : AppColors.secondary
                  ).paddingAll(16),
                ),
              ),
            ),
      ),
    );
  }
}