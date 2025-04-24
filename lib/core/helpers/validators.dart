import 'package:easy_localization/easy_localization.dart';

import '../../generated/locale_keys.g.dart';


class Validators {
  static String? validateEmpty(String? value, {String? message}) {
    if (value == null || value.isEmpty) {
      return message ?? LocaleKeys.fill_field.tr();
    }
    return null;
  }

  static String? validatePassword(String? value, {String? message}) {
    if (value?.trim().isEmpty ?? true) {
      return message ?? LocaleKeys.pass_required_validation.tr();
    } else if (value!.length < 6) {
      return message ?? LocaleKeys.pass_validation.tr();
    }
    return null;
  }

  static String? validateEmail(String? value, {String? message}) {
    if (value?.trim().isEmpty ?? true) {
      return message ?? LocaleKeys.mail_validation.tr();
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.["
            r"a-zA-Z]+")
        .hasMatch(value!)) {
      return message ?? LocaleKeys.mail_validation.tr();
    }
    return null;
  }

  static String? validatePhone(String? value, {String? message}) {
    if (value?.trim().isEmpty ?? true) {
      return message ?? LocaleKeys.phone_number_can_not_be_empty.tr();
    } else if (!RegExp(r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]'
                r'{4,6}$)')
            .hasMatch(value!) ||
        value.length < 10) {
      return message ?? LocaleKeys.phone_validation.tr();
    }
    return null;
  }

  static String? validatePasswordConfirm(String? value, String? pass,
      {String? message}) {
    if (value?.trim().isEmpty ?? true) {
      return message ?? LocaleKeys.fill_field.tr();
    } else if (value != pass) {
      return message ?? LocaleKeys.confirm_validation.tr();
    }
    return null;
  }

  static String? validateDropDown<T>(T? value, {String? message}) {
    if (value == null) {
      return message ?? LocaleKeys.fill_field.tr();
    }
    return null;
  }
}
