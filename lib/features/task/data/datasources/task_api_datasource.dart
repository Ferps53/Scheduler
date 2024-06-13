import 'package:dio/dio.dart';
import 'package:scheduler/features/task/task.dart';

class TaskApiDatasource implements TaskDatasource {
  final Dio _dio;

  TaskApiDatasource(this._dio);

  @override
  Future<TaskModel> createTask(TaskModel taskModel) async {
    final response = await _dio.post(
      '/tarefa',
      data: taskModel.toJson(),
    );
    return TaskModel.fromJson(response.data);
  }

  @override
  Future<void> deleteTask(int id) async {
    await _dio.delete('/tarefa/$id');
  }

  @override
  Future<TaskModel> getTaskById(int id) async {
    final response = await _dio.get('/tarefa/$id');

    return TaskModel.fromJson(response.data!);
  }

  @override
  Future<List<TaskModel>> getTasks() async {
    final response = await _dio.get('/tarefa');

    List<TaskModel> listTasks = [];
    if (response.data != null) {
      for (final tarefa in response.data!) {
        listTasks.add(TaskModel.fromJson(tarefa));
      }
    }
    return listTasks;
  }

  @override
  Future<TaskModel> toggleConcluded(int id, bool? concludedStatus) async {
    final TaskConcludedDTO tarefaConcludedDTO = TaskConcludedDTO(
      concludedStatus: concludedStatus,
      concludedDate: DateTime.now().toIso8601String(),
    );
    final response = await _dio.put(
      '/tarefa/$id/atualizarStatus',
      data: tarefaConcludedDTO.toJson(),
    );

    return TaskModel.fromJson(response.data);
  }

  @override
  Future<TaskModel> updateTask(TaskModel tarefa) async {
    final response = await _dio.put(
      '/tarefa',
      data: tarefa.toJson(),
    );
    return TaskModel.fromJson(response.data);
  }
}
