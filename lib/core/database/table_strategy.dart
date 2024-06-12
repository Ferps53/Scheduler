import 'package:scheduler/core/database/tables/task_table.dart';
import 'package:sqflite/sqflite.dart';

final Set<TableStrategy> tables = {
  TaskTable(),
};

abstract interface class TableStrategy {
  void createTable(Database db, Batch batch, int version);
}
