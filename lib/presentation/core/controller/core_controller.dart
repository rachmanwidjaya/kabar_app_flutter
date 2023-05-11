import 'package:get/get.dart';

import '../../../config/enum/app_state.dart';
import '../../../data/repository_impl/local_config.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/repository/auth_repository.dart';
import '../../../domain/repository/remote_config_repository.dart';

class CoreControllerState {
  AppState appState;
  String message;
  UserEntity? userEntity;
  CoreControllerState({
    this.appState = AppState.loading,
    this.message = 'Loading...',
    this.userEntity,
  });
}

class CoreController extends GetxController {
  final RemoteConfigRepositoriy remoteConfigRepository;
  final AuthRepository authRepository;

  CoreController({
    required this.authRepository,
    required this.remoteConfigRepository,
  });

  final CoreControllerState state = CoreControllerState();

  Future<void> load() async {
    state.appState = AppState.loading;
    state.message = 'Loading...';
    update();
    await remoteConfigRepository.load().then(
      (remoteConfigRepository) {
        remoteConfigRepository.fold(
          (l) {
            state.appState = AppState.failed;
            state.message = '$l';
            update();
          },
          (remoteConfig) async {
            state.appState = remoteConfig.toAppState;

            if (state.appState == AppState.ready) {
              await initAuth();
            }
            update();
          },
        );
      },
    );
  }

  Future<void> initAuth() async {
    await authRepository.validate().then(
      (auth) {
        auth.fold(
          (l) {},
          (r) {
            state.userEntity = r;
            update();
          },
        );
      },
    );
  }

  Future<void> signOut({void Function(String message)? onError}) async {
    await authRepository.signOut().then(
      (value) {
        value.fold(
          (l) {
            onError != null ? onError('$l') : {};
          },
          (r) {
            state.userEntity = null;
            LocalConfig.instance.token = null;
            update();
          },
        );
      },
    );
  }

  Future<void> signIn({void Function(String message)? onError}) async {
    await authRepository.signIn().then(
      (value) {
        value.fold(
          (l) {
            onError != null ? onError('$l') : {};
          },
          (r) {
            state.userEntity = r;
            LocalConfig.instance.token = r.accessToken;
            update();
          },
        );
      },
    );
  }

  @override
  void onInit() {
    load();
    super.onInit();
  }
}
