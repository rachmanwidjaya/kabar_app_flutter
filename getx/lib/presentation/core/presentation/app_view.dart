import 'package:flutter/material.dart';

import '../../../config/enum/app_state.dart';
import '../controller/core_controller.dart';
import 'splash/presentation/splash_page.dart';

class AppView extends StatefulWidget {
  final CoreControllerState state;
  final Widget? child;
  const AppView({
    Key? key,
    required this.state,
    this.child,
  }) : super(key: key);

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return AppStateHandler(
      onBanned: () => const _Body('onBanned'),
      onClosed: () => const _Body('onClosed'),
      onFailed: () => const _Body('onFailed'),
      onForceUpdate: () => const _Body('onForceUpdate'),
      onLoading: () => const SplashPage(),
      onLocked: () => const _Body('onLocked'),
      onReady: () => widget.child ?? const SizedBox(),
      // onUnAuthorized: () => const LoginView(),
    ).handle(widget.state.appState);
  }
}

class _Body extends StatelessWidget {
  final String text;
  const _Body(this.text);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(text),
      ),
    );
  }
}
