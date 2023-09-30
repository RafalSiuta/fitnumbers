

import 'dart:collection';

import '../../model/calculation_model/calculation_model.dart';

class CalculationsList {

  List<CalculationModel> _calculations = [

  ];

  UnmodifiableListView<CalculationModel> get calculationsList {
    return UnmodifiableListView(_calculations);
  }

  int get weightCountingListCounter => _calculations.length;
}