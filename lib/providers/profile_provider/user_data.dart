import 'dart:collection';
import '../../model/slider_model/slider_model.dart';

class UserData {
  // num _bodySlider = 0.0;
  //
  // set bodySlider(double value) {
  //   this._bodySlider = value;
  // }
  //
  // double get bodySlider => _bodySlider;

  UserData();


  List<SliderModel> _userData = [
    SliderModel(
        name: 'age',
        unit: 'age',
        minValue: 0,
        maxValue: 150,
        sliderValue: 25),
    SliderModel(
        name: 'weight',
        unit: 'kg',
        minValue: 0,
        maxValue: 300,
        sliderValue: 90),
    SliderModel(
        name: 'height',
        unit: 'cm',
        minValue: 0,
        maxValue: 250,
        sliderValue: 187),
    SliderModel(
        name: 'waist',
        unit: 'cm',
        minValue: 0,
        maxValue: 300,
        sliderValue: 95),
    SliderModel(
        name: 'hip',
        unit: 'cm',
        minValue: 0,
        maxValue: 300,
        sliderValue: 110),
    SliderModel(
        name: 'neck',
        unit: 'cm',
        minValue: 0,
        maxValue: 150,
        sliderValue: 45),
  ];
  UnmodifiableListView<SliderModel> get userData {
    return UnmodifiableListView(_userData);
  }

  set userData(List<SliderModel> value) {
    _userData = value;
  }

  int get userDataListCounter => userData.length;
}
