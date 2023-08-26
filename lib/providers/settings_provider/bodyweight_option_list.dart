import 'dart:collection';
import '../../model/nutrition_model/nutrition_settings_model.dart';

class WeightOptionList {

  final List<NutritionSettingsModel> _weightOptionTypeList = [
    NutritionSettingsModel(
      symbol: 'E',
      firstOption: 'sets_macro_nutrients',
      secondOption: 'option_current_weight',
      value: false
    ),
    NutritionSettingsModel(
      symbol: 'F',
      firstOption: 'sets_macro_nutrients',
      secondOption: 'option_lorenz_weight',
        value: false
    ),
    NutritionSettingsModel(
      symbol: 'E',
      firstOption: 'sets_macro_nutrients',
      secondOption: 'option_potton_weight',
        value: false
    ),
    NutritionSettingsModel(
      symbol: 'G',
      firstOption: 'sets_macro_nutrients',
      secondOption: 'option_low_fat_weight',
        value: false
    ),
  ];

  UnmodifiableListView<NutritionSettingsModel> get weightOptionTypeList {
    return UnmodifiableListView(_weightOptionTypeList);
  }

  int get weightCountingListCounter => _weightOptionTypeList.length;

}
