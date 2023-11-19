import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


const theme_4MainBcgColor = Color(0xFFEEEEEE);//F4F0CE Color(0xFFEEEEEE);//F4F0CE
const theme_4TitleBoxBcgColor = Colors.white;
// const theme_4firstGradientColor = Color(0xFF00C3FF);
// const theme_4middleGradientColor = Color(0xFF1B6BFF);
// const theme_4lastGradientColor = Color(0xFF2525FF);
const theme_4firstGradientColor = Color(0xFFC8DBC1);
const theme_4middleGradientColor = Color(0xFFB1CEB7);
const theme_4lastGradientColor = Color(0xFF74B6AA);
const theme_4noteCardColor = Color(0xFFf5f5f5); //Color(0xFFdec9ab);f5f5f5
const theme_4descriptionColor = Color(0xFF636363);
const theme_4dividerColor = Color(0xFF636363);
const theme_4unselectedColor = Color(0xFF9e9e9e); //595959
//const theme_4calendarWeekendColor = Color(0xFFab977b);
const theme_4indicatorColor = Color(0xFF6F57E5);//Color(0xFFffca28); Color(0xFFF3EBA0); Color(0xFF94FFAF)// FEA735 f5f5f5 //94FFAF
const theme_4shadowColor = Color(0xFFC0C0C0);
const baseTextColor = Color(0xFF091C2B);
const menuSelectionBackground = Color(0xFF6F57E5);


