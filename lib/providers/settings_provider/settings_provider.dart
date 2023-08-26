import 'package:flutter/material.dart';
import '../../utils/constans/prefs_keys.dart';
import '../../utils/prefs/prefs.dart';
import 'bodyweight_option_list.dart';
import 'nutrition_option_list.dart';

class SettingsProvider extends ChangeNotifier {

  SettingsProvider(){
  initSettingsProvider();
  }

  initSettingsProvider()async {
    nutritionSettings = nutritionSettingsList.nutritionOptionList;
    weightSettings = weightOptionList.weightOptionTypeList;
    getNutritionOptionList();
  }

  final Prefs _prefs = Prefs();


  //nutrition settings
  NutritionOptionList nutritionSettingsList = NutritionOptionList();
  List nutritionSettings = [];

  getNutritionOptionList() async {
    nutritionSettings =
        await _prefs.restoreSettingsList(nutritionSettingsOption, nutritionSettings);
  }

  onNutritionOption(bool value, int index) {
    nutritionSettings[index].value = value;
    _prefs.storeList(
        nutritionSettingsOption, nutritionSettings);
    notifyListeners();
  }

   WeightOptionList weightOptionList = WeightOptionList();
  List weightSettings = [];
  int weightChoice = 0;

  getBodyWeightOptionList() async {
    weightChoice  = await _prefs.restoreInt(
        weightOptionValue, weightChoice );
  }

  onBodyWeightOption(int? index) {
    weightChoice = index!;
    _prefs.storeInt(weightOptionValue, weightChoice );
    notifyListeners();
  }
  // SavingTypeList savingTypeList = SavingTypeList();

}