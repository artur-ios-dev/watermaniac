import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watermaniac/model/settings/AppSettings.dart';
import 'package:watermaniac/screens/settings/Gender.dart';

class AppSettingsManager {
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static Future<AppSettings> getSettings() async {
    final SharedPreferences prefs = await _prefs;
    final genderInt = prefs.getInt(_AppSettingsKeys.gender) ?? -1;
    final gender = genderInt >= 0 ? Gender.values[genderInt] : null;
    final age = prefs.getInt(_AppSettingsKeys.age) ?? 0;
    final dailyGoal = prefs.getInt(_AppSettingsKeys.dailyGoal) ?? 0;

    // Notifications
    final enabled =
        prefs.getBool(_AppSettingsKeys.notificationsEnabled) ?? false;
    final fromH = prefs.getInt(_AppSettingsKeys.notificationsFromH) ?? 7;
    final fromM = prefs.getInt(_AppSettingsKeys.notificationsFromM) ?? 0;
    final toH = prefs.getInt(_AppSettingsKeys.notificationsToH) ?? 20;
    final toM = prefs.getInt(_AppSettingsKeys.notificationsToM) ?? 0;
    final interval = prefs.getInt(_AppSettingsKeys.notificationsInterval) ?? 30;

    final from = TimeOfDay(hour: fromH, minute: fromM);
    final to = TimeOfDay(hour: toH, minute: toM);

    return AppSettings(
        age: age,
        gender: gender,
        dailyGoal: dailyGoal,
        notificationsEnabled: enabled,
        notificationsFromTime: from,
        notificationsToTime: to,
        notificationsInterval: interval);
  }

  static Future<bool> saveSettings(
      Gender gender, int age, int dailyGoal) async {
    final SharedPreferences prefs = await _prefs;

    prefs.setInt(_AppSettingsKeys.gender, gender != null ? gender.index : -1);
    prefs.setInt(_AppSettingsKeys.age, age != null ? age : 0);
    prefs.setInt(_AppSettingsKeys.dailyGoal, dailyGoal != null ? dailyGoal : 0);

    return true;
  }

  static Future<bool> saveNotificationSettings(
      bool enabled, TimeOfDay from, TimeOfDay to, int interval) async {
    final SharedPreferences prefs = await _prefs;

    prefs.setBool(_AppSettingsKeys.notificationsEnabled,
        enabled != null ? enabled : false);
    prefs.setInt(
        _AppSettingsKeys.notificationsFromH, from != null ? from.hour : 7);
    prefs.setInt(
        _AppSettingsKeys.notificationsFromM, from != null ? from.minute : 0);
    prefs.setInt(_AppSettingsKeys.notificationsToH, to != null ? to.hour : 20);
    prefs.setInt(_AppSettingsKeys.notificationsToM, to != null ? to.minute : 0);
    prefs.setInt(_AppSettingsKeys.notificationsInterval,
        interval != null ? interval : 30);

    return true;
  }
}

class _AppSettingsKeys {
  static final gender = "gender";
  static final age = "age";
  static final dailyGoal = "dailyGoal";

  static final notificationsEnabled = "notificationsEnabled";
  static final notificationsFromH = "notificationsFromH";
  static final notificationsFromM = "notificationsFromM";
  static final notificationsToH = "notificationsToH";
  static final notificationsToM = "notificationsToM";
  static final notificationsInterval = "notificationsInterval";
}
