import 'package:flutter/material.dart';
import 'package:fitnumbers2/utils/extensions/string_extension.dart';

import '../../model/choice_model/choice_model.dart';
class TileButton extends StatelessWidget {
  const TileButton({ this.tileSize = 100,this.choiceModel, this.onGenderSelect, super.key});

  // final IconData? icon;
  // final String? title;
  final ChoiceModel? choiceModel;
  final double tileSize;
  final Function()? onGenderSelect;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onGenderSelect,
      child: SizedBox(
        width: tileSize,
        height: tileSize,
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                choiceModel!.icon,
                size:24,
                color: choiceModel!.groupValue == choiceModel!.selectedValue ? Theme.of(context).iconTheme.color : Theme.of(context).unselectedWidgetColor,
              ),
              const SizedBox(height: 8.0,),
              Text(choiceModel!.title!.capitalizeFirstLetter(), style:choiceModel!.groupValue == choiceModel!.selectedValue ? Theme.of(context).textTheme.displayMedium : Theme.of(context).textTheme.displaySmall ,)
            ],
          ),
        ),
      ),
    );
  }
}
