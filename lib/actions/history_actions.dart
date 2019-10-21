import 'package:watermaniac/managers/database/drink_history.dart';

class AddDrinkToHistoryAction {
  DrinkHistoryEntry entry;

  AddDrinkToHistoryAction(this.entry);
}

class RemoveDrinkFromHistoryAction {
  DrinkHistoryEntry entry;

  RemoveDrinkFromHistoryAction(this.entry);
}

class LoadDrinkHistoryAction {}

class DrinkHistoryLoadedAction {
  final List<DrinkHistoryEntry> entries;

  DrinkHistoryLoadedAction(this.entries);
}