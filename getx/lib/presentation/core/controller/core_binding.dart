import 'package:get/get.dart';
import '../../../domain/repository/auth_repository.dart';
import '../../../domain/repository/remote_config_repository.dart';
import 'core_controller.dart';

class CoreBinding extends Bindings {
  final AuthRepository authRepository;
  final RemoteConfigRepositoriy remoteConfigRepository;
  CoreBinding({
    required this.authRepository,
    required this.remoteConfigRepository,
  });
  @override
  void dependencies() {
    Get.put(
      CoreController(
        authRepository: authRepository,
        remoteConfigRepository: remoteConfigRepository,
      ),
    );
  }
}
