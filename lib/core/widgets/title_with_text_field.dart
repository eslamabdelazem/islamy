// import 'package:flutter/material.dart';
//
// class TitleWithTextField extends StatefulWidget {
//
//   final bool? readOnly;
//   final String title;
//   final String hintText;
//   final String? icon;
//   void Function(String? title) onEnterTitle;
//   final TextInputType inputType;
//
//   TitleWithTextField({super.key,
//     this.readOnly,
//     required this.title,
//     required this.hintText,
//     this.icon,
//     required this.onEnterTitle,
//     this.inputType = TextInputType.text,
//   });
//
//   @override
//   State<TitleWithTextField> createState() => _TitleWithTextFieldState();
// }
//
// class _TitleWithTextFieldState extends State<TitleWithTextField> {
//
//   late final TextEditingController controller;
//
//   @override
//   void initState() {
//     controller = TextEditingController();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomTextField(
//       inputType: widget.inputType,
//       readOnly: widget.readOnly,
//       upperTitle: widget.title,
//       controller: controller,
//       title: widget.hintText,
//       onChanged: (phoneNumber) => widget.onEnterTitle(phoneNumber),
//       prefixIcon: widget.icon == null? null :
//       SvgPicture.asset(widget.icon!).paddingAll(16.r),
//       validator: widget.inputType == TextInputType.phone?
//       Validators.validatePhone : Validators.validateEmpty,
//     );
//   }
// }
