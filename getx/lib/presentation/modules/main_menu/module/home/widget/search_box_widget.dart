import 'package:kabar_app_getx/utils/extensions/context_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SeacrhBoxWidget extends StatelessWidget {
  final void Function(String value) onSubmitted;
  const SeacrhBoxWidget({
    super.key,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: Icon(
            CupertinoIcons.search,
            size: 24,
            color: context.textTheme.bodyMedium?.color,
          ),
          suffixIcon: Icon(
            Icons.filter_list,
            size: 24,
            color: context.textTheme.bodyMedium?.color,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: context.textTheme.bodyMedium!.color!,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: context.primaryColor,
              width: 1.0,
            ),
          ),
          hintStyle: context.textTheme.bodyMedium
              ?.copyWith(color: context.disabledColor),
          filled: true,
          fillColor: context.canvasColor,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        ),
        textInputAction: TextInputAction.search,
        onSubmitted: (value) => onSubmitted(value),
      ),
    );
  }
}
