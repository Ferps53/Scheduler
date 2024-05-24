import 'package:scheduler/core/core.dart';
import 'package:scheduler/features/task/data/datasources/datasource.dart';
import 'package:scheduler/features/task/data/model/task_model.dart';

class TaskLocalDatasource implements TaskDatasource {
  final Store _store;
  TaskLocalDatasource(this._store);
  @override
  Future<TaskModel> createTask(TaskModel taskModel) {
    // TODO: implement createTask
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTask(int id) {
    // TODO: implement deleteTask
    throw UnimplementedError();
  }

  @override
  Future<TaskModel> getTaskById(int id) {
    // TODO: implement getTaskById
    throw UnimplementedError();
  }

  @override
  Future<List<TaskModel>> getTasks() {
    // TODO: implement getTasks
    throw UnimplementedError();
  }

  @override
  Future<TaskModel> toggleConcluded(int id, bool? concludedStatus) {
    // TODO: implement toggleConcluded
    throw UnimplementedError();
  }

  @override
  Future<TaskModel> updateTask(TaskModel tarefaModel) {
    // TODO: implement updateTask
    throw UnimplementedError();
  }
}
