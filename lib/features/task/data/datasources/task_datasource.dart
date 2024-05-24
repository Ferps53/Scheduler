import 'package:scheduler/features/task/task.dart';

abstract class TaskDatasource {
  Future<TaskModel> getTaskById(int id);

  Future<List<TaskModel>> getTasks();

  Future<TaskModel> updateTask(TaskModel tarefaModel);

  Future<void> deleteTask(int id);

  Future<TaskModel> toggleConcluded(int id, bool? concludedStatus);
}
