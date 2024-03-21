// Author: drunrapakon sangraung 630510620

import 'package:dio/dio.dart';
import 'package:taskmaster/app/data/models/app_error_model.dart';

class HandleExceptions {
  static AppError handleError(dynamic error) {
    if (error is DioError) {
      return _fromDioError(error);
    } else {
      return AppError(message: error.toString());
    }
  }

  static _fromDioError(DioError dioError) {
    final response = dioError.response;
    final statusCode = response?.statusCode;

    switch (dioError.type) {
      case DioErrorType.connectionTimeout:
        return AppError(
          code: statusCode.toString(),
          message: 'Connection timeout with API server',
        );

      case DioErrorType.sendTimeout:
        return AppError(
          code: statusCode.toString(),
          message: 'Send timeout in connection with API server',
        );

      case DioErrorType.receiveTimeout:
        return AppError(
          code: statusCode.toString(),
          message: 'Receive timeout in connection with API server',
        );

      case DioErrorType.badResponse:
        return _handleDioErrorResponse(response);

      case DioErrorType.cancel:
        return AppError(
          code: statusCode.toString(),
          message: 'Request to API server was cancelled',
        );

      case DioErrorType.unknown:
        if (dioError.message?.contains('SocketException') ?? false) {
          return AppError(
            code: statusCode.toString(),
            message: 'No Internet',
          );
        } else {
          return AppError(
            code: statusCode.toString(),
            message: 'Unexpected error occurred',
          );
        }

      default:
        return AppError(
          code: statusCode.toString(),
          message: 'Something went wrong',
        );
    }
  }

  static AppError _handleDioErrorResponse(Response<dynamic>? response) {
    final statusCode = response?.statusCode;
    final data = response?.data;
    if (data is Map<String, dynamic> && data['cod'] != null) {
      final appError = AppError.fromJson(data)..statusCode = statusCode;
      return appError;
    } else {
      return AppError(
        code: statusCode.toString(),
        message: 'Something went wrong',
      );
    }
  }
}
