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
    notifyListeners();
  }

  onBodyWeightOption(int? index) {
    weightChoice = index!;
    _prefs.storeInt(weightOptionValue, weightChoice );
    notifyListeners();
  }
  // SavingTypeList savingTypeList = SavingTypeList();

}