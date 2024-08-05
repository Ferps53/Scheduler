import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scheduler/features/task/data/model/new_task_model.dart';
import 'package:scheduler/features/task/domain/entities/entities.dart';
import 'package:scheduler/features/task/view/providers/providers.dart';

final taskProvider =
    AsyncNotifierProvider.autoDispose<TaskProvider, List<TaskEntity>>(
        () => TaskProvider());

class TaskProvider extends AutoDisposeAsyncNotifier<List<TaskEntity>> {
  List<TaskEntity> taskList = [];

  @override
  Future<List<TaskEntity>> build() async {
    taskList = await _initTasks();
    return taskList;
  }

  Future<void> refreshTasks() async {
    state = await AsyncValue.guard(
      () => ref.read(taskRepositoryProvider).getTaskList(),
    );
  }

  Future<void> deleteTask(int id) async {
    await ref.read(taskRepositoryProvider).deleteTask(id);
    await refreshTasks();
  }

  Future<void> createTask(NewTaskModel newTaskModel) async {
    await ref.read(taskRepositoryProvider).createTask(newTaskModel);
    await refreshTasks();
  }

  Future<void> updateTask(NewTaskModel taskEntity) async {
    await ref.read(taskRepositoryProvider).updateTask(taskEntity);
    await refreshTasks();
  }

  Future<void> toggleStatus(int id) async {
    await ref.read(taskRepositoryProvider).toggleConcluded(id);
    return await refreshTasks();
  }

  Future<List<TaskEntity>> _initTasks() async {
    final taskRepository = ref.read(taskRepositoryProvider);
    return await taskRepository.getTaskList();
  }
}
