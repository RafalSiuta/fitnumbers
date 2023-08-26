import 'package:flutter/material.dart';
import 'package:fitnumbers2/utils/extensions/string_extension.dart';

class LargeSwitchTile extends StatelessWidget {
  const LargeSwitchTile({
    required this.title1,
    required this.title2,
    this.fontSize = 12,
    this.paddingHorizontal = 20,
    this.paddingVertical = 18,
    required this.switchValue,
    required this.onChanged,
    super.key
  });

  final String? title1, title2;
  final double fontSize, paddingHorizontal, paddingVertical;
  final bool? switchValue;
  final Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var selectedText =  theme.textTheme.headlineMedium!.copyWith(
        fontSize: fontSize,);
    var unselectedText = theme.textTheme.displaySmall!.copyWith(
      fontSize: fontSize,);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title1!.capitalizeFirstLetter(),
            style: !switchValue! ? selectedText : unselectedText
          ),

          SizedBox(
            width: 150,
            child: Transform.scale(
              scale: 0.7,
              child: Switch(
                value: switchValue!,
                onChanged: onChanged
              ),
            ),
          ),
          Text(
            title2!.capitalizeFirstLetter(),
            style: switchValue! ? selectedText : unselectedText,
          ),
        ],
      ),
    );
  }
}
