// import 'package:fitnumbers2/utils/constans/prefs_keys.dart';
// import 'package:flutter/material.dart';
// import 'package:fitnumbers2/themes/theme_light.dart';
// import 'package:fitnumbers2/themes/theme_dark.dart';
// import '../../utils/prefs/prefs.dart';
//
// class ThemeOption {
//
//
//    // late ThemeData _themeData;
//   final Prefs _prefs = Prefs();
//
//   //theme settings
//   final ThemeOption theme = ThemeOption();
//
//   void onThemeChange(bool sel){
//     theme.currentTheme = sel;
//     _prefs.storeBool(themeMode, theme.currentTheme);
//     theme.getTheme();
//     print("switch theme is ${theme.currentTheme}");
//   }
//
//   void loadTheme() async {
//     theme.currentTheme = await _prefs.restoreBool(themeMode, theme.currentTheme).then((value){
//       return theme.currentTheme;
//     });
//     print("theme is loaded");
//     print("current theme is ${theme.currentTheme}");
//
//     theme.getTheme();
//   }
//
//   late ThemeMode _themeMode;
//
//    late bool currentTheme;
//
//    getTheme() {
//      if(currentTheme){
//        _themeMode = ThemeMode.light;
//        //_themeData = themeLight;
//      }else{
//        // _themeData = themeDark;
//        _themeMode = ThemeMode.dark;
//      }
//      return _themeMode;
//    }
//
//
//
// }