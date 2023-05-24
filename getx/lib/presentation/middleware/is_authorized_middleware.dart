import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/controller/core_controller.dart';

class IsAuththorizedMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (Get.find<CoreController>().state.userEntity != null) {
      return RouteSettings(name: route ?? '/');
    }
    return null;
  }
}
