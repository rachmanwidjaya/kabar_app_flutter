import 'package:get/get.dart';

import '../../../../core/state/controller_state.dart';

class MainMenuState extends ControllerState {
  int currentTab;
  MainMenuState({this.currentTab = 0});
}

class MainMenuController extends GetxController {
  MainMenuState state = MainMenuState();
  setScreen(int index) {
    state.currentTab = index;
    update();
  }
}
