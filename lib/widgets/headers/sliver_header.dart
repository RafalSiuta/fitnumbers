import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:fitnumbers2/utils/extensions/string_extension.dart';
import 'package:flutter/rendering.dart';

class LargeSliverHeader extends SliverPersistentHeaderDelegate {

  LargeSliverHeader({this.minHeight = 50,this.maxHeight = 60, this.padding, this.fontSize = 12,required this.title});

  final double? minHeight;
  final double? maxHeight;
  final String? title;
  final EdgeInsets? padding;
  final double fontSize;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ClipRRect(

      //borderRadius: BorderRadius.only(bottomLeft: Radius.circular(0)),
      child: BackdropFilter(
        filter: ImageFilter.blur(
            sigmaX: blur(shrinkOffset), sigmaY: blur(shrinkOffset)),
        child: Padding(
          padding: padding!,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title!.capitalizeFirstLetter(),
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: fontSize ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(Icons.info_outline),
                onPressed: (){},
              ),
            ],
          ),
        )
        // Stack(
        //   fit: StackFit.expand,
        //   children: [
        //     SingleChildScrollView(
        //         physics: NeverScrollableScrollPhysics(), child: child),
        //   ],
        // ),
      ),
    );
  }

  double blur(double shrinkOffset) {
    return 0.0 + math.min(5.0, shrinkOffset);
  }

  @override
  bool shouldRebuild(LargeSliverHeader oldDelegate) {
    return false;
  }

  @override
  double get minExtent => minHeight!;
  @override
  double get maxExtent => math.max(maxHeight!, minHeight!);

  // @override
  // FloatingHeaderSnapConfiguration get snapConfiguration => null;
  //
  // @override
  // // TODO: implement showOnScreenConfiguration
  // PersistentHeaderShowOnScreenConfiguration get showOnScreenConfiguration =>
  //     null;
  //
  // @override
  // // TODO: implement stretchConfiguration
  // OverScrollHeaderStretchConfiguration get stretchConfiguration => null;
  //
  // @override
  // // TODO: implement vsync
  // TickerProvider get vsync => null;
}