import 'package:flutter/material.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';

class Indicators extends StatelessWidget {

  const Indicators({this.currentPageNotifier, this.itemCount, this.dotSize = 8.0, super.key});

  final ValueNotifier<int>? currentPageNotifier;
  final int? itemCount;
  final double dotSize;

  @override
  Widget build(BuildContext context) {
    return CirclePageIndicator(
      size: dotSize,
      selectedSize: dotSize + 2,
      currentPageNotifier: currentPageNotifier!,
      itemCount: itemCount!,
      dotColor: Theme.of(context).dividerColor,
      selectedDotColor: Theme.of(context).indicatorColor,
    );
  }
}

class SliderIndicators extends StatelessWidget {

  const SliderIndicators({
    this.items,
    this.itemCount = 0,
    this.mapIndicators,
    super.key
  });

  final List? items;
  final int? itemCount;
  final Function? mapIndicators;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: map<Widget>(
        items!,
        mapIndicators!,
      ),
    ); //indicators
  }
}
