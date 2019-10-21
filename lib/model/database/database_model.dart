abstract class DatabaseTable {
  final String name;
  final List<String> columns;
  final String createQueryColumns;

  DatabaseTable(this.name, this.columns, this.createQueryColumns);

  DatabaseModel entryFromMap(Map map);
}

abstract class DatabaseModel {
  Map<String, dynamic> toMap();
  String removeQuery();
  List<String> removeArgs();
}
