import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../config/enum/app_state.dart';
import '../../../../routes/app_pages.dart';
import '../../../controller/core_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CoreController>(
        builder: (c) {
          Future.microtask(
            () {
              if (c.state.appState == AppState.ready) {
                Get.offAllNamed(AppRoutes.home);
              }
            },
          );
          return Center(
            child: Image.asset(
              'assets/images/logo.png',
              height: kBottomNavigationBarHeight * 2,
            ),
          );
        },
      ),
    );
  }
}
