import 'package:scheduler/core/database/table_strategy.dart';
import 'package:sqflite/sqflite.dart';

class TaskTable implements TableStrategy {
  @override
  void createTable(Database db, Batch batch, int version) {
    batch.execute('''
        CREATE TABLE IF NOT EXISTS tasks (
            id INTEGER PRIMARY KEY,
            titulo TEXT NOT NULL,
            idUsuario TEXT NOT NULL,
            descricao TEXT NOT NULL,
            fgConcluida INTEGER,
            fgLixeira INTEGER,
            dataCriacao TEXT,
            dataEnvioLixeira TEXT,
            dataExpiracao TEXT,
            dataDataConclusao TEXT,
        );
    ''');
  }
}
