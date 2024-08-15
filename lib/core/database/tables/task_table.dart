import 'package:scheduler/core/database/table_strategy.dart';
import 'package:sqflite/sqflite.dart';

class TaskTable implements TableStrategy {
  @override
  void createTable(Database db, Batch batch, int version) {
    batch.execute('''
        CREATE TABLE IF NOT EXISTS task (
            id INTEGER PRIMARY KEY,
            title TEXT NOT NULL,
            userId INTEGER NOT NULL,
            description TEXT NOT NULL,
            isConcluded INTEGER,
            isInTrashBin INTEGER,
            createdAt TEXT,
            sentToTrashBinAt TEXT,
            expiresIn TEXT,
            concludedAt TEXT
        );
    ''');
  }
}
