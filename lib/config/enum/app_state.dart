enum AppState {
  // initial, if you Using Onboarding
  loading,
  ready,
  failed,
  locked,
  closed,
  forceUpdate,
  // unAuthorized,
  banned,
}

class AppStateHandler<T> {
  // T Function() onInitial;
  T Function() onLoading;
  T Function() onReady;
  T Function() onFailed;
  T Function() onLocked;
  T Function() onClosed;
  T Function() onForceUpdate;
  T Function() onBanned;

  AppStateHandler({
    // required this.onInitial,
    required this.onLoading,
    required this.onReady,
    required this.onFailed,
    required this.onLocked,
    required this.onClosed,
    required this.onForceUpdate,
    required this.onBanned,
  });

  T handle(AppState state) {
    switch (state) {
      // case AppState.initial:
      //   return onInitial();
      case AppState.loading:
        return onLoading();
      case AppState.ready:
        return onReady();
      case AppState.failed:
        return onFailed();
      case AppState.locked:
        return onLocked();
      case AppState.closed:
        return onClosed();
      case AppState.forceUpdate:
        return onForceUpdate();
      case AppState.banned:
        return onBanned();
    }
  }
}
