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
    getUserData();
  }

  final Prefs _prefs = Prefs();



  //gender setup
  bool isGenderSelected = true;

  void onGenderSelect(bool sel){
    isGenderSelected = sel;
    _prefs.storeBool(userGenderKey, isGenderSelected);

    notifyListeners();
  }

  //UserDataModel userData = UserDataModel();
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
    getUserData();
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
    getUserData();
    notifyListeners();
  }

  goToNext() {
    carouselController.nextPage(
        duration: const Duration(milliseconds: 400), curve: Curves.decelerate);
    //carousel.carouselActivity = calcResult.activity;
    _prefs.storeInt(userActivityLevelKey, activityLevel);
    getUserData();
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
    getUserData();
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
    getUserActivityValues();
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
    getUserData();
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
    getUserNutritionValues();
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

    }else{
      userNutritionDataList =  await _prefs.restoreList(
          userNutritionListKey, userNutritionDataList);

    }
    getUserData();
  notifyListeners();
  }
  UserDataModel userData = UserDataModel();
  UserDataModel getUserData() {

    List? data = [...userDataList, ...userPowerActivityList];

    userData.gender = isGenderSelected;
    userData.activity = activityLevel;

    print('ITEMS NUMBER ${data.length}');
    for(int i = 0; i < data.length; i++){
     // print('This is new list from all sliders - ${data[i].name}');
      switch(data[i].name){
        case 'age':
          userData.age = data[i].sliderValue.toDouble();
          break;
        case 'weight':
          userData.weight = data[i].sliderValue.toDouble();
          break;
        case 'height':
          userData.height = data[i].sliderValue.toDouble();
          break;
        case 'waist':
          userData.waist = data[i].sliderValue.toDouble();
          break;
        case 'hips':
          userData.hips = data[i].sliderValue.toDouble();
          break;
        case 'neck':
          userData.neck = data[i].sliderValue.toDouble();
          break;
        case 'bench press':
          userData.benchPressPower = data[i].sliderValue.toDouble();
          break;
        case 'squat':
          userData.squatPower = data[i].sliderValue.toDouble();
          break;
        case 'dead lift':
          userData.deadLiftPower = data[i].sliderValue.toDouble();
          break;
      }
    }

    if(isCustomNutrition == false){

      for(int i = 0; i < userNutritionDataList.length ; i++){
        //print('This is new list nutri data custom nutri ${isCustomNutrition} - ${userNutritionDataList[i].name}');
        switch(userNutritionDataList[i].name){
          case 'protein':
            userData.proteinPercent = userNutritionDataList[i].sliderValue.toDouble();
            break;
          case 'carbo':
            userData.carbPercent = userNutritionDataList[i].sliderValue.toDouble();
            break;
          case 'fat':
            userData.fatPercent = userNutritionDataList[i].sliderValue.toDouble();
            break;
        }
      }
    }else{

      for(int i = 0; i < userNutritionDefaultList.length ; i++){
       // print('This is new list nutri data custom nutri ${isCustomNutrition} - ${userNutritionDefaultList[i].name}');
        switch(userNutritionDefaultList[i].name){
          case 'weight loss':
            userData.proteinPercent = userNutritionDefaultList[i].protein.toDouble();
            userData.carbPercent = userNutritionDefaultList[i].carbohydrate.toDouble();
            userData.fatPercent = userNutritionDefaultList[i].fat.toDouble();
            break;
          case 'maintain':
            userData.proteinPercent = userNutritionDefaultList[i].protein.toDouble();
            userData.carbPercent = userNutritionDefaultList[i].carbohydrate.toDouble();
            userData.fatPercent = userNutritionDefaultList[i].fat.toDouble();
            break;
          case 'gain weight':
            userData.proteinPercent = userNutritionDefaultList[i].protein.toDouble();
            userData.carbPercent = userNutritionDefaultList[i].carbohydrate.toDouble();
            userData.fatPercent = userNutritionDefaultList[i].fat.toDouble();
            break;
        }
      }
    }

    notifyListeners();
    return userData;
  }

}