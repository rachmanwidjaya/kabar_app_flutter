import 'package:kabar_app_getx/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class ShadowWidget extends StatelessWidget {
  final Widget? child;
  final double? radius;
  const ShadowWidget({
    Key? key,
    this.child,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      elevation: 4,
      shadowColor: context.shadowColor,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 4),
        child: child ?? const SizedBox(),
      ),
    );
  }
}
