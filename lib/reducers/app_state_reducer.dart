import 'package:watermaniac/managers/database/drink_history.dart';
import 'package:watermaniac/model/app_state.dart';
import 'package:watermaniac/reducers/glass_reducer.dart';
import 'package:watermaniac/reducers/settings_reducer.dart';
import 'package:watermaniac/reducers/history_reducer.dart';

AppState appReducer(AppState state, action) {
  AppState newState = AppState(
    settings: settingsReducers(state.settings, action),
    glass: glassReducers(state.glass, action),
    drinksHistory: historyReducers(state.drinksHistory, action),
  );

  List<DrinkHistoryEntry> currentEntries = newState.drinksHistory
      .where((entry) =>
          _isToday(DateTime.fromMillisecondsSinceEpoch(entry.date)))
      .toList();

  newState.glass.waterAmountTarget = newState.settings.dailyGoal;
  newState.glass.currentWaterAmount = currentEntries.fold(0, (t, e) => t + e.amount);

  return newState;
}

bool _isToday(DateTime date) {
    var today = DateTime.now();

    if (date.year == today.year &&
        date.month == today.month &&
        date.day == today.day) {
      return true;
    }

    return false;
  }
