import 'package:fitnumbers2/screens/settings_screen/settings_subscreens/settings_page.dart';
import 'package:flutter/material.dart';

import '../../widgets/navigators/tab_nav.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Expanded(
          child: TabNav(
            tabTitles: ["Settings", "About"],
              list:[
                SettingsPage(),
                Center(child: Text("about"),)
              ]
          ),
        )
      ],
    );
  }
}
