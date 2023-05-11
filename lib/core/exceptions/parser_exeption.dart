import 'app_exception.dart';

class ParserException extends AppException {
  ParserException({super.code, super.error, super.stackTrace})
      : super(message: 'Parsing failed');
  @override
  String toString() => '$message';
}
