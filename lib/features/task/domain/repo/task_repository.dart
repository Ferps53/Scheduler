import 'package:scheduler/features/task/data/model/new_task_model.dart';

import '../entities/entities.dart';

abstract class TaskRepository {
  Future<TaskEntity> createTask(NewTaskModel newTaskModel);
  Future<void> deleteTask(int id);
  Future<TaskEntity> getTask(int id);
  Future<List<TaskEntity>> getTaskList();
  Future<TaskEntity> updateTask(NewTaskModel newTaskModel);
  Future<TaskEntity> toggleConcluded(int id);
}
