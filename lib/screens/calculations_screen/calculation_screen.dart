import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

import '../../providers/logic_provider/logic_provider.dart';
import '../../providers/profile_provider/profile_provider.dart';
import '../../providers/settings_provider/settings_provider.dart';

class CalculationScreen extends StatefulWidget {
  const CalculationScreen({super.key});

  @override
  State<CalculationScreen> createState() => _CalculationScreenState();
}

class _CalculationScreenState extends State<CalculationScreen> {
  @override
  Widget build(BuildContext context) {
    double fontSize = 12.0;
    return Consumer3<ProfileProvider, LogicProvider, SettingsProvider>(
        builder: (context, profile, logic, settings, child){

      return Column(
        children: [
          Text('Calculations', style: Theme.of(context).textTheme.headlineMedium,),
          Expanded(
              child:
          GridView.count(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
          physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics()),
          scrollDirection:Axis.vertical,
          crossAxisSpacing: 0.0,
          shrinkWrap: true,
          mainAxisSpacing: 0.0,
          crossAxisCount: 2,
          childAspectRatio: 2.3 / 3,
          children:
          List.generate( logic.numbersListCounter, (index){
          final listData = logic.mainNumbersList[index];
          return AnimationConfiguration.staggeredGrid(
          columnCount: 2,
          position: index,
          duration: const Duration(milliseconds: 500),
          child: ScaleAnimation(
          scale: 0.9,
          child: FadeInAnimation(
          child: Card(child:
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${listData.title}:', style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: fontSize),),
                  RichText(text: TextSpan(
                    text: '${listData.value!.toStringAsFixed(2)} ',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: listData.infoColor, fontSize: fontSize),
                    children: <TextSpan>[
                      TextSpan(
                        text: listData.unit,
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith( fontSize: fontSize),
                      )
                    ]
                  )),
                  Text(listData.description!, style: Theme.of(context).textTheme.headlineMedium!.copyWith( fontSize: fontSize),),
                ],
              ),
            ))),
          ),
          );
          }
          )),
          ),
          //     GridView.builder(
          //     itemCount: logic.numbersListCounter,
          //     itemBuilder: (context, index){
          //   final listData = logic.mainNumbersList[index];
          //
          //   return Card(
          //
          //       child:
          //   Column(
          //     children: [
          //       Text('${listData.title}:', style: Theme.of(context).textTheme.headlineMedium,),
          //       Text(listData.value!.toStringAsFixed(2), style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: listData.infoColor),),
          //     ],
          //   ));
          // })
         // )
        ],
      );
    });
  }
}
