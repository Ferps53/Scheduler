import 'dart:developer';

import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await openDatabase(
      "scheduler.db",
      onCreate: (Database db, int version) async {
        final batch = db.batch();

        batch.execute('''
    create table auth (
      id integer primary key autoincrement,
      username text not null, 
      password text not null,
      salt text not null
    )
    ''');
        log("Added create auth table");

        await batch.commit();
        log("Commited batch");
      },
    );
    return _database!;
  }
}
