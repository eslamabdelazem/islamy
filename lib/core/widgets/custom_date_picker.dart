import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../config/language/languages.dart';
import '../../config/res/color_manager.dart';
import '../navifation/go.dart';

Future<DateTime?> showCustomDatePicker(
    {required TextEditingController controller, String? dateFormat}) async {
  DateTime? pickedDate = await showDatePicker(
    locale: Languages.currentLanguage.locale,
    context: Go.context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    initialEntryMode: DatePickerEntryMode.calendarOnly,
    lastDate: DateTime.now().add(const Duration(days: 365 * 4)),
    // lastDate: DateTime(2100),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: AppColors.primaryColor, // <-- SEE HERE
            onPrimary: AppColors.white, // <-- SEE HERE
            onSurface: AppColors.primaryColor,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primaryColor, // button text color
            ),
          ),
        ),
        child: child!,
      );
    },
  );
  if (pickedDate != null) {
    String formattedDate = DateFormat(dateFormat ?? 'EEE, M/d/y',
            Languages.currentLanguage.locale.languageCode)
        .format(pickedDate); // use your desired date format
    controller.text = formattedDate;
  }
  return pickedDate;
}
