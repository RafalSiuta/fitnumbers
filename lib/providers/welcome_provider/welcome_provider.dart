import 'package:flutter/material.dart';

import '../../model/header_model/header_model.dart';

class WelcomeProvider extends ChangeNotifier{

  HeaderModel currentDate = HeaderModel();

  String? date;
  String? weekday;

  WelcomeProvider(){
    date = currentDate.fullDate.format(currentDate.date);
    weekday = currentDate.weekDay.format(currentDate.date);
  }

  void init(){

  }
}