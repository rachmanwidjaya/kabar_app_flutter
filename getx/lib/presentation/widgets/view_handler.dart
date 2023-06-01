import 'package:kabar_app_getx/utils/extensions/centext_extension.dart';
import 'package:flutter/material.dart';

import '../../config/enum/view_state.dart';

import '../../core/state/controller_state.dart';
import 'failed_widget.dart';
import 'loading_widget.dart';

class ViewHandler extends StatelessWidget {
  final ControllerState state;
  final Widget? child;
  final bool? fullScreen;
  final Function()? onReload;
  const ViewHandler({
    Key? key,
    required this.state,
    this.child,
    this.fullScreen,
    this.onReload,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (state.viewState) {
      case ViewState.loading:
        return const Center(
          child: LoadingWidget(),
        );
      case ViewState.failed:
        return FailedWidget(
          message: state.message,
          texColor: context.textColor,
          onReload: () {
            try {
              onReload!();
            } catch (_) {}
          },
        );
      case ViewState.succsess:
        return child ?? const SizedBox();
      default:
        return const SizedBox();
    }
  }
}
