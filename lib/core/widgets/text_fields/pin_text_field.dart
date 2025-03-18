import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy/config/res/app_sizes.dart';
import 'package:islamy/core/extensions/sized_box_helper.dart';
import 'package:islamy/core/widgets/custom_widget_validator.dart';
import 'package:pinput/pinput.dart';

import '../../../config/language/locale_keys.g.dart';
import '../../../config/res/color_manager.dart';
import '../../../config/res/constants_manager.dart';
import '../../helpers/validators.dart';

class CustomPinTextField extends StatelessWidget {
  final ValueChanged<String>? onCompleted;
  final TextEditingController controller;
  const CustomPinTextField(
      {super.key, required this.controller, this.onCompleted});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50.w,
      height: 60.h,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(AppCircular.r10),
        border: Border.all(color: Colors.grey[400]!),
      ),
    );
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColors.primaryColor),
    );
    final errorPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColors.error),
    );
    return CustomWidgetValidator(
        validator: Validators.validateEmpty,
        builder: (state) {
          return Pinput(
            length: ConstantManager.pinCodeFieldsCount,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            forceErrorState: state.hasError,
            validator: (value) => Validators.validateEmpty(value,
                message: LocaleKeys.emptyOtpRequired),
            autofocus: true,
            onChanged: (value) {
              state.didChange(value);
            },
            separatorBuilder: (index) => 15.szW,
            focusedPinTheme: focusedPinTheme,
            defaultPinTheme: defaultPinTheme,
            errorPinTheme: errorPinTheme,
            onCompleted: onCompleted,
            controller: controller,
          );
        });
  }
}
