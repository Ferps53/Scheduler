import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:scheduler/core/core.dart';
import '../data.dart';

class TaskLocalDatasource implements TaskDatasource {
  final AppDatabase _appDb;
  final Store _store;

  TaskLocalDatasource(this._appDb, this._store);

  static const tableName = 'tasks';

  @override
  Future<TaskModel> createTask(TaskModel taskModel) async {
    final db = await _appDb.database;
    taskModel = taskModel.copyWith(idUsusario: await _getCurrentUser());

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

  Future<String> _getCurrentUser() async {
    final jwtString = await _store.getSavedString('token');
    final jwt = JwtDecoder.decode(jwtString);

    return jwt['sub'] as String;
  }
}
