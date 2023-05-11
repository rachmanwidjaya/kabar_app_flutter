import 'package:dartz/dartz.dart';

import '../../../core/exceptions/app_exception.dart';
import '../../../domain/entities/remote_config_entity.dart';
import '../../../domain/repository/remote_config_repository.dart';

class DumyRemoteConfigRepositoryImpl implements RemoteConfigRepositoriy {
  @override
  Future<Either<Exception, RemoteConfigEntity>> load() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      return Right(
        RemoteConfigEntity(
          appServer: '',
          appOpen: true, //  set TRUE to redirect to Closed Page
          forceUpdate: false, // set TRUE to redirect to ForceUpdate Page
          appUpdate: false,
          appVersion: 1,
          versionValid: true,
        ),
      );
    } catch (e, s) {
      return Left(AppException(
          message: 'Failed to obtain the config.', error: e, stackTrace: s));
    }
  }
}
