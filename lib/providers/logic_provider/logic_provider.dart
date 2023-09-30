import 'dart:collection';
import 'dart:math';
import 'package:flutter/material.dart';
import '../../model/calculation_model/calculation_model.dart';
import '../../model/chart_model/chart_model.dart';
import '../../model/user_data_model/user_data_model.dart';

class LogicProvider extends ChangeNotifier {

  LogicProvider(){
    updateCalculationList();
  }
  UserDataModel userData = UserDataModel();

  List<CalculationModel> _numbersList = [];

  Future<List<CalculationModel>> _calculationsList() async {
    List<CalculationModel> list = [
      bmiResult(),
      bmrResult(),
    ];
    return list;
  }

  void updateCalculationList() async {
    _numbersList = await _calculationsList();
    notifyListeners();
  }

  UnmodifiableListView<CalculationModel> get mainNumbersList {
    return UnmodifiableListView(_numbersList);
  }

  int get numbersListCounter => _numbersList.length;

  // num selectedWeight() {
  //   num weight = 0;
  //   switch (this.selectWeightValue) {
  //     case 0:
  //       weight = this._weight;
  //       break;
  //     case 1:
  //       weight = this._potton.value;
  //       break;
  //     case 2:
  //       weight = this._lorenz.value;
  //       break;
  //     case 3:
  //       weight = this._leanWeight.value;
  //       break;
  //     default:
  //       weight = this._weight;
  //   }
  //   return weight;
  // }

  CalculationModel bmiResult({List<ChartModel>? chart}) {
    CalculationModel bmi = CalculationModel();
    try {
      bmi.value = userData.weight! / pow((userData.height! / 100), 2);
    } catch (e) {
      //default value:
      bmi.value = 0;
    } finally {
      if (bmi.value! < 18.5) {
        bmi.unit = 'bmi_underweight';
        bmi.description = 'bmi_underweight_description';
        bmi.infoColor = Colors.redAccent;
      } else if (bmi.value! >= 18.5 && bmi.value! <= 24.0) {
        bmi.unit = 'bmi_healthy_weight';
        bmi.description = 'bmi_healthy_weight_description';
        //bmi.infoColor = colorLightingColorDark;
      } else if (bmi.value! >= 24.0 && bmi.value! <= 24.99) {
        bmi.unit = 'bmi_ideal_weight';
        bmi.description = 'bmi_ideal_weight_description';
        //bmi.infoColor = colorLightingColorDark;
      } else if (bmi.value! >= 24.99 && bmi.value! <= 29.99) {
        bmi.unit = 'bmi_overweight';
        bmi.description = 'bmi_overweight_description';
        bmi.infoColor = Colors.yellow;
      } else if (bmi.value! >= 30) {
        bmi.unit = 'bmi_obese';
        bmi.description = 'bmi_obese_description';
        bmi.infoColor = Colors.redAccent;
      }

      bmi.symbol = 'N';
      bmi.title = 'bmi_title';
      bmi.shortTitle = 'BMI';
      bmi.longDescription = 'bmi_long_description';
      bmi.formulaMale = 'BMI = W / H ²';
      bmi.formulaFemale = "";
      bmi.chartList = chart; //bmiChart;
      bmi.imagePath = imagePath('male_index', 'female_index');
    }

    return bmi;
  }

  CalculationModel bmrResult({List<ChartModel>? chart}) {
    CalculationModel bmr = CalculationModel();
    try {
      if (userData.gender == true) {
        bmr.value = 66.47 + (13.75 * userData.weight!) + (5 * userData.height!) - (6.75 * userData.age!);
      } else {
        bmr.value = 665.09 + (9.56 * userData.weight!) + (1.85 * userData.height!) - (4.67 * userData.age!);
      }
    } catch (e) {
      bmr.value = 0;
    } finally {
      bmr.symbol = 'B';
      bmr.shortTitle = 'BMR';
      bmr.title = 'bmr_title';
      bmr.unit = 'bmr_unit';
      bmr.description = 'bmr_description';
      bmr.longDescription = 'bmr_long_description';
      bmr.formulaMale = 'BMR = 66.47 + (13.75 * W ) + (5 * H) - (6.75 * A)';
      bmr.formulaFemale =
      'BMR = 665.09 + (9.56 * W ) + (1.85 * H) - (4.67 * A)';
      bmr.chartList = chart; //bmrChart;
      bmr.imagePath = imagePath('male_food', 'female_food');
      //displayColorValue = colorLightingColorDark;
    }

    return bmr;
  }

