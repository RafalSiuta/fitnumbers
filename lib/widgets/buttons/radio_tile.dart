import 'package:flutter/material.dart';
import 'package:fitnumbers2/utils/extensions/string_extension.dart';


class RadioTile extends StatelessWidget {
  const RadioTile({
    required this.onChoice,
    required this.value,
    required this.groupValue,
    required this.title,
    required this.description,
    this.fontSize= 12.0,
    this.paddingHorizontal = 20.0,
    this.paddingVertical = 16.0,
    super.key});

  final ValueChanged<int?>? onChoice;
  final int? value;
  final int? groupValue;
  final String? title;
  final String? description;
  final double fontSize, paddingHorizontal, paddingVertical;


  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var selectedText =  theme.textTheme.headlineMedium!.copyWith(
      fontSize: fontSize,height: 1.5);
    var unselectedText = theme.textTheme.displaySmall!.copyWith(
      fontSize: fontSize,height: 1.5);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: paddingVertical),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Radio(value: value!, groupValue: groupValue!, onChanged: onChoice,),
          const SizedBox(width: 10,),
          VerticalDivider(
            color: Theme.of(context).unselectedWidgetColor,
            thickness: 0.5,
            width: 0.5,
          ),
          Expanded(
            child: RichText(
                text: TextSpan(
                 text: title!.capitalizeFirstLetter(),

                 style: value == groupValue ? selectedText : unselectedText,

              children: <TextSpan>[
                TextSpan(text: "\n${description!.capitalizeFirstLetter()}",)
              ]
            ), overflow: TextOverflow.ellipsis,maxLines: 4,),
          )
        ],
      ),
    );
  }
}
