import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:islamy/core/network/extensions.dart';
import '../../generated/locale_keys.g.dart';
import '../../config/res/constants_manager.dart';
import '../base_model.dart';
import '../error/exceptions.dart';
import 'log_interceptor.dart';
import 'network_request.dart';
import 'network_service.dart';

class DioService implements NetworkService {
  late final Dio _dio;

  DioService() {
    _initDio();
  }

  void _initDio() {
    _dio = Dio()
      ..options.baseUrl = ConstantManager.baseUrl
      ..options.connectTimeout = const Duration(
        seconds: ConstantManager.connectTimeoutDuration,
      )
      ..options.receiveTimeout = const Duration(
        seconds: ConstantManager.recieveTimeoutDuration,
      )
      ..options.responseType = ResponseType.json;

    // if (BackendConfiguation.type.isPhp) {
    //   _dio.interceptors.add(ConfigurationInterceptor());
    // }
    if (kDebugMode) {
      _dio.interceptors.add(LoggerInterceptor());
    }
  }

  @override
  void setToken(String token) {
    _dio.options.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
  }

  @override
  void removeToken() {
    _dio.options.headers.remove(HttpHeaders.authorizationHeader);
  }

  @override
  Future<BaseModel<Model>> callApi<Model>(NetworkRequest networkRequest,
      {Model Function(dynamic json)? mapper, String? secondKey}) async {
    try {
      log('path${networkRequest.path}');

      await networkRequest.prepareRequestData();
      final response = await _dio.request(networkRequest.path,
          data: networkRequest.hasBodyAndProgress()
              ? networkRequest.isFormData
                  ? FormData.fromMap(networkRequest.body!)
                  : networkRequest.body
              : networkRequest.body,
          queryParameters: networkRequest.queryParameters,
          onSendProgress: networkRequest.hasBodyAndProgress()
              ? networkRequest.onSendProgress
              : null,
          onReceiveProgress: networkRequest.hasBodyAndProgress()
              ? networkRequest.onReceiveProgress
              : null,
          options: Options(
              method: networkRequest.asString(),
              headers: networkRequest.headers));
      log('response ${response.data.toString()}');
      if (mapper != null) {
        return BaseModel.fromJson(response.data, jsonToModel: mapper, secondKey: secondKey);
      } else {
        return BaseModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  dynamic _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw NoInternetConnectionException(LocaleKeys.check_internet.tr());
      case DioExceptionType.badResponse:
        switch (error.response!.statusCode) {
          case HttpStatus.forbidden:
            throw ForbiddenException(
              error.response?.data['message'] ?? LocaleKeys.forbidden.tr(),
            );

          case HttpStatus.badRequest:
            throw BadRequestException(
              error.response?.data['message'] ?? LocaleKeys.bad_request.tr(),
            );
          case HttpStatus.unauthorized:
            throw UnauthorizedException(
              error.response?.data['message'] ?? LocaleKeys.unauthorized.tr(),
            );
          case HttpStatus.locked:
            throw BlockedException(
              error.response?.data['message'] ?? LocaleKeys.unauthorized.tr(),
            );
          case HttpStatus.notFound:
            throw NotFoundException(LocaleKeys.not_found.tr());
          case HttpStatus.conflict:
            throw ConflictException(
              error.response?.data['message'] ?? LocaleKeys.server_error.tr(),
            );
          case HttpStatus.internalServerError:
            throw InternalServerErrorException(
              error.response?.data['message'] ?? LocaleKeys.server_error.tr(),
            );
          default:
            throw ServerException(LocaleKeys.server_error.tr());
        }
      case DioExceptionType.cancel:
        throw ServerException(LocaleKeys.intenet_weakness.tr());
      case DioExceptionType.unknown:
        throw ServerException(
          error.response?.data['message'] ?? LocaleKeys.exception_error.tr(),
        );
      default:
        throw ServerException(
          error.response?.data['message'] ?? LocaleKeys.exception_error.tr(),
        );
    }
  }
}
