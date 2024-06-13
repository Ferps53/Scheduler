import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scheduler/features/task/domain/entities/entities.dart';
import 'package:scheduler/features/task/view/providers/providers.dart';

final taskProvider =
    AsyncNotifierProvider.autoDispose<TaskProvider, List<TaskEntity>>(
        () => TaskProvider());

class TaskProvider extends AutoDisposeAsyncNotifier<List<TaskEntity>> {
  @override
  Future<List<TaskEntity>> build() async {
    return await _initTasks();
  }

  Future<void> fetchTasks() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(taskRepositoryProvider).getTaskList(),
    );
  }

  Future<void> deleteTask(int id) async {
    await ref.read(taskRepositoryProvider).deleteTask(id);
    await fetchTasks();
  }

  Future<void> createTask(TaskEntity taskEntity) async {
    await ref.read(taskRepositoryProvider).createTask(taskEntity);
    await fetchTasks();
  }

  Future<void> updateTask(TaskEntity taskEntity) async {
    await ref.read(taskRepositoryProvider).updateTask(taskEntity);
    await fetchTasks();
  }

  Future<void> toggleStatus(int id, bool? statusConcluded) async {
    await ref.read(taskRepositoryProvider).toggleConcluded(id, statusConcluded);
    await fetchTasks();
  }

  Future<List<TaskEntity>> _initTasks() async {
    final taskRepository = ref.read(taskRepositoryProvider);
    return await taskRepository.getTaskList();
  }
}
