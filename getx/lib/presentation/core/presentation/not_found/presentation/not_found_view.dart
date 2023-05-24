import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotFoundView extends StatelessWidget {
  const NotFoundView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          '404',
          style: context.textTheme.bodyLarge,
        ),
      ),
    );
  }
}
