import 'dart:developer';

class AppException implements Exception {
  final dynamic code;
  final String? message;
  final Object? error;
  final StackTrace? stackTrace;

  AppException({this.code, this.message, this.error, this.stackTrace})
      : super() {
    log('$message', error: error, stackTrace: stackTrace);
  }

  @override
  String toString() {
    return "$message";
  }
}
