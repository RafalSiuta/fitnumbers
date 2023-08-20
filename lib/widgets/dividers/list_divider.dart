import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';


class ListDivider extends StatelessWidget {
  const ListDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return PlayAnimationBuilder<double>(
      tween: Tween(begin: 0.8, end: 1), // 100.0 to 200.0
      duration: const Duration(seconds: 1), // for 1 second
      builder: (context, value, _) {
        return Transform.scale(
          scale: value,
          child: const Divider(
            indent: 70,
            endIndent: 70,
          ),
        );
      },
      // onCompleted: () {
      //   // do something ...
      // },
    );
  }
}
