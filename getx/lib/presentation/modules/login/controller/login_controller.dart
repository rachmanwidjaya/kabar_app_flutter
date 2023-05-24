import 'package:get/get.dart';

import '../../../../config/enum/view_state.dart';
import '../../../../core/state/controller_state.dart';
import '../../../core/controller/core_controller.dart';

class LoginState extends ControllerState {
  LoginState() : super(viewState: ViewState.initial);
}

class LoginController extends GetxController {
  LoginState state = LoginState();
  Future<void> signIn({void Function(String message)? onError}) async {
    state.viewState = ViewState.loading;
    update();
    await Get.find<CoreController>().signIn(
      onError: (message) async {
        state.viewState = ViewState.failed;
        state.message = message;
        update();
      },
    );
    update();
  }
}
