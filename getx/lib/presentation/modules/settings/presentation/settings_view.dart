import 'package:kabar_app_getx/utils/extensions/context_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repository_impl/local_config.dart';
import '../../../core/controller/core_controller.dart';
import '../controller/settings_controller.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  void dispose() {
    Get.delete<SettingController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.canvasColor,
        title: const Text('Settings'),
        centerTitle: true,
        elevation: 0,
      ),
      body: GetBuilder<SettingController>(
        builder: (SettingController c) => ListView(
          children: [
            _settingItem(
              iconData: CupertinoIcons.bell,
              title: 'Notification',
              rightChild: _rightChild(),
              onTap: () {},
            ),
            _settingItem(
              iconData: CupertinoIcons.lock,
              title: 'Security',
              rightChild: _rightChild(),
              onTap: () {},
            ),
            _settingItem(
              iconData: CupertinoIcons.question_circle,
              title: 'Help',
              rightChild: _rightChild(),
              onTap: () {},
            ),
            _settingItem(
              iconData: CupertinoIcons.moon,
              title: 'Dark Mode',
              rightChild: Container(
                height: 20,
                width: 20,
                padding: const EdgeInsets.only(right: 24),
                child: Switch(
                  value: LocalConfig.instance.darkTheme,
                  activeTrackColor: context.primaryColor.withOpacity(0.5),
                  onChanged: (value) {
                    LocalConfig.instance.darkTheme = value;
                    Get.find<CoreController>().update();
                  },
                  activeColor: context.primaryColor,
                  inactiveTrackColor: context.disabledColor,
                ),
              ),
              onTap: () {
                LocalConfig.instance.darkTheme =
                    !LocalConfig.instance.darkTheme;
                Get.find<CoreController>().update();
              },
            ),
            _settingItem(
              iconData: CupertinoIcons.square_arrow_right,
              title: 'Logout',
              onTap: () async => await Get.find<CoreController>().signOut(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _settingItem({
    required IconData iconData,
    required String title,
    Widget? rightChild,
    void Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Icon(iconData),
                  const Padding(padding: EdgeInsets.all(2)),
                  Text(title),
                ],
              ),
            ),
            rightChild ?? const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget _rightChild() => const Icon(
        CupertinoIcons.chevron_right,
        size: 14,
      );
}
