import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_hijri_calendar/islamic_hijri_calendar.dart';
import 'package:islamy/config/language/languages.dart';
import 'package:islamy/config/res/color_manager.dart';
import 'package:islamy/config/res/constants_manager.dart';
import 'package:islamy/core/extensions/padding_extension.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {

  final void Function(DateTime selectedDay) onSelectDate;
  const CalendarWidget({super.key,
      required this.onSelectDate,
  });

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TableCalendar(
            locale: Languages.currentLanguage.languageCode,
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            calendarFormat: CalendarFormat.month,
            startingDayOfWeek: StartingDayOfWeek.monday,
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
              leftChevronIcon: Icon(Icons.chevron_left, color: AppColors.primaryColor),
              rightChevronIcon: Icon(Icons.chevron_right, color: AppColors.primaryColor),
            ),
            daysOfWeekStyle: const DaysOfWeekStyle(
              weekdayStyle: TextStyle(fontWeight: FontWeight.bold),
              weekendStyle: TextStyle(fontWeight: FontWeight.bold),
            ),
            calendarStyle: CalendarStyle(
              selectedDecoration: const BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              outsideDaysVisible: false,
            ),
            onDaySelected: (selectedDay, focusedDay) {
              widget.onSelectDate(selectedDay);
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
          ),
        ],
      ).paddingAll(30),
    );
  }
}


class HijriTableCalendar extends StatefulWidget {
  const HijriTableCalendar({super.key});

  @override
  State<HijriTableCalendar> createState() => _HijriTableCalendarState();
}

class _HijriTableCalendarState extends State<HijriTableCalendar> {

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: IslamicHijriCalendar(
        isHijriView: true, // allowing users to set either the English calendar only or display the Hijri calendar alongside the English calendar
        highlightBorder : Colors.white, // Set selected date border color
        highlightTextColor : AppColors.primaryColor, // Set today date text color
        defaultTextColor : Colors.black87, //Set others dates text color
        defaultBackColor : Theme.of(context).colorScheme.background, // Set default date background color
        adjustmentValue: 0, // Set islamic hijri calendar adjustment value which is set  by user side
        isGoogleFont: true, // Set it true if you want to use google fonts else false
        fontFamilyName: ConstantManager.fontFamily,
        getSelectedEnglishDate: (selectedDate){},
        getSelectedHijriDate: (selectedDate){},
        isDisablePreviousNextMonthDates: true, // Set dates which are not included in current month should show disabled or enabled
      ).paddingAll(30),
    );
  }
}
