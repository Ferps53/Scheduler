import 'package:scheduler/core/core.dart';
import '../data.dart';

class TaskLocalDatasource implements TaskDatasource {
  final AppDatabase _appDb;

  TaskLocalDatasource(this._appDb);

  static const tableName = 'tasks';

  @override
  Future<TaskModel> createTask(TaskModel taskModel) async {
    final db = await _appDb.database;

    int id = await db.insert(tableName, taskModel.toDatabaseMap());
    final dbMap = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return dbMap.map((map) => TaskModel.fromDatabase(map)).first;
  }

  @override
  Future<void> deleteTask(int id) async {
    final db = await _appDb.database;

    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<TaskModel> getTaskById(int id) async {
    final db = await _appDb.database;

    final map = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return map.map((databaseMap) => TaskModel.fromDatabase(databaseMap)).first;
  }

  @override
  Future<List<TaskModel>> getTasks() async {
    final db = await _appDb.database;

    final map = await db.query(tableName);

    return map
        .map((databaseMap) => TaskModel.fromDatabase(databaseMap))
        .toList();
  }

  @override
  Future<TaskModel> toggleConcluded(int id, bool? concludedStatus) async {
    final db = await _appDb.database;

    await db.rawQuery(
      'UPDATE $tableName SET fgConcluida = ? where id = ?',
      [concludedStatus ??= false, id],
    );

    final map = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    return map.map((databaseMap) => TaskModel.fromDatabase(databaseMap)).first;
  }

  @override
  Future<TaskModel> updateTask(TaskModel taskModel) async {
    final db = await _appDb.database;
    await db.update(
      tableName,
      taskModel.toDatabaseMap(),
      where: 'id = ?',
      whereArgs: [taskModel.id],
    );

    final map = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [taskModel.id],
    );
    return map.map((databaseMap) => TaskModel.fromDatabase(databaseMap)).first;
  }
}
