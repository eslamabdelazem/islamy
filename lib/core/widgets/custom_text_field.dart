// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../config/res/constants_manager.dart';
//
// class CustomTextField extends StatelessWidget {
//   const CustomTextField({super.key,
//     this.focusNode,
//     this.autoFocus,
//     this.upperTitle,
//     required this.controller,
//     required this.title,
//     this.inputType = TextInputType.text,
//     this.validator,
//     this.prefixIcon,
//     this.readOnly,
//     this.onChanged,
//   });
//
//   final bool? readOnly;
//   final FocusNode? focusNode;
//   final bool? autoFocus;
//   final String? upperTitle;
//   final String? Function(String?)? validator;
//   final Widget? prefixIcon;
//   final String title;
//   final TextInputType? inputType;
//   final TextEditingController controller;
//   final void Function(String?)? onChanged;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       spacing: 10.h,
//       children: [
//         Visibility(
//             visible: upperTitle != null,
//             child: AppText(upperTitle??'', fontSize: 16.sp, fontWeight: FontWeight.bold
//             )
//         ),
//         DefaultTextField(
//           readOnly: readOnly?? false,
//           focusNode: focusNode,
//           autoFocus: autoFocus?? false,
//           controller: controller,
//           inputType: inputType!,
//           validator: validator,
//           maxLength: inputType == TextInputType.phone? 10 : null,
//           onChanged: onChanged,
//           prefixIcon: prefixIcon,
//           title: title,
//           hintStyle: const TextStyle(
//             fontFamily: ConstantManager.fontFamily,
//             color: Colors.grey,
//             fontWeight: FontWeight.w400,
//           ),
//           borderColor: Colors.grey[300],
//           style: const TextStyle(
//               fontWeight: FontWeight.bold
//           ),
//         ),
//       ],
//     );
//   }
// }
