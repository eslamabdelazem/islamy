import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';

extension FormatString on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String toEnglishNumbers() {
    return replaceAll("٠", "0")
        .replaceAll("١", "1")
        .replaceAll("٢", "2")
        .replaceAll("٣", "3")
        .replaceAll("٤", "4")
        .replaceAll("٥", "5")
        .replaceAll("٦", "6")
        .replaceAll("٧", "7")
        .replaceAll("٨", "8")
        .replaceAll("٩", "9");
  }

  String toCurrency() {
    final formatter = NumberFormat("#,###");
    return formatter.format(double.parse(this));
  }

  void copyToClipboard() {
    Clipboard.setData(ClipboardData(text: this));
  }

  String get locale {
    return this.tr();
  }

  bool isNumeric() {
    return double.tryParse(this) != null;
  }

  String toCamelCase() {
    return this[0].toUpperCase() +
        substring(1).replaceAllMapped(
            RegExp('[_-](.)'), (Match match) => match.group(1)!.toLowerCase());
  }
}

extension FormatDouble on double {
  String toCurrency() {
    final formatter = NumberFormat("#,###");
    return formatter.format(this);
  }
}


extension DateTimeFormatHelper on DateTime {
  String toTime([String? locale]) {
    return DateFormat('hh:mm a', locale).format(this);
  }

  String toTimeWithoutPmAndAm([String? locale]) {
    return DateFormat('hh:mm', locale).format(this);
  }

  String toAmAndPm([String? locale]) {
    return DateFormat('a', locale).format(this);
  }

  String toFullDate({String? locale, String key = '-'}) {
    return DateFormat('yyyy${key}MM${key}dd').format(this);
  }

  String toFullDateTime([String? locale]) {
    return DateFormat('yyyy-MM-dd HH:mm').format(this);
  }

  String toDay([String? locale]) {
    return DateFormat('EEEE').format(this);
  }

  String toMonth([String? locale]) {
    return DateFormat('MMMM').format(this);
  }

  String toMonthShort([String? locale]) {
    return DateFormat('MMM').format(this);
  }

  String toDayMonth([String? locale]) {
    return DateFormat('dd MMMM').format(this);
  }

  String toDayMonthShort([String? locale]) {
    return DateFormat('dd MMM').format(this);
  }

  String toDayMonthYear([String? locale]) {
    return DateFormat('dd MMMM yyyy').format(this);
  }

  String toDayMonthYearShort([String? locale]) {
    return DateFormat('dd MMM yyyy').format(this);
  }

  String toDayMonthYearTime([String? locale]) {
    return DateFormat('dd MMMM yyyy HH:mm').format(this);
  }

  String toDayMonthYearTimeShort([String? locale]) {
    return DateFormat('dd MMM yyyy HH:mm').format(this);
  }

  String toDayMonthYearTimeSeconds([String? locale]) {
    return DateFormat('dd MMMM yyyy HH:mm:ss').format(this);
  }

  String toDayMonthYearTimeSecondsShort([String? locale]) {
    return DateFormat('dd MMM yyyy HH:mm:ss').format(this);
  }
}
