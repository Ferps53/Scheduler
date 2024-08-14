import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:scheduler/core/database/table_strategy.dart';
import 'package:sqflite/sqflite.dart';

final Provider<AppDatabase> databaseProvider = Provider<AppDatabase>(
  (ref) => AppDatabase(),
);

class AppDatabase {
  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final dataBasePath = await getDatabasesPath();
    final path = join(dataBasePath, 'scheduler.db');
    final database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        final batch = db.batch();

        for (final table in tables.values) {
          table.createTable(db, batch, version);
        }

        batch.commit();
      },
    );
    return database;
  }
}
