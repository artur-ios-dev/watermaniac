import 'package:watermaniac/model/settings/AppSettings.dart';

class LoadAppSettingsAction {}

class AppSettingsLoadedAction {
  final AppSettings settings;

  AppSettingsLoadedAction(this.settings);
}

class SaveSettingsAction {
  final AppSettings settings;

  SaveSettingsAction(this.settings);
}

class SaveNotificationSettingsAction {
  final AppSettings settings;

  SaveNotificationSettingsAction(this.settings);
}
