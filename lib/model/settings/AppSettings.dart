import 'package:flutter/material.dart';
import 'package:watermaniac/screens/settings/Gender.dart';

class AppSettings {
  Gender gender;
  int age;
  int dailyGoal;

  bool notificationsEnabled;
  TimeOfDay notificationsFromTime;
  TimeOfDay notificationsToTime;
  int notificationsInterval;

  AppSettings(
      {this.gender,
      this.age,
      this.dailyGoal,
      this.notificationsEnabled,
      this.notificationsFromTime,
      this.notificationsToTime,
      this.notificationsInterval});

  AppSettings copyWith(
      {Gender gender,
      int age,
      int dailyGoal,
      bool notificationsEnabled,
      TimeOfDay notificationsFromTime,
      TimeOfDay notificationsToTime,
      int notificationsInterval}) {
    return AppSettings(
        gender: gender ?? this.gender,
        age: age ?? this.age,
        dailyGoal: dailyGoal ?? this.dailyGoal,
        notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
        notificationsFromTime:
            notificationsFromTime ?? this.notificationsFromTime,
        notificationsToTime: notificationsToTime ?? this.notificationsToTime,
        notificationsInterval:
            notificationsInterval ?? this.notificationsInterval);
  }
}
