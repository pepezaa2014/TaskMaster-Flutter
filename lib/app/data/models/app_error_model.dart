// Author: drunrapakon sangraung 630510620

class AppError implements Exception {
  String? code;
  String? message;
  int? statusCode;

  AppError({
    this.code,
    this.message,
    this.statusCode,
  });

  AppError.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['cod'];
    statusCode = json['statusCode'];
  }
}
