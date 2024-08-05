import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:scheduler/features/task/data/datasources/task_api_datasource.dart';
import 'package:scheduler/features/task/data/datasources/task_local_datasource.dart';
import 'package:scheduler/features/task/data/model/new_task_model.dart';
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
  Future<TaskEntity> createTask(NewTaskModel newTaskModel) async {
    if (await _hasInternetConnection()) {
      final TaskModel taskModel =
          await taskApiDatasource.createTask(newTaskModel);
      newTaskModel = newTaskModel.copyWith(id: taskModel.id);

      await taskLocalDatasource.createTask(newTaskModel);
      return TaskEntity.fromModel(taskModel: taskModel);
    } else {
      final taskModel = await taskLocalDatasource.createTask(newTaskModel);
      return TaskEntity.fromModel(taskModel: taskModel);
    }
  }

  @override
  Future<void> deleteTask(int id) async {
    if (await _hasInternetConnection()) {
      await taskApiDatasource.deleteTask(id);
      await taskLocalDatasource.deleteTask(id);
    } else {
      await taskLocalDatasource.deleteTask(id);
    }
  }

  @override
  Future<TaskEntity> getTask(int id) async {
    final TaskModel taskModel;
    if (await _hasInternetConnection()) {
      taskModel = await taskApiDatasource.getTaskById(id);
      return TaskEntity.fromModel(taskModel: taskModel);
    }
    taskModel = await taskLocalDatasource.getTaskById(id);
    return TaskEntity.fromModel(taskModel: taskModel);
  }

  @override
  Future<List<TaskEntity>> getTaskList() async {
    final List<TaskModel> models;
    final List<TaskEntity> entities = [];
    if (await _hasInternetConnection()) {
      models = await taskApiDatasource.getTasks();
    } else {
      models = await taskLocalDatasource.getTasks();
    }

    for (final model in models) {
      entities.add(TaskEntity.fromModel(taskModel: model));
    }

    return entities;
  }

  @override
  Future<TaskEntity> toggleConcluded(int id) async {
    final TaskModel taskModel;
    if (await _hasInternetConnection()) {
      taskModel = await taskApiDatasource.toggleConcluded(id);
      await taskLocalDatasource.toggleConcluded(id);
    } else {
      taskModel = await taskLocalDatasource.toggleConcluded(id);
    }
    return TaskEntity.fromModel(taskModel: taskModel);
  }

  @override
  Future<TaskEntity> updateTask(NewTaskModel newTaskModel) async {
    final TaskModel taskModel;
    if (await _hasInternetConnection()) {
      taskModel = await taskApiDatasource.updateTask(newTaskModel);
      await taskLocalDatasource.updateTask(newTaskModel);
    } else {
      taskModel = await taskLocalDatasource.updateTask(newTaskModel);
    }
    return TaskEntity.fromModel(taskModel: taskModel);
  }

  //--

  Future<bool> _hasInternetConnection() async =>
      await InternetConnection().hasInternetAccess;
}
