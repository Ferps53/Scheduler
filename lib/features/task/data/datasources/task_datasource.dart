import 'package:scheduler/features/task/task.dart';

import '../model/new_task_model.dart';

abstract class TaskDatasource {
  Future<TaskModel> createTask(NewTaskModel taskModel);

  Future<void> deleteTask(int id);

  Future<TaskModel> getTaskById(int id);

  Future<List<TaskModel>> getTasks();

  Future<TaskModel> toggleConcluded(int id);

  Future<TaskModel> updateTask(TaskModel tarefaModel);
}
