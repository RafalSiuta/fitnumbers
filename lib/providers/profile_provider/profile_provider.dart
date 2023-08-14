

import 'package:flutter/cupertino.dart';

class ProfileProvider extends ChangeNotifier{

  ProfileProvider(){

  }
//gender setup
  bool isGenderSelected = true;

  void onGenderSelect(bool sel){
    isGenderSelected = sel;
    notifyListeners();
  }

  //body slider setup:
  double age = 0.0;

  void setBodySlider({double? newValue, String? operator, int? index}) {
   // body.bodySlider = this.body.bodyList[index].sliderValue.toDouble();
    if (operator == '+') {
      age++;
     // this.body.bodyList[index].sliderValue++;
    } else if (operator == '-') {
      if (age != 0) {
        age--;
      }
      // if (this.body.bodyList[index].sliderValue != 0) {
      //   this.body.bodyList[index].sliderValue--;
      // }
    } else {
      age = newValue!.roundToDouble();
     // this.body.bodyList[index].sliderValue = newValue!.roundToDouble();
    }
   // _prefs.storeList('bodyList', this.body.bodyList);

    //getBodySliderValues();
    notifyListeners();
  }
}