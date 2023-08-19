import 'package:fitnumbers2/providers/profile_provider/user_activity.dart';
import 'package:fitnumbers2/providers/profile_provider/user_activity_level.dart';
import 'package:fitnumbers2/providers/profile_provider/user_nutrition.dart';
import 'package:flutter/material.dart';
import 'package:fitnumbers2/providers/profile_provider/user_data.dart';
import '../../utils/prefs/prefs.dart';
import 'package:carousel_slider/carousel_slider.dart';


class ProfileProvider extends ChangeNotifier {

  ProfileProvider(){
  initProfileProviderData();
  }

  initProfileProviderData() async {
    userDataList = usrData.userData;
    userPowerActivityList = activityPowerData.activityPowerData;
    userActivityLevelList = userActivityLevel.activityLevel;
    userNutritionDataList = userNutritionData.nutritionList;
    userNutritionDefaultList = userNutritionData.defaultNutritionList;
    getUserDataValues();
  }

  final Prefs _prefs = Prefs();

  //gender setup
  bool isGenderSelected = true;

  void onGenderSelect(bool sel){
    isGenderSelected = sel;
    _prefs.storeBool('Gender', isGenderSelected);
    notifyListeners();
  }

  //user data sliders setup:
  UserData usrData = UserData();
  List userDataList = [];

  void setUserData( int index,{double? newValue,String? operator}) {

    if (operator == '+') {

      userDataList[index].sliderValue++;
    } else if (operator == '-') {

      if (userDataList[index].sliderValue != 0) {
        userDataList[index].sliderValue--;
      }
    } else {

      userDataList[index].sliderValue = newValue!.roundToDouble();
    }
    _prefs.storeList('bodyList', userDataList);

    getUserDataValues();
    notifyListeners();
  }

  getUserDataValues() async {

    isGenderSelected = await _prefs.restoreBool('Gender', isGenderSelected);
    userDataList =
        await _prefs.restoreList('bodyList', userDataList) ?? userDataList;

    notifyListeners();
  }

   //user activity setup:
  UserActivityLevel userActivityLevel = UserActivityLevel();
  List userActivityLevelList = [];

    UserActivityPowerData activityPowerData = UserActivityPowerData();
    List userPowerActivityList = [];

    int activityLevel = 0;
    CarouselController carouselController = CarouselController();


  goToPrevious() {
    carouselController.previousPage(
        duration:const  Duration(milliseconds: 400), curve: Curves.ease);
    //carousel.carouselActivity = calcResult.activity;

    _prefs.storeInt('Activity', activityLevel);
    notifyListeners();
  }

  goToNext() {
    carouselController.nextPage(
        duration: const Duration(milliseconds: 400), curve: Curves.decelerate);
    //carousel.carouselActivity = calcResult.activity;
    _prefs.storeInt('Activity', activityLevel);
    notifyListeners();
  }
  //
  onActivityChange(int index) {
    activityLevel = index;
    // calcResult.activity = index;
    // carousel.carouselActivity = index;
    // carousel.carouselActivity = calcResult.activity;
    print("User activity level value: ${activityLevel}");
    _prefs.storeInt('Activity', activityLevel);
    notifyListeners();
  }

  setPowerActivityData(int index, {double? newValue, String? operator, }) {
    var data = userPowerActivityList[index];
    if (operator == '+') {
      data.sliderValue++;
    } else if (operator == '-') {
      if (data.sliderValue != 0) {
        data.sliderValue--;
      }
    } else {
      data.sliderValue = newValue!.roundToDouble();
    }
    _prefs.storeList('activityList', userPowerActivityList);
    //getActivitySliderValues();
    notifyListeners();
  }

  //user nutrition data:
  UserNutrition userNutritionData = UserNutrition();
  List userNutritionDataList = [];
  List userNutritionDefaultList = [];

  bool isDefaultNutrition = true;

  setNutritionData(int index, {double? newValue, String? operator, }) {
    var data = userNutritionDataList[index];
    if (operator == '+') {
      data.sliderValue++;
    } else if (operator == '-') {
      if (data.sliderValue != 0) {
        data.sliderValue--;
      }
    } else {
      data.sliderValue = newValue!.roundToDouble();
    }
    _prefs.storeList('nutritionList', userPowerActivityList);
    //getActivitySliderValues();
    notifyListeners();
  }

  onNutritionModelSwitch(bool newValue) {
    isDefaultNutrition = newValue;
    _prefs.storeBool('nutritionOptionSwitch', isDefaultNutrition);
    notifyListeners();
  }
}