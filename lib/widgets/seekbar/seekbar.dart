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
  // final Color titleColor;
  // final Color valueColor;
  // final Color unitColor;
  // final Color activeTrackColor;
  // final Color inactiveTrackColor;
  // final Color thumbColor;
  // final Color iconColor;
  // final Color fillColor;

  SeekBar(
     this.sliderValue,
      {

        this.title,
      this.unit,
      this.enabledSlider,
      // this.titleColor,
      // this.valueColor,
      // this.unitColor,
      // this.activeTrackColor,
      // this.inactiveTrackColor,
      // this.thumbColor,
      // this.iconColor,
      // this.fillColor,
       this.minValue = 0,
       this.maxValue = 100,
      required this.btnPlus,
      required this.btnMinus,
      required this.onChange,
      this.onChangeEnd});

  @override
  Widget build(BuildContext context) {
    var fontSize = 12.0;
    var sliderMargin = 12.0;
    var thumbRadius = 20.0;
    var indicatorsBtnSize = 10.0;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Text(
                title!.capitalizeFirstLetter(),
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: fontSize ),
              ),
              flex: 2,
            ),
            Expanded(
              flex: 2,
              child: RichText(
                maxLines: 1,
                text: TextSpan(
                    text: sliderValue!.toStringAsFixed(0),
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
                opacity: sliderValue! > 0 ? 0 : 1,
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
              child:
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.remove),
                    onPressed: btnMinus,
                  ),
              flex: 1,
            ),
            Expanded(
              child: Slider(
                value: sliderValue,
                min: minValue,
                max: maxValue,
                onChanged: onChange,
                onChangeEnd: onChangeEnd,
              ),
              flex: 10,
            ),
            Expanded(
              child:
              IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(Icons.add),
                onPressed: btnPlus,
              ),
              flex: 1,
            ),
          ],
        ),
        SizedBox(
          height: sliderMargin,
        ),
      ],
    );
  }
}
