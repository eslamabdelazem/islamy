// import 'package:flutter/material.dart';
//
// class ConditionsTerms extends StatefulWidget {
//   const ConditionsTerms({super.key});
//
//   @override
//   State<ConditionsTerms> createState() => _ConditionsTermsState();
// }
//
// class _ConditionsTermsState extends State<ConditionsTerms> {
//   bool isAgree = false;
//
//   void changeAgree(bool? value) => setState(() => isAgree = value?? false);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         ValidationHost(
//             onSaved: (newValue) {},
//             validator: (value) => value == false? 'error' : null
//         ),
//       ],
//     );
//   }
// }
//
// class ValidationHost<T> extends FormField<T> {
//   ValidationHost({super.key,
//     required FormFieldSetter<T> onSaved,
//     required FormFieldValidator<T> validator,
//     required T initialValue,
//   }) : super(
//     onSaved: onSaved,
//     validator: validator,
//     initialValue: initialValue,
//     builder: (FormFieldState<T> state) {
//
//
//       // return Column(
//       //   crossAxisAlignment: CrossAxisAlignment.start,
//       //   children: [
//       //     Row(
//       //       children: [
//       //         Checkbox(
//       //           value: state.value,
//       //           onChanged: (value) {
//       //             state.didChange(value);
//       //           },
//       //         ),
//       //       ],
//       //     ),
//       //     if (state.hasError)
//       //       AppText(
//       //           LocaleKeys.termsAndConditionsMustBeAgreedTo,
//       //           fontWeight: FontWeight.bold,
//       //           color: Colors.red,
//       //           fontSize: 10.sp
//       //       )
//       //   ],
//       // );
//     },
//   );
// }
