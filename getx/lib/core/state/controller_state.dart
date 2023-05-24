import '../../config/enum/view_state.dart';

abstract class ControllerState {
  ViewState viewState;
  String message;
  dynamic code;
  ControllerState({
    this.viewState = ViewState.loading,
    this.message = '',
    this.code,
  });
}
