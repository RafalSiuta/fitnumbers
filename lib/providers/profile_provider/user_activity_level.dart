import 'dart:collection';
import 'package:flutter/material.dart';
import '../../model/actvity_model/activity_model.dart';

class UserActivityLevel {

  List<ActivityModel> _activityLevelList = [
    ActivityModel(
      icon: Icons.self_improvement,
      description: "Very low activity",// , daily routine, light office work, cleaning house
    ),
    ActivityModel(
      icon: Icons.nordic_walking,
      description: "Low activity",//, light laborer work, random jogging",
    ),
    ActivityModel(
      icon: Icons.rowing,
      description:  "Medium activity",//, harder laborer work random sports, swimming, regular jogging,",
    ),
    ActivityModel(
      icon: Icons.sports_handball,
      description: "High activity",//, regular sport, gym, play football, fitness",
    ),
    ActivityModel(
      icon: Icons.sports_martial_arts,
      description: "Very high activity",//, heavy weight lifting, martial arts, bodybuilding",
    ),
  ];

  UnmodifiableListView<ActivityModel> get activityLevel {
    return UnmodifiableListView(_activityLevelList);
  }

  int get activityLevelListCounter => _activityLevelList.length;

  set activityLevel(List<ActivityModel> value) {
    _activityLevelList = value;
  }
}