import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy/core/extensions/sized_box_helper.dart';

import '../../config/res/color_manager.dart';
import '../navifation/go.dart';

Future showDefaultBottomSheet({BuildContext? context, required Widget child}) {
  return showModalBottomSheet(
      isScrollControlled: true,
      context: context ?? Go.context,
      builder: (context) => DefaultSheetBody(
            child: child,
          ));
}

class DefaultSheetBody extends StatelessWidget {
  final Widget child;
  const DefaultSheetBody({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 1.sw,
              padding: EdgeInsets.only(
                bottom: ScreenUtil().bottomBarHeight == 0
                    ? 20.h
                    : ScreenUtil().bottomBarHeight,
                left: 20.w,
                right: 20.w,
                top: 15.h,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Wrap(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 100.w,
                      height: 5.h,
                      decoration: BoxDecoration(
                        color: AppColors.whiteGrey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  15.szH,
                  child,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
