import 'package:kabar_app_getx/utils/extensions/centext_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget appBarHome(BuildContext context) {
  return AppBar(
    title: Image.asset(
      'assets/images/logo.png',
      height: kBottomNavigationBarHeight,
    ),
    automaticallyImplyLeading: false,
    backgroundColor: context.canvasColor,
    elevation: 0,
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 12),
        child: IconButton(
          onPressed: () {},
          icon: Icon(
            CupertinoIcons.bell,
            color: context.textColor,
          ),
        ),
      ),
    ],
  );
}
