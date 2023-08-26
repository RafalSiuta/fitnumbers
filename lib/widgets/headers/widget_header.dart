import 'package:flutter/material.dart';
import 'package:fitnumbers2/utils/extensions/string_extension.dart';


class WidgetHeader extends StatelessWidget {
  const WidgetHeader({required this.title,required this.padding, this.fontSize = 12.0, super.key});

  final String? title;
  final EdgeInsets? padding;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding!,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title!.capitalizeFirstLetter(),
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontSize: fontSize ),
          ),
        ],
      ),
    );
  }
}
