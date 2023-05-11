import 'package:flutter/material.dart';

import '../modules/login/presentation/login_view.dart';

class AuthHandleView extends StatelessWidget {
  final bool siAuthorized;
  final Widget? child;
  final Widget? unAuthorizedWidget;
  const AuthHandleView({
    super.key,
    required this.siAuthorized,
    this.child,
    this.unAuthorizedWidget,
  });

  @override
  Widget build(BuildContext context) {
    return siAuthorized
        ? child ?? const SizedBox()
        : unAuthorizedWidget ?? const LoginView();
  }
}
