// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:islamy/core/extensions/material_color_extension.dart';
//
// import '../res/color_manager.dart';
//
// class AppTheme {
//   static ThemeData get light {
//     return ThemeData(
//       primarySwatch: AppColors.primaryColor.toMaterialColor(),
//       primaryColor: AppColors.primaryColor,
//       useMaterial3: true,
//       bottomSheetTheme: const BottomSheetThemeData(
//         modalBackgroundColor: AppColors.white,
//         surfaceTintColor: Colors.transparent,
//       ),
//       scaffoldBackgroundColor: AppColors.scaffoldBackground,
//       bottomNavigationBarTheme: const BottomNavigationBarThemeData(
//         backgroundColor: AppColors.white,
//         selectedItemColor: AppColors.primaryColor,
//         unselectedItemColor: AppColors.grey,
//         showSelectedLabels: true,
//         showUnselectedLabels: true,
//         type: BottomNavigationBarType.fixed,
//       ),
//       textButtonTheme: TextButtonThemeData(
//         style: TextButton.styleFrom(
//           padding: EdgeInsets.symmetric(horizontal: 4.w),
//           foregroundColor: AppColors.primaryColor,
//           minimumSize: Size(30.w, 30.h),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(0),
//           ),
//         ),
//       ),
//       dialogTheme: const DialogTheme(
//         surfaceTintColor: Colors.transparent,
//       ),
//       textSelectionTheme: TextSelectionThemeData(
//         cursorColor: AppColors.primaryColor,
//         selectionColor: AppColors.primaryColor.withValues(alpha: 0.2),
//         selectionHandleColor: AppColors.primaryColor,
//       ),
//
//       // appBarTheme: const AppBarTheme(
//       //   iconTheme: IconThemeData(
//       //     color: Colors.white
//       //   )
//       // ),
//
//       // iconTheme: const IconThemeData(
//       //   color: AppColors.white,
//       // ),
//       inputDecorationTheme: const InputDecorationTheme(
//         prefixIconColor: AppColors.border,
//       ),
//       textTheme: GoogleFonts.poppinsTextTheme(
//         TextTheme(
//           // This Style For AppBar Text
//           headlineLarge: TextStyle(
//             fontSize: 18.sp,
//             color: AppColors.secondary,
//             fontWeight: FontWeight.normal,
//           ),
//           // This Style For Normal Text With PrimaryColor
//           titleLarge: TextStyle(
//             fontSize: FontSize.s13,
//             color: AppColors.primaryColor,
//           ),
//           // This Style For Normal Text With SecondryColor
//           titleMedium: TextStyle(
//             fontSize: FontSize.s13,
//             color: AppColors.primaryColor,
//           ),
//           // This Style For Normal Text With ThirdColor
//           titleSmall: TextStyle(
//             fontSize: FontSize.s13,
//             color: AppColors.primaryColor,
//           ),
//           // This Style For Hint Text
//           bodySmall: TextStyle(
//             fontSize: FontSize.s8,
//             color: AppColors.hintText,
//           ),
//         ),
//       ),
//     );
//   }
//
//   // static ThemeData get dark {
//   //   return ThemeData(
//   //     primarySwatch: AppColorsWithDarkMode.primary.toMaterialColor(),
//   //     primaryColor: AppColorsWithDarkMode.primary,
//   //     useMaterial3: true,
//   //     bottomSheetTheme: const BottomSheetThemeData(
//   //       modalBackgroundColor: AppColorsWithDarkMode.white,
//   //     ),
//   //     scaffoldBackgroundColor: AppColorsWithDarkMode.border,
//   //     bottomNavigationBarTheme: const BottomNavigationBarThemeData(
//   //       backgroundColor: AppColorsWithDarkMode.white,
//   //       selectedItemColor: AppColorsWithDarkMode.primary,
//   //       unselectedItemColor: AppColorsWithDarkMode.grey,
//   //       showSelectedLabels: true,
//   //       showUnselectedLabels: true,
//   //       type: BottomNavigationBarType.fixed,
//   //     ),
//   //     textButtonTheme: TextButtonThemeData(
//   //       style: TextButton.styleFrom(
//   //         padding: EdgeInsets.symmetric(horizontal: AppPadding.pW4),
//   //         foregroundColor: AppColorsWithDarkMode.primary,
//   //         minimumSize: Size(AppSize.sW30, AppSize.sH30),
//   //         shape: RoundedRectangleBorder(
//   //           borderRadius: BorderRadius.circular(
//   //             AppSize.sH0,
//   //           ),
//   //         ),
//   //       ),
//   //     ),
//   //     dialogTheme: const DialogTheme(
//   //       surfaceTintColor: Colors.transparent,
//   //     ),
//   //     appBarTheme: const AppBarTheme(
//   //       foregroundColor: AppColorsWithDarkMode.white,
//   //     ),
//   //     iconTheme: const IconThemeData(
//   //       color: AppColorsWithDarkMode.white,
//   //     ),
//   //     inputDecorationTheme: const InputDecorationTheme(
//   //       prefixIconColor: AppColorsWithDarkMode.border,
//   //     ),
//   //     textTheme: GoogleFonts.poppinsTextTheme(
//   //       TextTheme(
//   //         // This Style For AppBar Text
//   //         headlineLarge: TextStyle(
//   //           fontSize: FontSize.s18,
//   //           color: AppColors.secondary,
//   //           fontWeight: FontWeightManager.medium,
//   //         ),
//   //         // This Style For Normal Text With PrimaryColor
//   //         titleLarge: TextStyle(
//   //           fontSize: FontSize.s13,
//   //           color: AppColors.primaryColor,
//   //         ),
//   //         // This Style For Normal Text With SecondryColor
//   //         titleMedium: TextStyle(
//   //           fontSize: FontSize.s13,
//   //           color: AppColors.primaryColor,
//   //         ),
//   //         // This Style For Normal Text With ThirdColor
//   //         titleSmall: TextStyle(
//   //           fontSize: FontSize.s13,
//   //           color: AppColors.primaryColor,
//   //         ),
//   //         // This Style For Hint Text
//   //         bodySmall: TextStyle(
//   //           fontSize: FontSize.s8,
//   //           color: AppColors.hintText,
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }
// }
