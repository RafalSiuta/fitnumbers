import 'dart:collection';

import '../../model/nutrition_model/nutrition_settings_model.dart';

class NutritionOptionList {

  final List<NutritionSettingsModel> _nutritionOptionList = [
    NutritionSettingsModel(
        symbol: 'K',
        firstOption: 'option_protein_kcal_enable',
        secondOption: 'option_protein_gram_enable',
        value: true),
    NutritionSettingsModel(
        symbol: 'M',
        firstOption: 'option_carbo_kcal_enable',
        secondOption: 'option_carbo_gram_enable',
        value: true),
    NutritionSettingsModel(
        symbol: 'L',
        firstOption: 'option_fat_kcal_enable',
        secondOption: 'option_fat_gram_enable',
        value: true),
    NutritionSettingsModel(
        symbol: 'A',
        firstOption: 'option_max_kcal',
        secondOption: 'option_min_kcal',
        value: true),
  ];

  UnmodifiableListView<NutritionSettingsModel> get nutritionOptionList {
    return UnmodifiableListView(_nutritionOptionList);
  }

  int get nutritionListCounter => _nutritionOptionList.length;

}
