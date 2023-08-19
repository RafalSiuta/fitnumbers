import 'package:flutter/material.dart';
import 'package:fitnumbers2/utils/extensions/string_extension.dart';

class SliderCard extends StatelessWidget {
  const SliderCard({required this.icon, required this.description, this.color = Colors.amber, super.key});

  final IconData? icon;
  final Color? color;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child:  AspectRatio(
        aspectRatio: 3/2,
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size:24,
                color:  color,
              ),
              const SizedBox(height: 8.0,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(description!.capitalizeFirstLetter(), style: Theme.of(context).textTheme.displayMedium ,overflow: TextOverflow.ellipsis,),
              )
            ],
          ),
        ),
      ),
    );
  }
}
