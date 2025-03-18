import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/res/color_manager.dart';

class CustomWidgetValidator<T> extends StatelessWidget {
  final T? initialValue;
  final FormFieldValidator<T> validator;
  final Widget? child;
  final Widget Function(FormFieldState<T> value) builder;
  const CustomWidgetValidator(
      {super.key,
      this.initialValue,
      required this.validator,
      this.child,
      required this.builder});

  @override
  Widget build(BuildContext context) {
    return FormField(
      initialValue: initialValue,
      validator: validator,
      builder: (FormFieldState<T> field) {
        return builder(field);
      },
    );
  }
}

class DefaultErrorBody extends StatelessWidget {
  final FormFieldState<Object?> value;
  final Widget child;
  const DefaultErrorBody({super.key, required this.value, required this.child});

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
        decoration: InputDecoration(
          contentPadding:
              value.hasError ? EdgeInsets.all(10.r) : EdgeInsets.zero,
          errorText: value.errorText,
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          errorBorder: UnderlineInputBorder(
            borderSide: value.hasError
                ? const BorderSide(color: AppColors.error)
                : BorderSide.none,
          ),
        ),
        child: child);
  }
}
