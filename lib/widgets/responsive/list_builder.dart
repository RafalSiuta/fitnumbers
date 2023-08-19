import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';


class ListBuilder extends StatelessWidget {
  const ListBuilder({
    this.itemBuilder,
    this.itemCount,
    this.separatorBuilder,
    this.separator,
    this.paddingHorizontal = 20.0,
    this.paddingVertical = 16.0,
    super.key});

  final Widget? separator;
  final IndexedWidgetBuilder? itemBuilder;
  final IndexedWidgetBuilder? separatorBuilder;
  final int? itemCount;
  final double paddingHorizontal, paddingVertical;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scrollbar(
        thickness: 1.0,
        child: AnimationLimiter(
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: paddingVertical),
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            shrinkWrap: true,
            itemCount: itemCount!,
            itemBuilder: (context,index) => AnimationConfiguration.staggeredList(
              position: index,
              delay: Duration(milliseconds: 100 + (index * 10)),
              duration: const Duration(milliseconds: 300),
              child: ScaleAnimation(
                  scale: 0.8,
                  child: itemBuilder!(context, index)),
            ),
            separatorBuilder: (context,index) => separatorBuilder!(context,index),

          ),
        ),
      ),
    );
  }
}

