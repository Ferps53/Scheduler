import '../entities/entities.dart';

abstract class TaskRepository {
  Future<TaskEntity> createTask(TaskEntity task);
  Future<void> deleteTask(int id);
  Future<TaskEntity> getTask(int id);
  Future<List<TaskEntity>> getTaskList();
  Future<TaskEntity> updateTask(TaskEntity taskEntity);
  Future<TaskEntity> toggleConcluded(int id);
}