final themeLight = ThemeData(

    brightness: Brightness.light,
    useMaterial3: true,
    splashFactory: NoSplash.splashFactory,
    scaffoldBackgroundColor: theme_4MainBcgColor,
    // backgroundColor: theme_2TitleBoxBcgColor,

    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: theme_4firstGradientColor,
      onPrimary: theme_4firstGradientColor,
      secondary: Colors.white,
      onSecondary: menuSelectionBackground,
      error: Color(0xFFF32424),
      onError: Color(0xFFF32424),
      background: theme_4TitleBoxBcgColor,
      onBackground: theme_4TitleBoxBcgColor,
      surface: theme_4MainBcgColor,
      onSurface: theme_4MainBcgColor,
    ),
    canvasColor: theme_4TitleBoxBcgColor,
    focusColor: theme_4middleGradientColor,

    unselectedWidgetColor: theme_4unselectedColor,
    primaryColor: theme_4firstGradientColor,
    primaryColorLight: theme_4middleGradientColor,
    primaryColorDark: theme_4lastGradientColor,
    cardColor: theme_4middleGradientColor,
    indicatorColor: theme_4indicatorColor,
    highlightColor: Colors.transparent,
    shadowColor: theme_4MainBcgColor,
    dialogBackgroundColor: theme_4lastGradientColor,
    primarySwatch: Colors.amber,
    splashColor: Colors.transparent,
    textTheme: TextTheme(
      /// main big title //headline 1
      headlineLarge: GoogleFonts.exo2(
          textStyle: const TextStyle(
            color: baseTextColor ,
            fontSize: 32,
          )),
      /// list title //headline 3 // calendar header/ header secondary date
      headlineMedium: GoogleFonts.exo2(
        textStyle: const TextStyle(
            fontSize: 18,
            color: baseTextColor ,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.none,
            overflow: TextOverflow.ellipsis),
      ),
      //headlineSmall: null,
      /// date header style
      displayLarge: GoogleFonts.exo2(
          textStyle: const TextStyle(
              fontSize: 18,
              color: theme_4lastGradientColor,
              fontWeight: FontWeight.w700,
              letterSpacing: 2)),
      //small selected text
      displayMedium: GoogleFonts.exo2(
          textStyle: const TextStyle(
              fontSize: 10,
              color: theme_4indicatorColor,
              fontWeight: FontWeight.w500,
              letterSpacing: 1)),
      //small unselected text
      displaySmall: GoogleFonts.exo2(
          textStyle: const TextStyle(
              fontSize: 10,
              color: theme_4unselectedColor,
              fontWeight: FontWeight.w500,)),
      ///calendar weekend text style
      bodyLarge: GoogleFonts.exo2(
          textStyle: const TextStyle(
            fontSize: 18,
            color: theme_4indicatorColor,
          )),
      //task/note/project description text style:
      bodyMedium:  GoogleFonts.exo2(
          textStyle: const TextStyle(
              fontSize: 10,
              color: theme_4lastGradientColor,
              fontWeight: FontWeight.w300,
              overflow: TextOverflow.ellipsis)),
      ///calendar marker style
      bodySmall: GoogleFonts.exo2(
          textStyle: const TextStyle(
              fontSize: 10,
              color: theme_4noteCardColor,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis)),
    ),
    iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          
          alignment: Alignment.center,
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered))
                  return theme_4unselectedColor;
                if (states.contains(MaterialState.focused) ||
                    states.contains(MaterialState.pressed))
                  return theme_4TitleBoxBcgColor.withOpacity(0.1);
                return theme_4unselectedColor; // Defer to the widget's default.
              },
            ),
            iconColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered))
                return theme_4unselectedColor;
              if (states.contains(MaterialState.focused) ||
                  states.contains(MaterialState.pressed))
                return theme_4indicatorColor;
              return theme_4unselectedColor; // Defer to the widget's default.
            },
          ),
        )
    ),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(theme_4MainBcgColor.withOpacity(0.1))
        )
    ),

    textSelectionTheme: const TextSelectionThemeData(
      selectionHandleColor: Colors.transparent,
    ),
    dividerTheme: const DividerThemeData(
      color: theme_4dividerColor,
      thickness: 0.5,

    ),
    cardTheme: CardTheme(
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          //side: BorderSide(color: Theme.of(context).disabledColor, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      color: theme_4TitleBoxBcgColor,//theme_4TitleBoxBcgColor
    ),
    sliderTheme: SliderThemeData(
      trackShape: RectangularSliderTrackShape(),
      trackHeight: 2,
      activeTrackColor:theme_4indicatorColor,
      inactiveTrackColor: theme_4unselectedColor,
      thumbColor: theme_4TitleBoxBcgColor,
      overlayColor: theme_4TitleBoxBcgColor.withOpacity(0.3),
      thumbShape:
      const RoundSliderThumbShape(enabledThumbRadius: 10),
      overlayShape: RoundSliderOverlayShape(
          overlayRadius: 20),
    ),
    navigationRailTheme: NavigationRailThemeData(
      labelType: NavigationRailLabelType.all,
      //useIndicator: true,

      indicatorColor: Colors.transparent,
      groupAlignment: .0,
      selectedIconTheme: const IconThemeData(
        color: theme_4indicatorColor,

      ),
      unselectedIconTheme: const IconThemeData(color: theme_4unselectedColor,),
      selectedLabelTextStyle: GoogleFonts.exo2(
        textStyle: const TextStyle(
            color: baseTextColor , fontSize: 12.0, fontWeight: FontWeight.w900),
      ),
      unselectedLabelTextStyle: GoogleFonts.exo2(
          textStyle: const TextStyle(
              color: theme_4unselectedColor,
              fontSize: 10.0,
              fontWeight: FontWeight.w500
          )),
    ),
   // actionIconTheme: const ActionIconThemeData(),//const IconThemeData(color: theme_4noteCardColor, size: 18),
    iconTheme: const IconThemeData(color: theme_4indicatorColor, size: 18),
    switchTheme: SwitchThemeData(

        thumbColor: MaterialStateProperty.resolveWith(
              (states) {
            if (states.contains(MaterialState.selected)) {
              return Colors.white;
            } else {
              return Colors.white;
            }
          },
        ),
        trackColor: MaterialStateProperty.resolveWith(
              (states) {
            if (states.contains(MaterialState.selected)) {
              return theme_4indicatorColor;
            } else if (states.contains(MaterialState.disabled)){
              return theme_4unselectedColor;
            } else{
              return theme_4unselectedColor;
            }
          },
        ),),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith(
            (states) {
          if (states.contains(MaterialState.selected)) {
            return theme_4indicatorColor;
          } else if (states.contains(MaterialState.disabled)){
            return theme_4unselectedColor;
          } else{
            return theme_4unselectedColor;
          }
        },
      )
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: theme_4TitleBoxBcgColor,

      selectedIconTheme: const IconThemeData(
        size: 18.0,
        color: theme_4indicatorColor
      ),
      unselectedIconTheme: const IconThemeData(
            size: 18.0,
            color: theme_4unselectedColor
      ),
      selectedLabelStyle:  GoogleFonts.exo2(
          textStyle: const TextStyle(
              color: theme_4indicatorColor,
              fontSize: 10.0,
              fontWeight: FontWeight.w500
          )),
      unselectedLabelStyle:GoogleFonts.exo2(
          textStyle: const TextStyle(
              color: theme_4unselectedColor,
              fontSize: 10.0,
              fontWeight: FontWeight.w500
          )),
      selectedItemColor: theme_4indicatorColor,
      unselectedItemColor: theme_4unselectedColor
    ),
    floatingActionButtonTheme:
    const FloatingActionButtonThemeData(
        backgroundColor: theme_4indicatorColor
    ),
    dialogTheme: DialogTheme(
        elevation: 5.0,
        titleTextStyle: GoogleFonts.exo2(
          textStyle: const TextStyle(
              color: theme_4noteCardColor,
              fontSize: 18,
              fontWeight: FontWeight.w400),
        ),
        contentTextStyle: GoogleFonts.exo2(
          textStyle: const TextStyle(
              color: theme_4noteCardColor,
              fontSize: 12,
              fontWeight: FontWeight.w400),
        ),
        backgroundColor: theme_4MainBcgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
    inputDecorationTheme: InputDecorationTheme(
      border: InputBorder.none,
      focusedBorder:const UnderlineInputBorder(
          borderSide: BorderSide(
            width: .5,
            color: theme_4dividerColor,
          )),
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      focusedErrorBorder: InputBorder.none,
      isDense: true,
      filled: false,
      hintStyle:const TextStyle(color: baseTextColor , fontSize: 20),
      contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
      suffixStyle: const TextStyle(
        color: theme_4unselectedColor,
      ),
      labelStyle: const TextStyle(
        color: theme_4noteCardColor,
      ),
      helperMaxLines: 1,
      helperStyle: GoogleFonts.exo2(
        textStyle: const TextStyle(
          color: theme_4unselectedColor,
          fontSize: 7.0,
          fontWeight: FontWeight.w300,
        ),
      ),
      alignLabelWithHint: true,
      prefixStyle: const TextStyle(
        color: theme_4noteCardColor,
      ),
    ),
    progressIndicatorTheme:const ProgressIndicatorThemeData(
      refreshBackgroundColor: theme_4unselectedColor,
      // linearTrackColor: theme_4indicatorColor


    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.transparent, // theme_4TitleBoxBcgColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
            left: (Radius.circular(15)), right: (Radius.circular(15))),
      ),
    ),

    tabBarTheme: TabBarTheme(
      dividerColor: theme_4dividerColor.withOpacity(0.5),

      overlayColor: MaterialStateProperty.all(Colors.transparent),
      indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(width: 2.0, color: theme_4indicatorColor),
          insets: EdgeInsets.symmetric(horizontal: 12.0),),
      labelColor: baseTextColor ,
      unselectedLabelColor: theme_4unselectedColor,
      unselectedLabelStyle: GoogleFonts.exo2(
        textStyle: const TextStyle(
            fontSize: 15,
            color: theme_4unselectedColor,
            fontWeight: FontWeight.w300,
            decoration: TextDecoration.none),
      ),
      labelStyle: GoogleFonts.exo2(
        textStyle: const TextStyle(
            fontSize: 15,
            color: baseTextColor ,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.none,
            overflow: TextOverflow.ellipsis),
      ),
    ),
);


