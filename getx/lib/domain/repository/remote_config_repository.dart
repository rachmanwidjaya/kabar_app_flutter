import 'package:dartz/dartz.dart';

import '../entities/remote_config_entity.dart';

abstract class RemoteConfigRepositoriy {
  Future<Either<Exception, RemoteConfigEntity>> load();
}
