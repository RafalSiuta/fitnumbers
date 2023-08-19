import 'dart:collection';
import '../../model/nutrition_model/nutrition_model.dart';
import '../../model/slider_model/slider_model.dart';

class UserNutrition {
  // num _nutritionSlider = 0.0;
  // int _nutritionValue = 1;
  //
  // set nutritionValue(int value) {
  //   this._nutritionValue = value;
  // }
  //
  // set nutritionSlider(num value) {
  //   this._nutritionSlider = value;
  // }

  List<SliderModel> _nutritionList = [
    SliderModel(
        name: 'protein',
        unit: '%',
        minValue: 0,
        maxValue: 100,
        sliderValue: 20),
    SliderModel(
        name: 'carbo',
        unit: '%',
        minValue: 0,
        maxValue: 100,
        sliderValue: 45),
    SliderModel(
        name: 'fat',
        unit: '%',
        minValue: 0,
        maxValue: 100,
        sliderValue: 35),
  ];

  UnmodifiableListView<SliderModel> get nutritionList {
    return UnmodifiableListView(_nutritionList);
  }

  int get nutritionListCounter {
    return _nutritionList.length;
  }

  // set nutritionList(List<SliderModel> value) {
  //   this._nutritionList = value;
  // }
  //
  // num get nutritionSlider => this._nutritionSlider;

  List<NutritionModel> _defaultNutritionList = [
    NutritionModel(
        title: 'weight_loss',
        description: 'weight_loss_description',
        protein: 40,
        carbohydrate: 30,
        fat: 30),
    NutritionModel(
        title: 'maintain',
        description: 'maintain_description',
        protein: 30,
        carbohydrate: 40,
        fat: 30),
    NutritionModel(
        title: 'gain_weight',
        description: 'gain_weight_description',
        protein: 35,
        carbohydrate: 50,
        fat: 20),
  ];

  UnmodifiableListView<NutritionModel> get defaultNutritionList {
    return UnmodifiableListView(_defaultNutritionList);
  }

  int get defaultNutritionListCounter {
    return _defaultNutritionList.length;
  }

  // set defaultNutritionList(List<NutritionModel> value) {
  //   this._defaultNutritionList = value;
  // }
  //
  // int get nutritionValue => this._nutritionValue;
}