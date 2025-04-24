import 'package:flutter/material.dart';
import 'package:islamy/config/language/languages.dart';
import 'package:islamy/config/res/color_manager.dart';
import 'package:jhijri/_src/_jHijri.dart';
import 'package:jhijri_picker/_src/_jWidgets.dart';

enum DateType { hijri, gregorian }
class AppCalender extends StatefulWidget {
  final DateType type;
  final void Function(HijriDate date)? onSelectHijriDate;
  final void Function(DateTime date)? onSelectGregorianDate;

  const AppCalender.hijri({super.key, required this.onSelectHijriDate})
      : onSelectGregorianDate = null, type = DateType.hijri;

  const AppCalender.gregorian({super.key, required this.onSelectGregorianDate})
      : onSelectHijriDate = null, type = DateType.gregorian;

  @override
  State<AppCalender> createState() => _AppCalenderState();
}

class _AppCalenderState extends State<AppCalender> {

  @override
  Widget build(BuildContext context) {
      return JGlobalDatePicker(
        widgetType: WidgetType.JContainer,
        pickerType: widget.type == DateType.hijri?
        PickerType.JHijri : PickerType.JNormal,
        buttons: const SizedBox(),
        primaryColor: AppColors.primaryColor,
        backgroundColor: Colors.white,
        borderRadius: const Radius.circular(10),
        startDate: JDateModel(dateTime: DateTime.now()),
        selectedDate: JDateModel(dateTime: DateTime.now()),
        endDate: JDateModel(dateTime: DateTime.now().add(const Duration(days: 10000))),
        pickerMode: DatePickerMode.day,
        pickerTheme: Theme.of(context),
        textDirection: Languages.currentLanguage == Languages.arabic?
        TextDirection.rtl : TextDirection.ltr,
        onChange: (val) =>
        widget.type == DateType.hijri?
        widget.onSelectHijriDate!(val.jhijri.hijri) :
        widget.onSelectGregorianDate!(val.date),
      );
  }
}
