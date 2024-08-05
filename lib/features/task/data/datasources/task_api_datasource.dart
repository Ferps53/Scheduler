import 'package:dio/dio.dart';
import 'package:scheduler/features/task/task.dart';

import '../model/new_task_model.dart';

class TaskApiDatasource implements TaskDatasource {
  final Dio _dio;

  TaskApiDatasource(this._dio);

  static const String basePath = '/task';

  @override
  Future<TaskModel> createTask(NewTaskModel taskModel) async {
    final response = await _dio.post(
      basePath,
      data: taskModel.toJson(),
    );
    return TaskModel.fromJson(response.data);
  }

  @override
  Future<void> deleteTask(int id) async {
    await _dio.delete('$basePath/$id');
  }

  @override
  Future<TaskModel> getTaskById(int id) async {
    final response = await _dio.get('$basePath/$id');

    return TaskModel.fromJson(response.data!);
  }

  @override
  Future<List<TaskModel>> getTasks() async {
    final response = await _dio.get(basePath);

    List<TaskModel> listTasks = [];
    if (response.data != null) {
      for (final tarefa in response.data!) {
        listTasks.add(TaskModel.fromJson(tarefa));
      }
    }
    return listTasks;
  }

  @override
  Future<TaskModel> toggleConcluded(int id) async {
    final response = await _dio.put(
      '$basePath/mark-as-concluded/$id',
    );

    return TaskModel.fromJson(response.data);
  }

  @override
  Future<TaskModel> updateTask(NewTaskModel tarefa) async {
    final response = await _dio.patch(
      '$basePath/${tarefa.id!}',
      data: tarefa.toJson(),
    );
    return TaskModel.fromJson(response.data);
  }
}
