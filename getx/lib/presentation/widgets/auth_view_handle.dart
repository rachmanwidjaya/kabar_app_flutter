import 'package:flutter/material.dart';

import '../modules/login/presentation/login_view.dart';

class AuthHandleView extends StatelessWidget {
  final bool isAuthorized;
  final Widget? child;
  final Widget? unAuthorizedWidget;
  const AuthHandleView({
    super.key,
    required this.isAuthorized,
    this.child,
    this.unAuthorizedWidget,
  });

  @override
  Widget build(BuildContext context) {
    return isAuthorized
        ? child ?? const SizedBox()
        : unAuthorizedWidget ?? const LoginView();
  }
}
