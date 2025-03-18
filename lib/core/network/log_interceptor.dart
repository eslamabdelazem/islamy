import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AnsiColors {
  static const String resetColor = '\x1B[0m';
  static const String redColor = '\x1B[31m'; // Red
  static const String greenColor = '\x1B[32m'; // Green
  static const String yellowColor = '\x1B[33m'; // Yellow
  static const String cyanColor = '\x1B[36m'; // Cyan
  static const String underlined = '\x1B[4m'; // Light Yellow
  static const String blueColor = '\x1B[34m'; // Light
  static const String bold = '\x1B[1m'; // Light
}

enum Level {
  debug(color: AnsiColors.cyanColor, text: '[DEBUG]'),
  info(color: AnsiColors.greenColor, text: '[INFO]'),
  warning(color: AnsiColors.yellowColor, text: '[WARNING]'),
  error(color: AnsiColors.redColor, text: '[ERROR]'),
  alien(color: AnsiColors.redColor, text: '[ALIEN]'),
  ;

  const Level({
    required this.color,
    required this.text,
  });

  final String color;
  final String text;
}

// log different colors
void logDebug(String message, {Level level = Level.info}) {
  final now = DateTime.now();
  final timeString =
      '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';

  if (kDebugMode) {
    try {
      final String logMessage =
          '${level.color}${level.text}[$timeString] ${message.split('\n').map((e) => '${level.color}$e').join('\n')}${AnsiColors.resetColor}';
      debugPrint(logMessage);
    } catch (e) {
      log(e.toString());
    }
  }
}

class LoggerInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    final requestPath = '${options.baseUrl}${options.path}';

    logDebug('onError: ${options.method} request => $requestPath',
        level: Level.error);
    logDebug('onError: ${err.error}, Message: ${err.message}',
        level: Level.error);
    logDebug(
        'onError: StatusCode: ${err.response?.statusCode}, Data: ${_prettyJsonEncode(err.response?.data)}',
        level: Level.error);

    return super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final requestPath = getRequestPath(options);

    // Log request details
    logDebug(
        '\n\n\n\n.........................................................................');
    logDebug('onRequest: ${options.method} request => $requestPath',
        level: Level.info);
    logDebug(
        'onRequest: Request Headers => \n${options.headers.entries.map((e) => '${e.key}: ${e.value}').join('\n')}',
        level: Level.info);
    if (options.data != null) {
      logDebug('onRequest: Request Data => ${_prettyJsonEncode(options.data)}',
          level: Level.info);

      if (options.data is FormData) {
        final formData = options.data as FormData;
        logDebug(
            'onRequest: Request FormData => ${formData.fields.map((e) => '${e.key}: ${e.value}').join('\n')}',
            level: Level.info);
      }
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final options = response.requestOptions;

    final requestPath = getRequestPath(options);

    logDebug(
        'onResponse: ${response.requestOptions.method} request => $requestPath',
        level: Level.debug);
    logDebug(
        'onResponse: StatusCode: ${response.statusCode}, Data: ${_prettyJsonEncode(response.data)}',
        level: Level.debug);
    logDebug(
        '.........................................................................\n\n\n\n',
        level: Level.debug);

    return super.onResponse(response, handler);
  }

  String getRequestPath(RequestOptions options) {
    return '${options.baseUrl}${options.path}${options.queryParameters.isEmpty ? '' : '?${options.queryParameters.entries.map((e) => '${e.key}=${e.value}').join('&')}'}';
  }

  String _prettyJsonEncode(dynamic data) {
    try {
      const encoder = JsonEncoder.withIndent('  ');
      final jsonString = encoder.convert(data);
      return jsonString;
    } catch (e) {
      return data.toString();
    }
  }
}
