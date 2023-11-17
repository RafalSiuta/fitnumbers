import 'package:fitnumbers2/providers/logic_provider/logic_provider.dart';
import 'package:fitnumbers2/providers/profile_provider/profile_provider.dart';
import 'package:fitnumbers2/providers/settings_provider/settings_provider.dart';
import 'package:fitnumbers2/providers/welcome_provider/welcome_provider.dart';
import 'package:fitnumbers2/screens/main_screen.dart';
import 'package:fitnumbers2/screens/settings_screen/settings_screen.dart';
import 'package:fitnumbers2/themes/theme_light.dart';
import 'package:fitnumbers2/utils/custom_page_route/custom_page_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'themes/theme_dark.dart';

void main() {
  runApp(const FitNumbers());
}

class FitNumbers extends StatelessWidget {
  const FitNumbers({super.key});

  //todo:  https://dartling.dev/toggle-full-screen-mode-in-flutter
  static Future<void> setEnabledSystemUIMode(SystemUiMode mode, { List<SystemUiOverlay>? overlays }) async {
    if (mode != SystemUiMode.manual) {
      await SystemChannels.platform.invokeMethod<void>(
        'SystemChrome.setEnabledSystemUIMode',
        //mode.toString(),
      );
    } else {
      assert(mode == SystemUiMode.manual && overlays != null);
      await SystemChannels.platform.invokeMethod<void>(
        'SystemChrome.setEnabledSystemUIOverlays',
        //_stringify(overlays!),
      );
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProfileProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SettingsProvider(),
        ),
        ChangeNotifierProxyProvider2(
          create: (context) => LogicProvider(Provider.of<ProfileProvider>(context, listen: false),Provider.of<SettingsProvider>(context, listen: false)),
          update: (context, ProfileProvider profile, SettingsProvider settings, logic) => LogicProvider(profile, settings),
        ),
        ChangeNotifierProvider(
          create: (context) => WelcomeProvider(),
        ),
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, settings, child){
         return MaterialApp(
           title: 'FitNumbers app',
           debugShowCheckedModeBanner: false,
           theme: themeLight,
           darkTheme: themeDark,
           themeMode: settings.getTheme(),
           home: const MainScreen(),
         );
        }
      ),
    );
  }

  static onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return CustomPageRoute(
            child: const MainScreen(),
            settings: settings,
            direction: AxisDirection.left);

      case "/settings":
        return CustomPageRoute(
            child: const SettingsScreen(),
            settings: settings,
            direction: AxisDirection.left);
      default:
        CustomPageRoute(
            child: const MainScreen(),
            settings: settings,
            direction: AxisDirection.left);
    }
  }
}

