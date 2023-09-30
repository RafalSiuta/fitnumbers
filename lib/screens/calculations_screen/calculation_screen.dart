import 'package:flutter/material.dart';
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
    return Consumer3<ProfileProvider, LogicProvider, SettingsProvider>(
        builder: (context, profile, logic, settings, child){
          logic.userData = profile.userData;
      return Column(
        children: [
          Text('Calculetions'),
          Expanded(
              child: ListView.builder(
              itemCount: logic.numbersListCounter,
              itemBuilder: (context, index){
            final listData = logic.mainNumbersList[index];
            return Text('${listData.title}/ ${listData.value}');
          }))
        ],
      );
    });
  }
}
