import 'package:flutter/material.dart';
import 'package:fitnumbers2/utils/extensions/string_extension.dart';


class SeekBar extends StatelessWidget {
  final String? title;
  final String? unit;
  final Function()? btnPlus;
  final Function()? btnMinus;
  final Function(double val)? onChange;
  final Function(double val)? onChangeEnd;
  final double sliderValue;
  final double minValue;
  final double maxValue;
  final bool? enabledSlider;

  const SeekBar(
     this.sliderValue,
      {
        this.title,
      this.unit,
      this.enabledSlider,
       this.minValue = 0,
       this.maxValue = 100,
      required this.btnPlus,
      required this.btnMinus,
      required this.onChange,
      this.onChangeEnd, super.key});

  @override
  Widget build(BuildContext context) {
    var fontSize = 12.0;
    var sliderMargin = 12.0;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Text(
                title!.capitalizeFirstLetter(),
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: fontSize ),
              ),
            ),
            Expanded(
              flex: 2,
              child: RichText(
                maxLines: 1,
                text: TextSpan(
                    text: sliderValue.toStringAsFixed(0),
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontSize: fontSize ),
                    children: <TextSpan>[
                      TextSpan(
                        text:
                        " ${unit}",
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontSize: fontSize ),
                      ),
                    ]),
                textAlign: TextAlign.left,
              ),
            ),
            Opacity(
                opacity: sliderValue > 0 ? 0 : 1,
                child: Icon(
                  Icons.warning,
                  size: fontSize,
                  color: Colors.redAccent,
                ))
          ],
        ),
        SizedBox(
          height: sliderMargin,
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child:
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.remove),
                    onPressed: btnMinus,
                  ),

            ),
            Expanded(
              flex: 10,
              child: Slider(
                value: sliderValue,
                min: minValue,
                max: maxValue,
                onChanged: onChange,
                onChangeEnd: onChangeEnd,
              ),

            ),
            Expanded(
              flex: 1,
              child:
              IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(Icons.add),
                onPressed: btnPlus,
              ),

            ),
          ],
        ),//slider with buttons
        SizedBox(
          height: sliderMargin,
        ),
      ],
    );
  }
}
