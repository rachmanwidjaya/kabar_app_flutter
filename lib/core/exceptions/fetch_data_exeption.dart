import 'app_exception.dart';

class FetchDataExeption extends AppException {
  FetchDataExeption({super.message, super.code, super.error, super.stackTrace});
}
