import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsManager {
  static final manager = NotificationsManager();
  static final facts = [
    'Adult humans are 60 percent water, and our blood is 90 percent water',
    'There is no universally agreed quantity of water that must be consumed daily',
    'Water is essential for the kidneys and other bodily functions',
    'When dehydrated, the skin can become more vulnerable to skin disorders and wrinkling',
    'Drinking water instead of soda can help with weight loss',
    'It lubricates the joints',
    'It forms saliva and mucus',
    'It delivers oxygen throughout the body',
    'It boosts skin health and beauty',
    'It cushions the brain, spinal cord, and other sensitive tissues',
    'It regulates body temperature',
    'The digestive system depends on it',
    'It flushes body waste',
    'It helps maintain blood pressure',
    'The airways need it',
    'It makes minerals and nutrients accessible',
    'It prevents kidney damage',
    'It boosts performance during exercise',
    'It reduces the chance of a hangover',
  ];

  static FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  void init() {
    var initializationSettingsAndroid = AndroidInitializationSettings(
        'ic_stat_drop');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  FlutterLocalNotificationsPlugin get plugin {
    if (_flutterLocalNotificationsPlugin != null) {
      return _flutterLocalNotificationsPlugin;
    }

    init();

    return _flutterLocalNotificationsPlugin;
  }

  void scheduleNotifications(TimeOfDay from, TimeOfDay to, int interval) {
    cancelAll();

    var hInterval = interval ~/ 60;
    var mInterval = interval - hInterval * 60;

    var hForInterval = hInterval;
    if (hForInterval == 0) {
      hForInterval = 1;
    }

    for (var hour = from.hour; hour <= to.hour; hour += hForInterval) {
      if (mInterval > 0) {
        for (var min = from.minute; min < 60; min += mInterval) {
          if (hour == to.hour && min > to.minute) {
            break;
          }
          var time = Time(hour, min, 0);
          _scheduleAtTime(100 * hour + min, time);
          if (hInterval > 0) {
            break;
          }
        }
      } else {
        var time = Time(hour, from.minute, 0);
        _scheduleAtTime(100 * hour + from.minute, time);
      }
    }
  }

  void cancelAll() async {
    await plugin.cancelAll();
  }

  void _scheduleAtTime(int id, Time time) async {
    // String groupKey = 'com.android.example.WORK_EMAIL';
    // importance: Importance.Max,
    //     priority: Priority.High,
    //     groupKey: groupKey);
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'watermaniac.channelID',
        'watermaniac.channelName',
        'Watermaniac Reminder');
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await plugin.showDailyAtTime(
        id,
        'Drink Water!',
        facts[Random().nextInt(facts.length)],
        time,
        platformChannelSpecifics);
  }
}
