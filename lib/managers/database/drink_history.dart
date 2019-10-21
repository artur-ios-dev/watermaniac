import 'package:watermaniac/model/database/database_model.dart';

class DrinkHistoryTable extends DatabaseTable {
  DrinkHistoryTable()
      : super('DrinkHistory', ['_id', 'amount', 'date'],
            '_id INTEGER PRIMARY KEY AUTOINCREMENT, amount INTEGER, date INTEGER');

  @override
  DrinkHistoryEntry entryFromMap(Map map) {
    var entry = DrinkHistoryEntry();
    entry.id = map['_id'];
    entry.amount = map['amount'];
    entry.date = map['date'];

    return entry;
  }
}

class DrinkHistoryEntry extends DatabaseModel {
  int id;
  int amount;
  int date;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {'amount': amount, 'date': date};
    if (id != null) {
      map['_id'] = id;
    }
    return map;
  }

  @override
  String removeQuery() {
    return id != null ? '_id = ?' : 'date = ?';
  }

  @override
  List<String> removeArgs() {
    return id != null ? [id.toString()] : [date.toString()];
  }
}
