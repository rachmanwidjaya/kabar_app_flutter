import '../../config/enum/view_state.dart';

abstract class ControllerState {
  ViewState viewState;
  String message;
  bool loadComplete;
  dynamic code;
  ControllerState({
    this.viewState = ViewState.loading,
    this.message = '',
    this.loadComplete = false,
    this.code,
  });
}
