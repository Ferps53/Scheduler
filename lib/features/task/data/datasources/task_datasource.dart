import 'package:scheduler/features/task/task.dart';

abstract class TaskDatasource {
  Future<TaskModel> createTask(TaskModel taskModel);

  Future<void> deleteTask(int id);

  Future<TaskModel> getTaskById(int id);

  Future<List<TaskModel>> getTasks();

  Future<TaskModel> toggleConcluded(int id, bool? concludedStatus);

  Future<TaskModel> updateTask(TaskModel tarefaModel);
}
