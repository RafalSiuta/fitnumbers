import 'package:fitnumbers2/screens/profile_screen/subscreens/user_activity_page.dart';
import 'package:fitnumbers2/screens/profile_screen/subscreens/user_data_page.dart';
import 'package:fitnumbers2/screens/profile_screen/subscreens/user_nutrition_page.dart';
import 'package:flutter/material.dart';
import '../../../widgets/navigators/tab_nav.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Expanded(
          child: TabNav(
            [
              UserDataPage(),
              UserActivityPage(),
              UserNutritionPage()
            ]
          ),
        )
      ],
    );
  }
}
