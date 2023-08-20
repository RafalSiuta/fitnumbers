import 'package:fitnumbers2/providers/profile_provider/user_activity.dart';
import 'package:fitnumbers2/providers/profile_provider/user_activity_level.dart';
import 'package:fitnumbers2/providers/profile_provider/user_nutrition.dart';
import 'package:flutter/material.dart';
import 'package:fitnumbers2/providers/profile_provider/user_body_data.dart';
import '../../model/user_data_model/user_data_model.dart';
import '../../utils/prefs/prefs.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fitnumbers2/utils/constans/prefs_keys.dart';


class ProfileProvider extends ChangeNotifier {

  ProfileProvider(){
  initProfileProviderData();
  }

  initProfileProviderData() async {
    userDataList = usrData.userBodyData;
    userPowerActivityList = activityPowerData.activityPowerData;
    userActivityLevelList = userActivityLevel.activityLevel;
    userNutritionDataList = userNutritionData.customNutritionList;
    userNutritionDefaultList = userNutritionData.defaultNutritionList;
    getUserDataValues();
    getUserActivityValues();
    getUserNutritionValues();
  }

  final Prefs _prefs = Prefs();

  UserDataModel userData = UserDataModel();

  //gender setup
  bool isGenderSelected = true;

  void onGenderSelect(bool sel){
    isGenderSelected = sel;
    _prefs.storeBool(userGenderKey, isGenderSelected);
    notifyListeners();
  }

  //user data sliders setup:
  UserBodyData usrData = UserBodyData();
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
    _prefs.storeList(userBodyDataKey, userDataList);

    getUserDataValues();
    notifyListeners();
  }

  getUserDataValues() async {

    isGenderSelected = await _prefs.restoreBool(userGenderKey, isGenderSelected);
    userDataList =
        await _prefs.restoreList(userBodyDataKey, userDataList) ?? userDataList;

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

    _prefs.storeInt(userActivityLevelKey, activityLevel);
    notifyListeners();
  }

  goToNext() {
    carouselController.nextPage(
        duration: const Duration(milliseconds: 400), curve: Curves.decelerate);
    //carousel.carouselActivity = calcResult.activity;
    _prefs.storeInt(userActivityLevelKey, activityLevel);
    notifyListeners();
  }
  //
  onActivityChange(int index) {
    activityLevel = index;
    // calcResult.activity = index;
    // carousel.carouselActivity = index;
    // carousel.carouselActivity = calcResult.activity;
   // print("User activity level value: ${activityLevel}");
    _prefs.storeInt(userActivityLevelKey, activityLevel);
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
    _prefs.storeList(userActivityListKey, userPowerActivityList);
    //getActivitySliderValues();
    notifyListeners();
  }

  // getActivityPowerData() async {
  //   activityLevel =
  //   await _prefs.restoreInt(userActivityLevelKey, activityLevel);
  //   userPowerActivityList =
  //       await _prefs.restoreList(userActivityListKey, userPowerActivityList) ??
  //           userPowerActivityList;
  //
  //   // this.calcResult.bench = activity.activityList[0].sliderValue;
  //   // this.calcResult.squat = activity.activityList[1].sliderValue;
  //   // this.calcResult.deadLift = activity.activityList[2].sliderValue;
  //   // updateCalculationList();
  //   notifyListeners();
  // }

  getUserActivityValues() async {
    activityLevel =
        await _prefs.restoreInt(userActivityLevelKey, activityLevel);
    userPowerActivityList =
        await _prefs.restoreList(userActivityListKey, userPowerActivityList) ??
        userPowerActivityList;
    notifyListeners();
  }

  //user nutrition data:
  UserNutrition userNutritionData = UserNutrition();
  List userNutritionDataList = [];
  List userNutritionDefaultList = [];

  bool isCustomNutrition = false;
  int defaultNutritionChoice = 0;

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
    _prefs.storeList(userNutritionListKey , userNutritionDataList);
    getUserNutritionValues();
    notifyListeners();
  }

  onNutritionModelSwitch(bool newValue) {
    isCustomNutrition = newValue;
    _prefs.storeBool(nutritionChoiceSwitchKey, isCustomNutrition);
    notifyListeners();
  }

  onDefaultNutritionChoice(int? newVal) {
    defaultNutritionChoice = newVal!;
    _prefs.storeInt(defaultNutritionChoiceKey, defaultNutritionChoice);

    getUserNutritionValues();
    // updateCalculationList();
    notifyListeners();
  }

  getUserNutritionValues() async {
    isCustomNutrition = await _prefs.restoreBool(
        nutritionChoiceSwitchKey, isCustomNutrition);


    if(isCustomNutrition == false){
      defaultNutritionChoice = await _prefs.restoreInt(defaultNutritionChoiceKey, defaultNutritionChoice);

      userData.proteinPercent = userNutritionDefaultList[defaultNutritionChoice].protein;
      userData.carbPercent = userNutritionDefaultList[defaultNutritionChoice].carbohydrate;
      userData.fatPercent = userNutritionDefaultList[defaultNutritionChoice].fat;

      print("User data from default nutrition ${userData.toJson()}");
    }else{
      userNutritionDataList =  await _prefs.restoreList(
          userNutritionListKey, userNutritionDataList);
      //TODO: figure out values from int to double error:
      userData.proteinPercent = userNutritionDataList[0].sliderValue.toDouble();
      userData.carbPercent = userNutritionDataList[1].sliderValue.toDouble();
      userData.fatPercent = userNutritionDataList[2].sliderValue.toDouble();

      print("User data from CUSTOM nutrition ${userData.toJson()}");
    }

  notifyListeners();
  }

  // UPDATE USER ALL USER DATA:
  onUpdateUserData(){

  }
}