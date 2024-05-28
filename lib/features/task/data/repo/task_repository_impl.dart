import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:scheduler/features/task/data/datasources/task_api_datasource.dart';
import 'package:scheduler/features/task/data/datasources/task_local_datasource.dart';
import 'package:scheduler/features/task/domain/entities/task_entity.dart';
import 'package:scheduler/features/task/domain/repo/task_repository.dart';

import '../data.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskApiDatasource taskApiDatasource;
  final TaskLocalDatasource taskLocalDatasource;

  TaskRepositoryImpl({
    required this.taskApiDatasource,
    required this.taskLocalDatasource,
  });

  @override
  Future<TaskEntity> createTask(TaskEntity task) async {
    if (await hasInternetConnection()) {
      final TaskModel taskModel = await taskApiDatasource
          .createTask(TaskModel.fromEntity(taskEntity: task));
      await taskLocalDatasource.createTask(taskModel);
      return TaskEntity.fromModel(taskModel: taskModel);
    } else {
      final taskModel = await taskLocalDatasource
          .createTask(TaskModel.fromEntity(taskEntity: task));
      return TaskEntity.fromModel(taskModel: taskModel);
    }
  }

  @override
  Future<void> deleteTask(int id) {
    // TODO: implement deleteTask
    throw UnimplementedError();
  }

  @override
  Future<TaskEntity> getTask(int id) {
    // TODO: implement getTask
    throw UnimplementedError();
  }

  @override
  Future<List<TaskEntity>> getTaskList() {
    // TODO: implement getTaskList
    throw UnimplementedError();
  }

  Future<bool> hasInternetConnection() async =>
      await InternetConnection().hasInternetAccess;

  @override
  Future<TaskEntity> toggleConcluded(int id, bool? statusConcluded) {
    // TODO: implement toggleConcluded
    throw UnimplementedError();
  }

  @override
  Future<TaskEntity> updateTask(int id) {
    // TODO: implement updateTask
    throw UnimplementedError();
  }
}