  // CalculationModel terResult({List<ChartModel> chart}) {
  //   try {
  //     if (gender == true) {
  //       _ter.value = 66.47 + (13.75 * weight) + (5 * height) - (6.75 * age);
  //     } else {
  //       _ter.value = 665.09 + (9.56 * weight) + (1.85 * height) - (4.67 * age);
  //     }
  //     switch (activity) {
  //       case 0:
  //         _ter.value = _ter.value * 1.2;
  //         break;
  //       case 1:
  //         _ter.value = _ter.value * 1.4;
  //         break;
  //       case 2:
  //         _ter.value = _ter.value * 1.6;
  //         break;
  //       case 3:
  //         _ter.value = _ter.value * 1.75;
  //         break;
  //       case 4:
  //         _ter.value = _ter.value * 1.9;
  //         break;
  //     }
  //   } catch (e) {
  //     _ter.value = 0;
  //   } finally {
  //     _ter.symbol = 'A';
  //     _ter.shortTitle = 'TER';
  //     _ter.title = 'ter_title';
  //     _ter.unit = 'ter_unit';
  //     _ter.description = 'ter_description';
  //     _ter.longDescription = 'ter_long_description';
  //     _ter.formulaMale =
  //     'BMR = 66.47 + (13.75 * W ) + (5 * H) - (6.75 * A) \n TER = BMR * AC ';
  //     _ter.formulaFemale =
  //     'BMR = 665.09 + (9.56 * W ) + (1.85 * H) - (4.67 * A) \n TER = BMR * AC ';
  //     _ter.chartList = chart;
  //     displayColorValue = colorLightingColorDark;
  //     _ter.imagePath = imagePath('male_food_prot', 'female_food_fat');
  //   }
  //
  //   return _ter;
  // }
  //
  // CalculationModel ymcaResult({List<ChartModel> chart}) {
  //   try {
  //     if (gender == true) {
  //       //MALE
  //       _ymca.value =
  //           ((1.634 * waist - 0.1804 * weight - 98.42) / 2.2 * weight) / 100;
  //     } else {
  //       //FEMALE
  //       _ymca.value =
  //           ((1.643 * waist - 0.1804 * weight - 76.76) / 2.2 * weight) / 100;
  //     }
  //   } catch (e) {
  //     _ymca.value = 7;
  //   } finally {
  //     if (gender == true) {
  //       if (_ymca.value >= 3 && _ymca.value <= 5) {
  //         _ymca.unit = 'ymca_essential_fat';
  //       } else if (_ymca.value >= 6 && _ymca.value <= 14) {
  //         _ymca.unit = 'ymca_athletes';
  //       } else if (_ymca.value > 14 && _ymca.value <= 18) {
  //         _ymca.unit = 'ymca_fitness';
  //       } else if (_ymca.value > 18 && _ymca.value <= 25) {
  //         _ymca.unit = 'ymca_average';
  //       } else if (_ymca.value > 25) {
  //         _ymca.unit = 'ymca_obese';
  //       }
  //     } else {
  //       if (_ymca.value >= 10 && _ymca.value <= 14) {
  //         _ymca.unit = 'ymca_essential_fat';
  //       } else if (_ymca.value > 14 && _ymca.value <= 21) {
  //         _ymca.unit = 'ymca_athletes';
  //       } else if (_ymca.value > 21 && _ymca.value <= 25) {
  //         _ymca.unit = 'ymca_fitness';
  //       } else if (_ymca.value > 25 && _ymca.value <= 32) {
  //         _ymca.unit = 'ymca_average';
  //       } else if (_ymca.value > 32) {
  //         _ymca.unit = 'ymca_obese';
  //       }
  //     }
  //
  //     _ymca.symbol = 'H';
  //     _ymca.title = 'ymca_title';
  //     _ymca.shortTitle = 'YMCA';
  //     _ymca.description = 'ymca_description';
  //     _ymca.longDescription = 'ymca_long_description';
  //     _ymca.formulaMale =
  //     'YMCA = ((1.634 * Wa - 0.1804 * W - 98.42) / 2.2 * W) / 100 ';
  //     _ymca.formulaFemale =
  //     'YMCA = ((1.634 * Wa - 0.1804 * W - 76.76) / 2.2 * W) / 100  ';
  //     _ymca.chartList = chart;
  //     _ymca.imagePath = imagePath('male_index2', 'female_index2');
  //     displayColorValue = colorLightingColorDark;
  //   }
  //
  //   return this._ymca;
  // }
  //
  // CalculationModel aymcaResult({List<ChartModel> chart}) {
  //   try {
  //     if (gender == true) {
  //       _aymca.value = 495 /
  //           (1.0324 -
  //               .19077 * (log(waist - neck) / log(10)) +
  //               .15456 * (log(height) / log(10))) -
  //           450;
  //     } else {
  //       _aymca.value = 495 /
  //           (1.29579 -
  //               .35004 * (log(waist + hip - neck) / log(10)) +
  //               .22100 * (log(height) / log(10))) -
  //           450;
  //     }
  //     _aymca.value = (_aymca.value * weight) / 100;
  //     _aymca.value *= 0.45359237;
  //   } catch (e) {
  //     _aymca.value = 0;
  //   } finally {
  //     if (gender == true) {
  //       if (_aymca.value >= 3 && _aymca.value <= 5) {
  //         _aymca.unit = 'aymca_essential_fat';
  //       } else if (_aymca.value >= 6 && _aymca.value <= 14) {
  //         _aymca.unit = 'aymca_athletes';
  //       } else if (_aymca.value > 14 && _aymca.value <= 18) {
  //         _aymca.unit = 'aymca_fitness';
  //       } else if (_aymca.value > 18 && _aymca.value <= 25) {
  //         _aymca.unit = 'aymca_average';
  //       } else if (_aymca.value > 25) {
  //         _aymca.unit = 'aymca_obese';
  //       }
  //     } else {
  //       if (_aymca.value >= 10 && _aymca.value <= 14) {
  //         _aymca.unit = 'aymca_essential fat';
  //       } else if (_aymca.value > 14 && _aymca.value <= 21) {
  //         _aymca.unit = 'aymca_athletes';
  //       } else if (_aymca.value > 21 && _aymca.value <= 25) {
  //         _aymca.unit = 'aymca_fitness';
  //       } else if (_aymca.value > 25 && _aymca.value <= 32) {
  //         _aymca.unit = 'aymca_average';
  //       } else if (_aymca.value > 32) {
  //         _aymca.unit = 'aymca_obese';
  //       }
  //     }
  //     _aymca.symbol = 'I';
  //     _aymca.title = 'aymca_title';
  //     _aymca.shortTitle = 'YMCA navy';
  //     _aymca.description = 'aymca_description';
  //     _aymca.longDescription = 'aymca_long_description';
  //     _aymca.formulaMale =
  //     'BF = 495 / (1.0324 - 0.19077 * (log(Wa - N) / log(10)) + 0.15456 * (log(H) / log(10))) - 450 \n BF = ((BF * W) / 100)  * 0.45359237';
  //     _aymca.formulaFemale =
  //     'BF = 495 / (1.29579 - 0.35004 * (log(Wa[cm] + Hi - N) / log(10)) + 0.22100 * (log(H) / log(10))) - 450 \n BF = ((BF * W) / 100)  * 0.45359237 ';
  //     _aymca.chartList = chart;
  //     _aymca.imagePath = imagePath('male_index3', 'female_index3');
  //
  //     displayColorValue = colorLightingColorDark;
  //   }
  //
  //   return this._aymca;
  // }
  //
  // CalculationModel whrResult({List<ChartModel> chart}) {
  //   try {
  //     _whr.value = waist / hip;
  //   } catch (e) {
  //     _whr.value = 0.80;
  //   } finally {
  //     if (gender == true) {
  //       if (_whr.value <= 0.95) {
  //         _whr.unit = 'whr_good';
  //         _whr.description = 'whr_good_description';
  //         displayColorValue = colorLightingColorDark;
  //       } else if (_whr.value <= 0.99) {
  //         _whr.unit = 'whr_average';
  //         _whr.description = 'whr_average_description';
  //         displayColorValue = Colors.yellow;
  //       } else if (_whr.value >= 1.0) {
  //         _whr.unit = 'whr_high';
  //         _whr.description = 'whr_high_description';
  //         displayColorValue = Colors.redAccent;
  //       }
  //     } else {
  //       if (_whr.value <= 0.80) {
  //         displayColorValue = colorLightingColorDark;
  //         _whr.unit = 'whr_good';
  //         _whr.description = 'whr_good_description';
  //       } else if (_whr.value <= 0.84) {
  //         displayColorValue = Colors.yellow;
  //         _whr.unit = 'whr_average';
  //         _whr.description = 'whr_average_description';
  //       } else if (_whr.value >= 0.85) {
  //         displayColorValue = Colors.redAccent;
  //         _whr.unit = 'whr_high';
  //         _whr.description = 'whr_high_description';
  //       }
  //     }
  //     _whr.symbol = 'O';
  //     _whr.title = 'whr_title';
  //     _whr.shortTitle = 'WHR';
  //     _whr.longDescription = 'whr_long_description';
  //     _whr.formulaMale = 'WHR = Wa / Hi ';
  //     _whr.formulaFemale = "";
  //     _whr.chartList = chart;
  //     _whr.imagePath = imagePath('male_index1', 'female_index2');
  //
  //     displayColorValue = colorLightingColorDark;
  //   }
  //   return _whr;
  // }
  //
  // CalculationModel whtrResult({List<ChartModel> chart}) {
  //   try {
  //     _whtr.value = waist / height;
  //   } catch (e) {
  //     _whtr.value = 0.80;
  //   } finally {
  //     if (gender == true) {
  //       if (_whtr.value < 0.34) {
  //         _whtr.unit = 'whtr_extremely_slim';
  //         _whtr.description = 'whtr_extremely_slim_description';
  //         displayColorValue = Colors.redAccent;
  //       } else if (_whtr.value > 0.35 && _whtr.value <= 0.43) {
  //         _whtr.unit = 'whtr_slim';
  //         _whtr.description = 'whtr_slim_description';
  //         displayColorValue = Colors.yellow;
  //       } else if (_whtr.value > 0.43 && _whtr.value <= 0.52) {
  //         _whtr.unit = 'whtr_healthy';
  //         _whtr.description = 'whtr_healthy_description';
  //         displayColorValue = colorLightingColorDark;
  //       } else if (_whtr.value >= 0.53 && _whtr.value <= 0.57) {
  //         _whtr.unit = 'whtr_overweight';
  //         _whtr.description = 'whtr_overweight_description';
  //         displayColorValue = Colors.yellow;
  //       } else if (_whtr.value >= 0.58 && _whtr.value <= 0.62) {
  //         _whtr.unit = 'whtr_very_overweight';
  //         _whtr.description = 'whtr_very_overweight_description';
  //         displayColorValue = Colors.yellow;
  //       } else if (_whtr.value > 0.63) {
  //         _whtr.unit = 'whtr_obese';
  //         _whtr.description = 'whtr_obese_description';
  //         displayColorValue = Colors.redAccent;
  //       }
  //     } else {
  //       if (_whtr.value < 0.34) {
  //         _whtr.unit = 'whtr_extremely_slim';
  //         _whtr.description = 'whtr_extremely_slim_description';
  //         displayColorValue = Colors.redAccent;
  //       } else if (_whtr.value > 0.35 && _whtr.value <= 0.42) {
  //         _whtr.unit = 'whtr_slim';
  //         _whtr.description = 'whtr_slim_description';
  //         displayColorValue = Colors.yellow;
  //       } else if (_whtr.value > 0.42 && _whtr.value <= 0.48) {
  //         _whtr.unit = 'whtr_healthy';
  //         _whtr.description = 'whtr_healthy_description';
  //         displayColorValue = colorLightingColorDark;
  //       } else if (_whtr.value >= 0.49 && _whtr.value <= 0.53) {
  //         _whtr.unit = 'whtr_overweight';
  //         _whtr.description = 'whtr_overweight_description';
  //         displayColorValue = Colors.yellow;
  //       } else if (_whtr.value > 0.53 && _whtr.value <= 0.57) {
  //         _whtr.unit = 'whtr_very_overweight';
  //         _whtr.description = 'whtr_very_overweight_description';
  //         displayColorValue = Colors.yellow;
  //       } else if (_whtr.value > 0.58) {
  //         _whtr.unit = 'whtr_obese';
  //         _whtr.description = 'whtr_obese_description';
  //         displayColorValue = Colors.redAccent;
  //       }
  //     }
  //
  //     _whtr.symbol = 'P';
  //     _whtr.title = 'whtr_title';
  //     _whtr.shortTitle = 'WHTR';
  //     _whtr.longDescription = 'whtr_long_description';
  //     _whtr.formulaMale = 'WHTR = Wa / H * 100';
  //     _whtr.formulaFemale = '';
  //     _whtr.chartList = chart;
  //     _whtr.imagePath = imagePath('male_index2', 'female_index');
  //     displayColorValue = colorLightingColorDark;
  //   }
  //
  //   return _whtr;
  // }
  //
  // CalculationModel pottonResult({List<ChartModel> chart}) {
  //   try {
  //     if (gender == true) {
  //       _potton.value = height - 100 - ((height - 100) / 20);
  //     } else {
  //       _potton.value = height - 100 - ((height - 100) / 10);
  //     }
  //   } catch (e) {
  //     _potton.value = 0;
  //   } finally {
  //     _potton.symbol = 'E';
  //     _potton.unit = 'potton_unit';
  //     _potton.description = 'potton_description';
  //     _potton.title = 'potton_title';
  //     _potton.shortTitle = 'Potton';
  //     _potton.longDescription = 'potton_long_description';
  //     _potton.formulaMale = 'Potton = H - 100 - ((H  - 100) / 10)';
  //     _potton.formulaFemale = 'Potton = H  - 100 - ((H  - 100) / 20)';
  //     _potton.chartList = chart;
  //     _potton.imagePath =
  //         imagePath('male_weight_potton', 'female_weight_potton');
  //     displayColorValue = colorLightingColorDark;
  //   }
  //
  //   return _potton;
  // }
  //
  // CalculationModel lorenzResult({List<ChartModel> chart}) {
  //   try {
  //     if (gender == true) {
  //       _lorenz.value = height - 100 - ((height - 150) / 4);
  //     } else {
  //       _lorenz.value = height - 100 - ((height - 150) / 2);
  //     }
  //   } catch (e) {
  //     _lorenz.value = 0;
  //   } finally {
  //     _lorenz.symbol = 'F';
  //     _lorenz.unit = 'lorenz_unit';
  //     _lorenz.description = 'lorenz_description';
  //     _lorenz.title = 'lorenz_title';
  //     _lorenz.shortTitle = 'Lorenz';
  //     _lorenz.longDescription = 'lorenz_long_description';
  //     _lorenz.formulaMale = 'Lorenz = H - 100 - ((H  - 150) / 2)';
  //     _lorenz.formulaFemale = 'Lorenz = H - 100 - ((H  - 150) / 4)';
  //     _lorenz.chartList = chart;
  //     _lorenz.imagePath = imagePath('male_weight', 'female_weight');
  //     displayColorValue = colorLightingColorDark;
  //   }
  //
  //   return _lorenz;
  // }
  //
  // CalculationModel pureWeightResult({List<ChartModel> chart}) {
  //   double fatWeight;
  //   try {
  //     if (gender == true) {
  //       fatWeight = 495 /
  //           (1.0324 -
  //               .19077 * (log(waist - neck) / log(10)) +
  //               .15456 * (log(height) / log(10))) -
  //           450;
  //     } else {
  //       fatWeight = 495 /
  //           (1.29579 -
  //               .35004 * (log(waist + hip - neck) / log(10)) +
  //               .22100 * (log(height) / log(10))) -
  //           450;
  //     }
  //     fatWeight = (fatWeight * weight) / 100;
  //     fatWeight *= 0.45359237;
  //     _leanWeight.value = weight - fatWeight;
  //   } catch (e) {
  //     _leanWeight.value = 0;
  //   } finally {
  //     _leanWeight.symbol = 'G';
  //     _leanWeight.unit = 'pureweight_unit';
  //     _leanWeight.description = 'pureweight_description';
  //     _leanWeight.title = 'pureweight_title';
  //     _leanWeight.shortTitle = 'LowFatWeight';
  //     _leanWeight.longDescription = 'pureweight_long_description';
  //     _leanWeight.formulaMale = 'LowFatWeight = W - BF';
  //     _leanWeight.formulaFemale = '';
  //     _leanWeight.chartList = chart;
  //     _leanWeight.imagePath = imagePath('male_weight_fat', 'female_weight_fat');
  //
  //     displayColorValue = colorLightingColorDark;
  //   }
  //
  //   return _leanWeight;
  // }
  //
  // CalculationModel pureBmrResult({List<ChartModel> chart}) {
  //   num selectWeight = selectedWeight();
  //
  //   try {
  //     if (gender == true) {
  //       _pureBmr.value =
  //           66.47 + (13.75 * selectWeight) + (5 * height) - (6.75 * age);
  //     } else {
  //       _pureBmr.value =
  //           665.09 + (9.56 * selectWeight) + (1.85 * height) - (4.67 * age);
  //     }
  //   } catch (e) {
  //     _pureBmr.value = 0;
  //   } finally {
  //     _pureBmr.symbol = 'D';
  //     _pureBmr.shortTitle = 'Lean BMR';
  //     _pureBmr.title = 'purebmr_title';
  //     _pureBmr.unit = 'bmr_unit';
  //     _pureBmr.description = 'purebmr_description';
  //     _pureBmr.longDescription = 'purebmr_long_description';
  //     _pureBmr.formulaMale =
  //     'BMR = 66.47 + (13.75 * W ) + (5 * H) - (6.75 * A)';
  //     _pureBmr.formulaFemale =
  //     'BMR = 665.09 + (9.56 * W ) + (1.85 * H) - (4.67 * A)';
  //     _pureBmr.chartList = chart;
  //     _pureBmr.imagePath = imagePath('male_index2', 'female_index3');
  //
  //     displayColorValue = colorLightingColorDark;
  //   }
  //
  //   return _pureBmr;
  // }
  //
  // CalculationModel pureTerResult({List<ChartModel> chart}) {
  //   num selectWeight = selectedWeight();
  //   try {
  //     if (gender == true) {
  //       _pureTer.value =
  //           66.47 + (13.75 * selectWeight) + (5 * height) - (6.75 * age);
  //     } else {
  //       _pureTer.value =
  //           665.09 + (9.56 * selectWeight) + (1.85 * height) - (4.67 * age);
  //     }
  //     switch (activity) {
  //       case 0:
  //         _pureTer.value = _pureTer.value * 1.2;
  //         break;
  //       case 1:
  //         _pureTer.value = _pureTer.value * 1.4;
  //         break;
  //       case 2:
  //         _pureTer.value = _pureTer.value * 1.6;
  //         break;
  //       case 3:
  //         _pureTer.value = _pureTer.value * 1.75;
  //         break;
  //       case 4:
  //         _pureTer.value = _pureTer.value * 1.9;
  //         break;
  //     }
  //   } catch (e) {
  //     _pureTer.value = 0;
  //   } finally {
  //     _pureTer.symbol = 'C';
  //     _pureTer.shortTitle = 'Lean TER';
  //     _pureTer.title = 'pureter_title';
  //     _pureTer.unit = 'ter_unit';
  //     _pureTer.description = 'pureter_description';
  //     _pureTer.longDescription = 'pureter_long_description';
  //     _pureTer.formulaMale =
  //     'BMR = 66.47 + (13.75 * W ) + (5 * H) - (6.75 * A) \n TER = BMR * AC ';
  //     _pureTer.formulaFemale =
  //     'BMR = 665.09 + (9.56 * W ) + (1.85 * H) - (4.67 * A) \n TER = BMR * AC ';
  //     _pureTer.chartList = chart;
  //     _pureTer.imagePath = imagePath('male_index', 'female_index');
  //
  //     displayColorValue = colorLightingColorDark;
  //   }
  //
  //   return _pureTer;
  // }
  //
  // CalculationModel waterIntakeResult({List<ChartModel> chart}) {
  //   num selectWeight = selectedWeight();
  //
  //   try {
  //     _water.value = (selectWeight * 30) / 1000;
  //   } catch (e) {
  //     _water.value = 0;
  //   } finally {
  //     _water.symbol = 'J';
  //     _water.shortTitle = 'H2O';
  //     _water.title = 'water_title';
  //     _water.unit = 'water_unit';
  //     _water.description = 'water_description';
  //     _water.longDescription = 'water_long_description';
  //     _water.formulaMale = 'H2O = (W * 30) / 1000';
  //     _water.formulaFemale = "";
  //     _water.chartList = chart;
  //     _water.imagePath = imagePath('male_water', 'female_water');
  //     displayColorValue = colorLightingColorDark;
  //   }
  //   return _water;
  // }
  //
  // CalculationModel proteinIntakeResult({List<ChartModel> chart}) {
  //   num selectWeight = selectedWeight();
  //   num bmr;
  //
  //   try {
  //     if (gender == true) {
  //       bmr = 66.47 + (13.75 * selectWeight) + (5 * height) - (6.75 * age);
  //     } else {
  //       bmr = 665.09 + (9.56 * selectWeight) + (1.85 * height) - (4.67 * age);
  //     }
  //     if (_isMinKcal == true) {
  //       switch (activity) {
  //         case 0:
  //           bmr = bmr * 1.2;
  //           break;
  //         case 1:
  //           bmr = bmr * 1.4;
  //           break;
  //         case 2:
  //           bmr = bmr * 1.6;
  //           break;
  //         case 3:
  //           bmr = bmr * 1.75;
  //           break;
  //         case 4:
  //           bmr = bmr * 1.9;
  //           break;
  //       }
  //     }
  //
  //     if (_isProteinKcal == true) {
  //       _proteinIntake.unit = "unit_kcal";
  //       _proteinIntake.value = (bmr * _protein) / 100;
  //     } else {
  //       _proteinIntake.unit = "unit_gram";
  //       _proteinIntake.value = (bmr * _protein) / 100;
  //       _proteinIntake.value /= 4;
  //     }
  //   } catch (e) {
  //     _proteinIntake.value = 0;
  //   } finally {
  //     _proteinIntake.symbol = "K";
  //     _proteinIntake.title = "protein_title";
  //     _proteinIntake.shortTitle = "PROTEIN";
  //     _proteinIntake.description = "protein_description";
  //     _proteinIntake.longDescription = "protein_long_description";
  //     _proteinIntake.formulaMale = "P = (K * M) / 100";
  //     _proteinIntake.formulaFemale = "";
  //     _proteinIntake.chartList = chart;
  //     _proteinIntake.imagePath = imagePath('male_food_prot', 'female_food');
  //     displayColorValue = colorLightingColorDark;
  //   }
  //
  //   return _proteinIntake;
  // }
  //
  // CalculationModel carboIntakeResult({List<ChartModel> chart}) {
  //   num selectWeight = selectedWeight();
  //
  //   num bmr;
  //
  //   try {
  //     if (gender == true) {
  //       bmr = 66.47 + (13.75 * selectWeight) + (5 * height) - (6.75 * age);
  //     } else {
  //       bmr = 665.09 + (9.56 * selectWeight) + (1.85 * height) - (4.67 * age);
  //     }
  //     if (_isMinKcal == true) {
  //       switch (activity) {
  //         case 0:
  //           bmr = bmr * 1.2;
  //           break;
  //         case 1:
  //           bmr = bmr * 1.4;
  //           break;
  //         case 2:
  //           bmr = bmr * 1.6;
  //           break;
  //         case 3:
  //           bmr = bmr * 1.75;
  //           break;
  //         case 4:
  //           bmr = bmr * 1.9;
  //           break;
  //       }
  //     }
  //
  //     if (_isCarboKcal == true) {
  //       _carboIntake.unit = "unit_kcal";
  //       _carboIntake.value = (bmr * _carbo) / 100;
  //     } else {
  //       _carboIntake.unit = "unit_gram";
  //       _carboIntake.value = (bmr * _carbo) / 100;
  //       _carboIntake.value /= 4;
  //     }
  //   } catch (e) {
  //     _carboIntake.value = 0;
  //   } finally {
  //     _carboIntake.symbol = "M";
  //     _carboIntake.title = "carbo_title";
  //     _carboIntake.shortTitle = "CARBO";
  //     _carboIntake.description = "carbo_description";
  //     _carboIntake.longDescription = "carbo_long_description";
  //     _carboIntake.formulaMale = "C = (K * M) / 100";
  //     _carboIntake.formulaFemale = "";
  //     _carboIntake.chartList = chart;
  //     _carboIntake.imagePath = imagePath('male_food', 'female_food_carbo');
  //     displayColorValue = colorLightingColorDark;
  //   }
  //
  //   return _carboIntake;
  // }
  //
  // CalculationModel fatIntakeResult({List<ChartModel> chart}) {
  //   num selectWeight = selectedWeight();
  //
  //   num bmr;
  //
  //   try {
  //     if (gender == true) {
  //       bmr = 66.47 + (13.75 * selectWeight) + (5 * height) - (6.75 * age);
  //     } else {
  //       bmr = 665.09 + (9.56 * selectWeight) + (1.85 * height) - (4.67 * age);
  //     }
  //     if (_isMinKcal == true) {
  //       switch (activity) {
  //         case 0:
  //           bmr = bmr * 1.2;
  //           break;
  //         case 1:
  //           bmr = bmr * 1.4;
  //           break;
  //         case 2:
  //           bmr = bmr * 1.6;
  //           break;
  //         case 3:
  //           bmr = bmr * 1.75;
  //           break;
  //         case 4:
  //           bmr = bmr * 1.9;
  //           break;
  //       }
  //     }
  //
  //     if (_isFatKcal == true) {
  //       _fatIntake.unit = "unit_kcal";
  //       _fatIntake.value = (bmr * _fat) / 100;
  //     } else {
  //       _fatIntake.unit = "unit_gram";
  //       _fatIntake.value = (bmr * _fat) / 100;
  //       _fatIntake.value /= 4;
  //     }
  //   } catch (e) {
  //     _fatIntake.value = 0;
  //   } finally {
  //     _fatIntake.symbol = "L";
  //     _fatIntake.title = "fat_title";
  //     _fatIntake.shortTitle = "FAT";
  //     _fatIntake.description = "fat_description";
  //     _fatIntake.longDescription = "fat_long_description";
  //     _fatIntake.formulaMale = "F = (K * M) / 100";
  //     _fatIntake.formulaFemale = "";
  //     _fatIntake.chartList = chart;
  //     _fatIntake.imagePath = imagePath('male_food_fat', 'female_food_fat');
  //     displayColorValue = colorLightingColorDark;
  //   }
  //
  //   return _fatIntake;
  // }
  //
  // CalculationModel maxHrResult({List<ChartModel> chart}) {
  //   num selectWeight = selectedWeight();
  //
  //   try {
  //     if (gender == true) {
  //       //male
  //       _maxHr.value = 210 - (0.5 * age) - (0.022 * selectWeight) + 4;
  //     } else {
  //       //female
  //       _maxHr.value = 210 - (0.5 * age) - (0.022 * selectWeight);
  //     }
  //   } catch (e) {
  //     _maxHr.value = 0;
  //   } finally {
  //     _maxHr.symbol = 'Q';
  //     _maxHr.shortTitle = 'MaxHR';
  //     _maxHr.title = 'maxhr_title';
  //     _maxHr.unit = 'maxhr_unit';
  //     _maxHr.description = 'maxhr_description';
  //     _maxHr.longDescription = 'maxhr_long_description';
  //     _maxHr.formulaMale = 'maxHR = 210 - (0.5 * A) - (0.022 * W) + 4';
  //     _maxHr.formulaFemale = 'maxHR = 210 - (0.5 * A) - (0.022 * W) ';
  //     _maxHr.chartList = chart;
  //     _maxHr.imagePath = imagePath('male_run', 'female_run');
  //     displayColorValue = colorLightingColorDark;
  //   }
  //   return _maxHr;
  // }
  //
  // CalculationModel benchResult({List<ChartModel> chart}) {
  //   try {
  //     _maxBenchPress.value = (_bench * 1.1307) + 0.6998;
  //   } catch (e) {
  //     _maxBenchPress.value = 0;
  //   } finally {
  //     _maxBenchPress.symbol = 'R';
  //     _maxBenchPress.shortTitle = 'Max Bench';
  //     _maxBenchPress.title = 'maxbench_title';
  //     _maxBenchPress.unit = 'maxbench_unit';
  //     _maxBenchPress.description = 'maxbench_description';
  //     _maxBenchPress.longDescription = 'maxbench_long_description';
  //     _maxBenchPress.formulaMale = 'Bp = (W * 1.1307) + 0.6998';
  //     _maxBenchPress.formulaFemale = "";
  //     _maxBenchPress.chartList = chart;
  //     _maxBenchPress.imagePath = imagePath('male_bench', 'female_bench');
  //     displayColorValue = colorLightingColorDark;
  //   }
  //
  //   return _maxBenchPress;
  // }
  //
  // CalculationModel squatResult({List<ChartModel> chart}) {
  //   try {
  //     _maxSquat.value = (_squat * 1.09703) + 14.2546;
  //   } catch (e) {
  //     _maxSquat.value = 0;
  //   } finally {
  //     _maxSquat.symbol = 'S';
  //     _maxSquat.shortTitle = 'Max Squat';
  //     _maxSquat.title = 'maxsquat_title';
  //     _maxSquat.unit = 'maxsquat_unit';
  //     _maxSquat.description = 'maxsquat_description';
  //     _maxSquat.longDescription = 'maxsquat_long_description';
  //     _maxSquat.formulaMale = 'Ms = (W * 1.09703) + 14.2546';
  //     _maxSquat.formulaFemale = "";
  //     _maxSquat.chartList = chart;
  //     _maxSquat.imagePath = imagePath('male_squat', 'female_squat');
  //     displayColorValue = colorLightingColorDark;
  //   }
  //
  //   return _maxSquat;
  // }
  //
  // CalculationModel deadLiftResult({List<ChartModel> chart}) {
  //   try {
  //     _maxDeadLift.value = (_deadLift * 1.09703) + 14.2546;
  //   } catch (e) {
  //     _maxDeadLift.value = 0;
  //   } finally {
  //     _maxDeadLift.symbol = 'T';
  //     _maxDeadLift.shortTitle = 'Max DeadLift';
  //     _maxDeadLift.title = 'maxdeadlift_title';
  //     _maxDeadLift.unit = 'maxdeadlift_unit';
  //     _maxDeadLift.description = 'maxdeadlift_description';
  //     _maxDeadLift.longDescription = 'maxdeadlift_long_description';
  //     _maxDeadLift.formulaMale = 'Md = (W * 1.09703) + 14.2546';
  //     _maxDeadLift.formulaFemale = "";
  //     _maxDeadLift.chartList = chart;
  //     _maxDeadLift.imagePath = imagePath('male_deadlift', 'female_deadlift');
  //     displayColorValue = colorLightingColorDark;
  //   }
  //
  //   return _maxDeadLift;
  // }

  String imagePath(String maleImagePath, String femaleImagePath) {
    if (userData.gender == true) {
      return maleImagePath;
    } else {
      return femaleImagePath;
    }
  }


}