// import 'dart:developer';
// import 'dart:io';
//
// import 'package:dio/dio.dart';
// import 'package:flutter_base/src/core/helpers/cache_service.dart';
// import 'package:flutter_base/src/core/navigation/navigator.dart';
// import 'package:flutter_base/src/features/auth/sign_up/presentation/imports/imports.dart';
//
// class CheckTokenInterceptor extends Interceptor {
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) async{
//     final token = await SecureStorage.read('token');
//     log('token: ${token.toString()}');
//     switch(token){
//       case null:
//       case "":
//         Go.offAll(const SignUp());
//
//       default:
//         log('add token to headers');
//         log(options.headers.toString());
//         options.headers.addAll({HttpHeaders.authorizationHeader : token});
//         log(options.headers.toString());
//     }
//
//     handler.next(options);
//   }
// }
