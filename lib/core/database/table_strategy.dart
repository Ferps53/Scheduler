import 'package:scheduler/core/database/tables/task_table.dart';
import 'package:sqflite/sqflite.dart';

final Map<String, TableStrategy> tables = {
  'task': TaskTable(),
};

abstract interface class TableStrategy {
  void createTable(Database db, Batch batch, int version);
}
