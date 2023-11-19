import 'dart:collection';
import 'dart:math';
import 'package:flutter/material.dart';
import '../../model/calculation_model/calculation_model.dart';
import '../../model/chart_model/chart_model.dart';
import '../profile_provider/profile_provider.dart';
import '../settings_provider/settings_provider.dart';

class LogicProvider extends ChangeNotifier {

  LogicProvider( this.profile, this.settings){
    updateCalculationList();
  }

  //TODO:  load chart database in calculations logic

  //TODO: add settings provider calculation options, and add to proxyProvider



  ProfileProvider profile;
  SettingsProvider settings;

  List<CalculationModel> _numbersList = [];

  Future<List<CalculationModel>> _calculationsList() async {
    List<CalculationModel> list = [
      bmiResult(),
      bmrResult(),
      terResult(),
      ymcaResult(),
      aymcaResult(),
      whrResult(),
      whtrResult(),
      pottonResult(),
      pureWeightResult(),
      waterIntakeResult(),
      proteinIntakeResult(),
      carboIntakeResult(),
      fatIntakeResult(),
      benchResult(),
      squatResult(),
      deadLiftResult()
    ];
    notifyListeners();
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

  //warning color setter:
  Color checkWarning(int status){
    Color? infoColor;
    infoColor ??= Colors.green;
    switch(status){
      case 0:
        infoColor = Colors.green;

        break;
      case 1:
        infoColor = Colors.amber;

        break;
      case 2:
        infoColor = Colors.red;

        break;
    }
    notifyListeners();
    return infoColor;
  }

  //TODO APPLY ONLY FOR CALORIES COUNTING
  double selectedWeight() {
    double weight = 0;
    switch (settings.weightChoice) {
      case 0:
        weight = profile.userData.weight!;
        break;
      case 1:
       weight = pottonResult().value!;
        break;
      case 2:
       weight = lorenzResult().value!;
        break;
      case 3:
        weight = pureWeightResult().value!;
        break;
      default:
        weight = profile.userData.weight!;
    }
    notifyListeners();
    return weight;
  }

  CalculationModel bmiResult({List<ChartModel>? chart}) {
    CalculationModel bmi = CalculationModel();
    try {
      bmi.value = profile.userData.weight! / pow((profile.userData.height! / 100), 2);
    } catch (e) {
      //default value:
      bmi.value = 0;
    } finally {
      if (bmi.value! < 18.5) {
        bmi.unit = 'bmi_underweight';
        bmi.description = 'bmi_underweight_description';
        bmi.infoColor = checkWarning( 2);
      } else if (bmi.value! >= 18.5 && bmi.value! <= 24.0) {
        bmi.unit = 'bmi_healthy_weight';
        bmi.description = 'bmi_healthy_weight_description';
        bmi.infoColor = checkWarning( 0);
      } else if (bmi.value! >= 24.0 && bmi.value! <= 24.99) {
        bmi.unit = 'bmi_ideal_weight';
        bmi.description = 'bmi_ideal_weight_description';
        bmi.infoColor = checkWarning( 0);
      } else if (bmi.value! >= 24.99 && bmi.value! <= 29.99) {
        bmi.unit = 'bmi_overweight';
        bmi.description = 'bmi_overweight_description';
        bmi.infoColor = checkWarning( 1);
      } else if (bmi.value! >= 30) {
        bmi.unit = 'bmi_obese';
        bmi.description = 'bmi_obese_description';
        bmi.infoColor = checkWarning( 2);
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
    notifyListeners();
    return bmi;
  }

  CalculationModel bmrResult({List<ChartModel>? chart}) {
    CalculationModel bmr = CalculationModel();
    double weight = selectedWeight();
    try {
      if (profile.userData.gender == true) {
        bmr.value = 66.47 + (13.75 * weight ) + (5 * profile.userData.height!) - (6.75 * profile.userData.age!);
      } else {
        bmr.value = 665.09 + (9.56 * weight ) + (1.85 * profile.userData.height!) - (4.67 * profile.userData.age!);
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
      bmr.infoColor = checkWarning(0);
      notifyListeners();
    }
    notifyListeners();
    return bmr;
  }

  CalculationModel terResult({List<ChartModel>? chart}) {
    CalculationModel ter = CalculationModel();
    double weight = selectedWeight();
    try {
      if (profile.userData.gender == true) {
        ter.value = 66.47 + (13.75 * weight) + (5 * profile.userData.height!) - (6.75 * profile.userData.age!);
      } else {
        ter.value = 665.09 + (9.56 * weight) + (1.85 * profile.userData.height!) - (4.67 * profile.userData.age!);
      }
      switch (profile.userData.activity) {
        case 0:
          ter.value = ter.value! * 1.2;
          break;
        case 1:
          ter.value = ter.value! * 1.4;
          break;
        case 2:
          ter.value = ter.value! * 1.6;
          break;
        case 3:
          ter.value = ter.value! * 1.75;
          break;
        case 4:
          ter.value = ter.value! * 1.9;
          break;
      }
    } catch (e) {
      ter.value = 0;
    } finally {
      ter.symbol = 'A';
      ter.shortTitle = 'TER';
      ter.title = 'ter_title';
      ter.unit = 'ter_unit';
      ter.description = 'ter_description';
      ter.longDescription = 'ter_long_description';
      ter.formulaMale =
      'BMR = 66.47 + (13.75 * W ) + (5 * H) - (6.75 * A) \n TER = BMR * AC ';
      ter.formulaFemale =
      'BMR = 665.09 + (9.56 * W ) + (1.85 * H) - (4.67 * A) \n TER = BMR * AC ';
      ter.chartList = chart;
      ter.infoColor = checkWarning(0);
      ter.imagePath = imagePath('male_food_prot', 'female_food_fat');
      notifyListeners();
    }

    return ter;
  }
  //
  CalculationModel ymcaResult({List<ChartModel>? chart}) {
    CalculationModel ymca = CalculationModel();
    try {
      if (profile.userData.gender == true) {
        //MALE
        ymca.value =
            ((1.634 * profile.userData.waist! - 0.1804 * profile.userData.weight! - 98.42) / 2.2 * profile.userData.weight!) / 100;
      } else {
        //FEMALE
        ymca.value =
            ((1.643 * profile.userData.waist! - 0.1804 * profile.userData.weight! - 76.76) / 2.2 * profile.userData.weight!) / 100;
      }
    } catch (e) {
      ymca.value = 7;
    } finally {
      if (profile.userData.gender == true) {
        if (ymca.value! >= 3 && ymca.value! <= 5) {
          ymca.unit = 'ymca_essential_fat';
          ymca.infoColor = checkWarning(0);
        } else if (ymca.value! >= 6 && ymca.value! <= 14) {
          ymca.unit = 'ymca_athletes';
          ymca.infoColor = checkWarning(0);
        } else if (ymca.value! > 14 && ymca.value! <= 18) {
          ymca.unit = 'ymca_fitness';
          ymca.infoColor = checkWarning(0);
        } else if (ymca.value! > 18 && ymca.value! <= 25) {
          ymca.unit = 'ymca_average';
          ymca.infoColor = checkWarning(1);
        } else if (ymca.value! > 25) {
          ymca.unit = 'ymca_obese';
          ymca.infoColor = checkWarning(2);
        }
      } else {
        if (ymca.value! >= 10 && ymca.value! <= 14) {
          ymca.unit = 'ymca_essential_fat';
          ymca.infoColor = checkWarning(0);
        } else if (ymca.value! > 14 && ymca.value! <= 21) {
          ymca.unit = 'ymca_athletes';
          ymca.infoColor = checkWarning(0);
        } else if (ymca.value! > 21 && ymca.value! <= 25) {
          ymca.unit = 'ymca_fitness';
          ymca.infoColor = checkWarning(0);
        } else if (ymca.value! > 25 && ymca.value! <= 32) {
          ymca.unit = 'ymca_average';
          ymca.infoColor = checkWarning(1);
        } else if (ymca.value! > 32) {
          ymca.unit = 'ymca_obese';
          ymca.infoColor = checkWarning(2);
        }
      }

      ymca.symbol = 'H';
      ymca.title = 'ymca_title';
      ymca.shortTitle = 'YMCA';
      ymca.description = 'ymca_description';
      ymca.longDescription = 'ymca_long_description';
      ymca.formulaMale =
      'YMCA = ((1.634 * Wa - 0.1804 * W - 98.42) / 2.2 * W) / 100 ';
      ymca.formulaFemale =
      'YMCA = ((1.634 * Wa - 0.1804 * W - 76.76) / 2.2 * W) / 100  ';
      ymca.chartList = chart;
      ymca.imagePath = imagePath('male_index2', 'female_index2');

    }
    notifyListeners();
    return ymca;
  }
  //
  CalculationModel aymcaResult({List<ChartModel>? chart}) {
    CalculationModel aymca = CalculationModel();
    try {
      if (profile.userData.gender == true) {
        aymca.value = 495 /
            (1.0324 -
                .19077 * (log(profile.userData.waist! - profile.userData.neck!) / log(10)) +
                .15456 * (log(profile.userData.height!) / log(10))) -
            450;
      } else {
        aymca.value = 495 /
            (1.29579 -
                .35004 * (log(profile.userData.waist! + profile.userData.hips! - profile.userData.neck!) / log(10)) +
                .22100 * (log(profile.userData.height!) / log(10))) -
            450;
      }
      aymca.value = (aymca.value! * profile.userData.weight!) / 100;
      aymca.value = aymca.value! * 0.45359237;
    } catch (e) {
      aymca.value = 0;
    } finally {
      if (profile.userData.gender == true) {
        if (aymca.value! >= 3 && aymca.value! <= 5) {
          aymca.unit = 'aymca_essential_fat';
          aymca.infoColor = checkWarning(0);
        } else if (aymca.value! >= 6 && aymca.value! <= 14) {
          aymca.unit = 'aymca_athletes';
          aymca.infoColor = checkWarning(0);
        } else if (aymca.value! > 14 && aymca.value! <= 18) {
          aymca.unit = 'aymca_fitness';
          aymca.infoColor = checkWarning(0);
        } else if (aymca.value! > 18 && aymca.value! <= 25) {
          aymca.unit = 'aymca_average';
          aymca.infoColor = checkWarning(1);
        } else if (aymca.value! > 25) {
          aymca.unit = 'aymca_obese';
          aymca.infoColor = checkWarning(2);
        }
      } else {
        if (aymca.value! >= 10 && aymca.value! <= 14) {
          aymca.unit = 'aymca_essential fat';
          aymca.infoColor = checkWarning(0);
        } else if (aymca.value! > 14 && aymca.value! <= 21) {
          aymca.unit = 'aymca_athletes';
          aymca.infoColor = checkWarning(0);
        } else if (aymca.value! > 21 && aymca.value! <= 25) {
          aymca.unit = 'aymca_fitness';
          aymca.infoColor = checkWarning(0);
        } else if (aymca.value! > 25 && aymca.value! <= 32) {
          aymca.unit = 'aymca_average';
          aymca.infoColor = checkWarning(1);
        } else if (aymca.value! > 32) {
          aymca.unit = 'aymca_obese';
          aymca.infoColor = checkWarning(2);
        }
      }
      aymca.symbol = 'I';
      aymca.title = 'aymca_title';
      aymca.shortTitle = 'YMCA navy';
      aymca.description = 'aymca_description';
      aymca.longDescription = 'aymca_long_description';
      aymca.formulaMale =
      'BF = 495 / (1.0324 - 0.19077 * (log(Wa - N) / log(10)) + 0.15456 * (log(H) / log(10))) - 450 \n BF = ((BF * W) / 100)  * 0.45359237';
      aymca.formulaFemale =
      'BF = 495 / (1.29579 - 0.35004 * (log(Wa[cm] + Hi - N) / log(10)) + 0.22100 * (log(H) / log(10))) - 450 \n BF = ((BF * W) / 100)  * 0.45359237 ';
      aymca.chartList = chart;
      aymca.imagePath = imagePath('male_index3', 'female_index3');

    }
    notifyListeners();
    return aymca;
  }
  //
  CalculationModel whrResult({List<ChartModel>? chart}) {
    CalculationModel whr = CalculationModel();
    try {
      whr.value = profile.userData.waist! / profile.userData.hips!;
    } catch (e) {
      whr.value = 0.80;
    } finally {
      if (profile.userData.gender == true) {
        if (whr.value! <= 0.95) {
          whr.unit = 'whr_good';
          whr.description = 'whr_good_description';
          whr.infoColor = checkWarning(0);
        } else if (whr.value! <= 0.99) {
          whr.unit = 'whr_average';
          whr.description = 'whr_average_description';
          whr.infoColor = checkWarning(1);
        } else if (whr.value! >= 1.0) {
          whr.unit = 'whr_high';
          whr.description = 'whr_high_description';
          whr.infoColor = checkWarning(2);
        }
      } else {
        if (whr.value! <= 0.80) {
          whr.infoColor = checkWarning(0);
          whr.unit = 'whr_good';
          whr.description = 'whr_good_description';
        } else if (whr.value! <= 0.84) {
          whr.infoColor = checkWarning(1);
          whr.unit = 'whr_average';
          whr.description = 'whr_average_description';
        } else if (whr.value! >= 0.85) {
          whr.infoColor = checkWarning(2);
          whr.unit = 'whr_high';
          whr.description = 'whr_high_description';
        }
      }
      whr.symbol = 'O';
      whr.title = 'whr_title';
      whr.shortTitle = 'WHR';
      whr.longDescription = 'whr_long_description';
      whr.formulaMale = 'WHR = Wa / Hi ';
      whr.formulaFemale = "";
      whr.chartList = chart;
      whr.imagePath = imagePath('male_index1', 'female_index2');

    }
    notifyListeners();
    return whr;
  }
  //
  CalculationModel whtrResult({List<ChartModel>? chart}) {
    CalculationModel whtr = CalculationModel();
    try {
      whtr.value = profile.userData.waist! / profile.userData.height!;
    } catch (e) {
      whtr.value = 0.80;
    } finally {
      if (profile.userData.gender == true) {
        if (whtr.value! < 0.34) {
          whtr.unit = 'whtr_extremely_slim';
          whtr.description = 'whtr_extremely_slim_description';
          whtr.infoColor = checkWarning(2);
        } else if (whtr.value! > 0.35 && whtr.value! <= 0.43) {
          whtr.unit = 'whtr_slim';
          whtr.description = 'whtr_slim_description';
          whtr.infoColor = checkWarning(1);
        } else if (whtr.value! > 0.43 && whtr.value! <= 0.52) {
          whtr.unit = 'whtr_healthy';
          whtr.description = 'whtr_healthy_description';
          whtr.infoColor = checkWarning(0);
        } else if (whtr.value! >= 0.53 && whtr.value! <= 0.57) {
          whtr.unit = 'whtr_overweight';
          whtr.description = 'whtr_overweight_description';
          whtr.infoColor = checkWarning(1);
        } else if (whtr.value! >= 0.58 && whtr.value! <= 0.62) {
          whtr.unit = 'whtr_very_overweight';
          whtr.description = 'whtr_very_overweight_description';
          whtr.infoColor = checkWarning(1);
        } else if (whtr.value! > 0.63) {
          whtr.unit = 'whtr_obese';
          whtr.description = 'whtr_obese_description';
          whtr.infoColor = checkWarning(2);
        }
      } else {
        if (whtr.value! < 0.34) {
          whtr.unit = 'whtr_extremely_slim';
          whtr.description = 'whtr_extremely_slim_description';
          whtr.infoColor = checkWarning(2);
        } else if (whtr.value! > 0.35 && whtr.value! <= 0.42) {
          whtr.unit = 'whtr_slim';
          whtr.description = 'whtr_slim_description';
          whtr.infoColor = checkWarning(1);
        } else if (whtr.value! > 0.42 && whtr.value! <= 0.48) {
          whtr.unit = 'whtr_healthy';
          whtr.description = 'whtr_healthy_description';
          whtr.infoColor = checkWarning(0);
        } else if (whtr.value! >= 0.49 && whtr.value! <= 0.53) {
          whtr.unit = 'whtr_overweight';
          whtr.description = 'whtr_overweight_description';
          whtr.infoColor = checkWarning(1);
        } else if (whtr.value! > 0.53 && whtr.value! <= 0.57) {
          whtr.unit = 'whtr_very_overweight';
          whtr.description = 'whtr_very_overweight_description';
          whtr.infoColor = checkWarning(1);
        } else if (whtr.value! > 0.58) {
          whtr.unit = 'whtr_obese';
          whtr.description = 'whtr_obese_description';
          whtr.infoColor = checkWarning(2);
        }
      }

      whtr.symbol = 'P';
      whtr.title = 'whtr_title';
      whtr.shortTitle = 'WHTR';
      whtr.longDescription = 'whtr_long_description';
      whtr.formulaMale = 'WHTR = Wa / H * 100';
      whtr.formulaFemale = '';
      whtr.chartList = chart;
      whtr.imagePath = imagePath('male_index2', 'female_index');
    }
    notifyListeners();
    return whtr;
  }
  //
  CalculationModel pottonResult({List<ChartModel>? chart}) {
    CalculationModel potton = CalculationModel();
    try {
      if (profile.userData.gender == true) {
        potton.value = profile.userData.height! - 100 - ((profile.userData.height! - 100) / 20);
      } else {
        potton.value = profile.userData.height! - 100 - ((profile.userData.height! - 100) / 10);
      }
    } catch (e) {
      potton.value = 0;
    } finally {
      potton.symbol = 'E';
      potton.unit = 'potton_unit';
      potton.description = 'potton_description';
      potton.title = 'potton_title';
      potton.shortTitle = 'Potton';
      potton.longDescription = 'potton_long_description';
      potton.formulaMale = 'Potton = H - 100 - ((H  - 100) / 10)';
      potton.formulaFemale = 'Potton = H  - 100 - ((H  - 100) / 20)';
      potton.chartList = chart;
      potton.imagePath =
          imagePath('male_weight_potton', 'female_weight_potton');
      potton.infoColor = checkWarning(0);
    }
    notifyListeners();
    return potton;
  }
  //
  CalculationModel lorenzResult({List<ChartModel>? chart}) {
    CalculationModel lorenz = CalculationModel();
    try {
      if (profile.userData.gender == true) {
        lorenz.value = profile.userData.height! - 100 - ((profile.userData.height! - 150) / 4);
      } else {
        lorenz.value = profile.userData.height! - 100 - ((profile.userData.height! - 150) / 2);
      }
    } catch (e) {
      lorenz.value = 0;
    } finally {
      lorenz.symbol = 'F';
      lorenz.unit = 'lorenz_unit';
      lorenz.description = 'lorenz_description';
      lorenz.title = 'lorenz_title';
      lorenz.shortTitle = 'Lorenz';
      lorenz.longDescription = 'lorenz_long_description';
      lorenz.formulaMale = 'Lorenz = H - 100 - ((H  - 150) / 2)';
      lorenz.formulaFemale = 'Lorenz = H - 100 - ((H  - 150) / 4)';
      lorenz.chartList = chart;
      lorenz.imagePath = imagePath('male_weight', 'female_weight');
      lorenz.infoColor = checkWarning(0);
    }
    notifyListeners();
    return lorenz;
  }
  //
  CalculationModel pureWeightResult({List<ChartModel>? chart}) {
    CalculationModel leanWeight = CalculationModel();
    double fatWeight;
    try {
      if (profile.userData.gender == true) {
        fatWeight = 495 /
            (1.0324 -
                .19077 * (log(profile.userData.waist! - profile.userData.neck!) / log(10)) +
                .15456 * (log(profile.userData.height!) / log(10))) -
            450;
      } else {
        fatWeight = 495 /
            (1.29579 -
                .35004 * (log(profile.userData.waist! + profile.userData.hips! - profile.userData.neck!) / log(10)) +
                .22100 * (log(profile.userData.height!) / log(10))) -
            450;
      }
      fatWeight = (fatWeight * profile.userData.weight!) / 100;
      fatWeight *= 0.45359237;
      leanWeight.value = profile.userData.weight! - fatWeight;
    } catch (e) {
      leanWeight.value = 0;
    } finally {
      leanWeight.symbol = 'G';
      leanWeight.unit = 'pureweight_unit';
      leanWeight.description = 'pureweight_description';
      leanWeight.title = 'pureweight_title';
      leanWeight.shortTitle = 'LowFatWeight';
      leanWeight.longDescription = 'pureweight_long_description';
      leanWeight.formulaMale = 'LowFatWeight = W - BF';
      leanWeight.formulaFemale = '';
      leanWeight.chartList = chart;
      leanWeight.imagePath = imagePath('male_weight_fat', 'female_weight_fat');

      leanWeight.infoColor = checkWarning(0);
    }
    notifyListeners();
    return leanWeight;
  }

  // CalculationModel pureBmrResult({List<ChartModel>? chart}) {
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
  CalculationModel waterIntakeResult({List<ChartModel>? chart}) {
    CalculationModel water = CalculationModel();
    double selectWeight = selectedWeight();

    try {
      water.value = (selectWeight * 30) / 1000;
    } catch (e) {
      water.value = 0;
    } finally {
      water.symbol = 'J';
      water.shortTitle = 'H2O';
      water.title = 'water_title';
      water.unit = 'water_unit';
      water.description = 'water_description';
      water.longDescription = 'water_long_description';
      water.formulaMale = 'H2O = (W * 30) / 1000';
      water.formulaFemale = "";
      water.chartList = chart;
      water.imagePath = imagePath('male_water', 'female_water');
      water.infoColor = checkWarning(0);
    }
    notifyListeners();
    return water;
  }
  //
  CalculationModel proteinIntakeResult({List<ChartModel>? chart}) {
    CalculationModel proteinIntake = CalculationModel();
    double selectWeight = selectedWeight();
    double bmr;

    try {
      if (profile.userData.gender == true) {
        bmr = 66.47 + (13.75 * selectWeight) + (5 * profile.userData.height!) - (6.75 * profile.userData.age!);
      } else {
        bmr = 665.09 + (9.56 * selectWeight) + (1.85 * profile.userData.height!) - (4.67 * profile.userData.age!);
      }
      if (settings.isMaxKcal == true) {
        switch (profile.userData.activity) {
          case 0:
            bmr = bmr * 1.2;
            break;
          case 1:
            bmr = bmr * 1.4;
            break;
          case 2:
            bmr = bmr * 1.6;
            break;
          case 3:
            bmr = bmr * 1.75;
            break;
          case 4:
            bmr = bmr * 1.9;
            break;
        }
      }

      if (settings.isProteinKcal == true) {
        proteinIntake.unit = "unit_kcal";
        proteinIntake.value = (bmr * profile.userData.proteinPercent!) / 100;
      } else {
        proteinIntake.unit = "unit_gram";
        proteinIntake.value = (bmr * profile.userData.proteinPercent!) / 100;
        proteinIntake.value = proteinIntake.value! / 4;
      }
    } catch (e) {
      proteinIntake.value = 0;
    } finally {
      proteinIntake.symbol = "K";
      proteinIntake.title = "protein_title";
      proteinIntake.shortTitle = "PROTEIN";
      proteinIntake.description = "protein_description";
      proteinIntake.longDescription = "protein_long_description";
      proteinIntake.formulaMale = "P = (K * M) / 100";
      proteinIntake.formulaFemale = "";
      proteinIntake.chartList = chart;
      proteinIntake.imagePath = imagePath('male_food_prot', 'female_food');
      proteinIntake.infoColor = checkWarning(0);
    }
    notifyListeners();
    return proteinIntake;
  }
  //
  CalculationModel carboIntakeResult({List<ChartModel>? chart}) {
    //double selectWeight = selectedWeight();
    CalculationModel carboIntake = CalculationModel();
    double bmr = bmrResult().value!;

    try {
      // if (profile.userData.gender == true) {
      //   bmr = 66.47 + (13.75 * selectWeight) + (5 * profile.userData.height!) - (6.75 * profile.userData.age!);
      // } else {
      //   bmr = 665.09 + (9.56 * selectWeight) + (1.85 * profile.userData.height!) - (4.67 * profile.userData.age!);
      // }
      if (settings.isMaxKcal == true) {
        switch (profile.userData.activity) {
          case 0:
            bmr = bmr * 1.2;
            break;
          case 1:
            bmr = bmr * 1.4;
            break;
          case 2:
            bmr = bmr * 1.6;
            break;
          case 3:
            bmr = bmr * 1.75;
            break;
          case 4:
            bmr = bmr * 1.9;
            break;
        }
      }

      if (settings.isCarboKcal == true) {
        carboIntake.unit = "unit_kcal";
        carboIntake.value = (bmr * profile.userData.carbPercent!) / 100;
      } else {
        carboIntake.unit = "unit_gram";
        carboIntake.value = (bmr * profile.userData.carbPercent!) / 100;
        carboIntake.value = carboIntake.value! / 4;
      }
    } catch (e) {
      carboIntake.value = 0;
      print('SUM TING WONG CARBO KCAL ${e}\n Carbontake value: ${carboIntake.value}; Bmr value: ${bmr} Carb percent: ${profile.userData.carbPercent}');
    } finally {
      carboIntake.symbol = "M";
      carboIntake.title = "carbo_title";
      carboIntake.shortTitle = "CARBO";
      carboIntake.description = "carbo_description";
      carboIntake.longDescription = "carbo_long_description";
      carboIntake.formulaMale = "C = (K * M) / 100";
      carboIntake.formulaFemale = "";
      carboIntake.chartList = chart;
      carboIntake.imagePath = imagePath('male_food', 'female_food_carbo');
      carboIntake.infoColor = checkWarning(0);
    }
    notifyListeners();
    return carboIntake;
  }
  //
  CalculationModel fatIntakeResult({List<ChartModel>? chart}) {
    double selectWeight = selectedWeight();
    CalculationModel fatIntake = CalculationModel();
    double bmr;

    try {
      if (profile.userData.gender == true) {
        bmr = 66.47 + (13.75 * selectWeight) + (5 * profile.userData.height!) - (6.75 * profile.userData.age!);
      } else {
        bmr = 665.09 + (9.56 * selectWeight) + (1.85 * profile.userData.height!) - (4.67 * profile.userData.age!);
      }
      if (settings.isMaxKcal == true) {
        switch (profile.userData.activity) {
          case 0:
            bmr = bmr * 1.2;
            break;
          case 1:
            bmr = bmr * 1.4;
            break;
          case 2:
            bmr = bmr * 1.6;
            break;
          case 3:
            bmr = bmr * 1.75;
            break;
          case 4:
            bmr = bmr * 1.9;
            break;
        }
      }

      if (settings.isFatKcal == true) {
        fatIntake.unit = "unit_kcal";
        fatIntake.value = (bmr * profile.userData.fatPercent!) / 100;
      } else {
        fatIntake.unit = "unit_gram";
        fatIntake.value = (bmr * profile.userData.fatPercent!) / 100;
        fatIntake.value = fatIntake.value! / 4;
      }
    } catch (e) {
      fatIntake.value = 0;
    } finally {
      fatIntake.symbol = "L";
      fatIntake.title = "fat_title";
      fatIntake.shortTitle = "FAT";
      fatIntake.description = "fat_description";
      fatIntake.longDescription = "fat_long_description";
      fatIntake.formulaMale = "F = (K * M) / 100";
      fatIntake.formulaFemale = "";
      fatIntake.chartList = chart;
      fatIntake.imagePath = imagePath('male_food_fat', 'female_food_fat');
      fatIntake.infoColor = checkWarning(0);
    }
    notifyListeners();
    return fatIntake;
  }
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
  CalculationModel benchResult({List<ChartModel>? chart}) {
    CalculationModel maxBenchPress = CalculationModel();
    try {
      maxBenchPress.value = (profile.userData.benchPressPower! * 1.1307) + 0.6998;
    } catch (e) {
      maxBenchPress.value = 0;
    } finally {
      maxBenchPress.symbol = 'R';
      maxBenchPress.shortTitle = 'Max Bench';
      maxBenchPress.title = 'maxbench_title';
      maxBenchPress.unit = 'maxbench_unit';
      maxBenchPress.description = 'maxbench_description';
      maxBenchPress.longDescription = 'maxbench_long_description';
      maxBenchPress.formulaMale = 'Bp = (W * 1.1307) + 0.6998';
      maxBenchPress.formulaFemale = "";
      maxBenchPress.chartList = chart;
      maxBenchPress.imagePath = imagePath('male_bench', 'female_bench');
      maxBenchPress.infoColor = checkWarning(0);
    }
    notifyListeners();
    return maxBenchPress;
  }
  //
  CalculationModel squatResult({List<ChartModel>? chart}) {
    CalculationModel maxSquat = CalculationModel();
    try {
      maxSquat.value = (profile.userData.squatPower! * 1.09703) + 14.2546;
    } catch (e) {
      maxSquat.value = 0;
    } finally {
      maxSquat.symbol = 'S';
      maxSquat.shortTitle = 'Max Squat';
      maxSquat.title = 'maxsquat_title';
      maxSquat.unit = 'maxsquat_unit';
      maxSquat.description = 'maxsquat_description';
      maxSquat.longDescription = 'maxsquat_long_description';
      maxSquat.formulaMale = 'Ms = (W * 1.09703) + 14.2546';
      maxSquat.formulaFemale = "";
      maxSquat.chartList = chart;
      maxSquat.imagePath = imagePath('male_squat', 'female_squat');
      maxSquat.infoColor = checkWarning(0);
    }
    notifyListeners();
    return maxSquat;
  }
  //
  CalculationModel deadLiftResult({List<ChartModel>? chart}) {
    CalculationModel maxDeadLift = CalculationModel();
    try {
      maxDeadLift.value = (profile.userData.deadLiftPower! * 1.09703) + 14.2546;
    } catch (e) {
      maxDeadLift.value = 0;
    } finally {
      maxDeadLift.symbol = 'T';
      maxDeadLift.shortTitle = 'Max DeadLift';
      maxDeadLift.title = 'maxdeadlift_title';
      maxDeadLift.unit = 'maxdeadlift_unit';
      maxDeadLift.description = 'maxdeadlift_description';
      maxDeadLift.longDescription = 'maxdeadlift_long_description';
      maxDeadLift.formulaMale = 'Md = (W * 1.09703) + 14.2546';
      maxDeadLift.formulaFemale = "";
      maxDeadLift.chartList = chart;
      maxDeadLift.imagePath = imagePath('male_deadlift', 'female_deadlift');
      maxDeadLift.infoColor  = checkWarning(0);
    }
    notifyListeners();
    return maxDeadLift;
  }

  String imagePath(String maleImagePath, String femaleImagePath) {
    if (profile.userData.gender == true) {
      return maleImagePath;
    } else {
      return femaleImagePath;
    }
  }


}