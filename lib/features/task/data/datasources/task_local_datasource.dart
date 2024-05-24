import 'package:scheduler/core/core.dart';
import 'package:scheduler/features/features.dart';

class TaskLocalDatasource implements TaskDatasource {
  final Store _store;
  final JwtDatasource _jwtDatasource;
  TaskLocalDatasource(this._store, this._jwtDatasource);

  @override
  Future<TaskModel> createTask(TaskModel taskModel) async {
    _store.saveMap(_generateKeyTask(taskModel), taskModel.toJson());
    final jsonMap = await _store.getMap(_generateKeyTask(taskModel));
    return TaskModel.fromJson(jsonMap!);
  }

  @override
  Future<void> deleteTask(int id) async {
    _store.remove(
      _generateKeyTaskWithId(idTask: id, idUser: await _getCurrentUserId()),
    );
  }

  @override
  Future<TaskModel> getTaskById(int id) async {
    final json = await _store.getMap(
      _generateKeyTaskWithId(
        idTask: id,
        idUser: await _getCurrentUserId(),
      ),
    );
    if (json != null) {
      return TaskModel.fromJson(json);
    } else {
      throw Exception('Task with $id does not exist!');
    }
  }

  @override
  Future<List<TaskModel>> getTasks() async {
    final Set<String> keySet = await _store.getAllKeys();
    final Set<String> taskKeySet = {};
    final List<TaskModel> taskList = [];
    keySet
        .where((String key) => key.contains('user:$_getCurrentUserId()'))
        .map((key) => taskKeySet.add(key));

    for (final key in keySet) {
      final json = await _store.getMap(key);
      if (json != null) {
        taskList.add(TaskModel.fromJson(json));
      }
    }

    return taskList;
  }

  @override
  Future<TaskModel> toggleConcluded(int id, bool? concludedStatus) async {
    final taskKey =
        _generateKeyTaskWithId(idTask: id, idUser: await _getCurrentUserId());

    final json = await _store.getMap(taskKey);
    if (json != null) {
      final taskModel = TaskModel.fromJson(json);
      final newTaskModel = taskModel.copyWith(fgConcluida: concludedStatus);
      _store.remove(taskKey);
      _store.saveMap(taskKey, newTaskModel.toJson());
      return newTaskModel;
    } else {
      throw Exception('Task with $id does not exist!');
    }
  }

  @override
  Future<TaskModel> updateTask(TaskModel taskModel) async {
    final taskKey = _generateKeyTask(taskModel);
    await _store.remove(taskKey);
    _store.saveMap(taskKey, taskModel.toJson());
    return taskModel;
  }

  Future<String> _getCurrentUserId() async =>
      await _jwtDatasource.getCurrentUserId();

  String _generateKeyTask(TaskModel taskModel) =>
      'taskModel:${taskModel.id} -+- user:${taskModel.idUsusario}';

  String _generateKeyTaskWithId(
          {required int idTask, required String idUser}) =>
      'taskModel:$idTask -+- user: $idUser';
}
