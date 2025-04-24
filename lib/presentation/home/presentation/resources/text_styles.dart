import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'color_manager.dart';

class TextStyles {
  TextStyles._();

  static TextStyle black32SemiBold = TextStyle(
    color: ColorManager.black,
    fontSize: 32.sp,
    fontWeight: FontWeight.w600,
    fontFamily: 'Poppins'
  );
  static TextStyle black18SemiBold = TextStyle(
      color: ColorManager.black,
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins'
  );
  static TextStyle black24ExtraBold = TextStyle(
      color: ColorManager.black,
      fontSize: 24.sp,
      fontWeight: FontWeight.w800,
      fontFamily: 'Poppins'
  );
  static TextStyle gray18SemiBold = TextStyle(
      color: ColorManager.gray,
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins'
  );
  static TextStyle prayer10SemiBold = TextStyle(
      color: ColorManager.selected,
      fontSize: 10.sp,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins'
  );
  static TextStyle gray24Normal = TextStyle(
      color: ColorManager.gray,
      fontSize: 24.sp,
      fontWeight: FontWeight.w400,
      fontFamily: 'Poppins'
  );
  static TextStyle gray12Normal = TextStyle(
      color: ColorManager.gray,
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      fontFamily: 'Poppins'
  );
  static TextStyle black18Medium = TextStyle(
      color: ColorManager.black_text,
      fontSize: 18.sp,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins'
  );
  static TextStyle black15Light = TextStyle(
      color: ColorManager.black_text,
      fontSize: 15.sp,
      fontWeight: FontWeight.w300,
      fontFamily: 'Poppins'
  );
  static TextStyle prayerColor14Light = TextStyle(
      color: ColorManager.prayer.withOpacity(0.56),
      fontSize: 14.sp,
      fontWeight: FontWeight.w300,
      fontFamily: 'Poppins'
  );
}
