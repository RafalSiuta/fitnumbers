import 'dart:collection';
import '../../model/nutrition_model/nutrition_model.dart';
import '../../model/slider_model/slider_model.dart';

class UserNutrition {

  final List<SliderModel> _customNutritionList = [
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

  UnmodifiableListView<SliderModel> get customNutritionList {
    return UnmodifiableListView(_customNutritionList);
  }

  int get customNutritionListCounter {
    return _customNutritionList.length;
  }

  final List<NutritionModel> _defaultNutritionList =  [
     NutritionModel(
        name: 'weight loss',
        description: 'Set nutrition percentage with 35-50% protein, 25-45% carbohydrate, and 20-35% fat.',
        protein: 40,
        carbohydrate: 30,
        fat: 30),
    NutritionModel(
        name: 'maintain',
        description: 'Set nutrition percentage with 25-40% protein, 35-55% carbohydrate, and 25-40% fat.',
        protein: 30,
        carbohydrate: 40,
        fat: 30),
    NutritionModel(
        name: 'gain weight',
        description: 'Set nutrition percentage with 35% protein, 45% carbohydrate, and 20% fat.',
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

}