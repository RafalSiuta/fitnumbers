import 'package:fitnumbers2/providers/settings_provider/theme_option.dart';
import 'package:flutter/material.dart';
import '../../utils/constans/prefs_keys.dart';
import '../../utils/prefs/prefs.dart';
import 'bodyweight_option_list.dart';
import 'nutrition_option_list.dart';

class SettingsProvider extends ChangeNotifier {

  SettingsProvider(){
  initSettingsProvider();
  }

  initSettingsProvider() async {
    loadTheme();
    nutritionSettings = nutritionSettingsList.nutritionOptionList;
    weightSettings = weightOptionList.weightOptionTypeList;
    getNutritionOptionList();

  }

   final Prefs _prefs = Prefs();


  //theme setup:
  late ThemeMode _themeMode;

  bool currentTheme = true;

  getTheme() {
    if(currentTheme == true){
      _themeMode = ThemeMode.light;
    }else{
      _themeMode = ThemeMode.dark;
    }
    return _themeMode;
  }

  void loadTheme() async{
    currentTheme = await _prefs.restoreBool(themeMode, currentTheme);
    print("theme is loaded");
    print("current theme is ${currentTheme}");
  }

  void onThemeChange(bool sel){
    currentTheme = sel;
    _prefs.storeBool(themeMode, currentTheme);
    getTheme();
    print("switch theme is ${currentTheme}");
    notifyListeners();
  }

  //nutrition settings
  //TODO: set kcal or grams valu for protin and carbo counting
  bool isMaxKcal = true;
  bool isProteinKcal = true;
  bool isCarboKcal = true;
  bool isFatKcal = true;
  NutritionOptionList nutritionSettingsList = NutritionOptionList();
  List nutritionSettings = [];

  getNutritionOptionList() async {
    nutritionSettings =
        await _prefs.restoreSettingsList(nutritionSettingsOption, nutritionSettings);

    for(int i = 0; i < nutritionSettings.length; i++){
      switch(i){
        case 0:
          isProteinKcal = nutritionSettings[i].value;
          break;
        case 1:
          isCarboKcal = nutritionSettings[i].value;
          break;
        case 2:
          isFatKcal = nutritionSettings[i].value;
          break;
        case 3:
          isMaxKcal = nutritionSettings[i].value;
          break;

      }
    }
    notifyListeners();
  }

  onNutritionOption(bool value, int index) {
    nutritionSettings[index].value = value;
    _prefs.storeList(
        nutritionSettingsOption, nutritionSettings);
    getNutritionOptionList();
    notifyListeners();
  }

   WeightOptionList weightOptionList = WeightOptionList();
  List weightSettings = [];
  int weightChoice = 0;

  getBodyWeightOptionList() async {
    weightChoice  = await _prefs.restoreInt(
        weightOptionValue, weightChoice );
    notifyListeners();
  }

  onBodyWeightOption(int? index) {
    weightChoice = index!;
    _prefs.storeInt(weightOptionValue, weightChoice );
    notifyListeners();
  }
  // SavingTypeList savingTypeList = SavingTypeList();

}