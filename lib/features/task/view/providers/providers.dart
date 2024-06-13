import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scheduler/core/core.dart';
import 'package:scheduler/features/task/data/datasources/task_api_datasource.dart';
import 'package:scheduler/features/task/data/datasources/task_local_datasource.dart';
import 'package:scheduler/features/task/data/repo/task_repository_impl.dart';
import 'package:scheduler/features/task/domain/repo/task_repository.dart';

final Provider<TaskLocalDatasource> taskLocalDatasourceProvider =
    Provider<TaskLocalDatasource>(
  (ref) => TaskLocalDatasource(
    ref.read(
      databaseProvider,
    ),
    ref.read(storeProvider),
  ),
);

final Provider<TaskApiDatasource> taskApiDatasourceProvider =
    Provider<TaskApiDatasource>(
  (ref) => TaskApiDatasource(
    ref.read(
      dioProvider,
    ),
  ),
);

final Provider<TaskRepository> taskRepositoryProvider =
    Provider<TaskRepository>((ref) {
  final TaskApiDatasource taskApiDatasource =
      ref.read(taskApiDatasourceProvider);
  final TaskLocalDatasource taskLocalDatasource =
      ref.read(taskLocalDatasourceProvider);
  return TaskRepositoryImpl(
    taskApiDatasource: taskApiDatasource,
    taskLocalDatasource: taskLocalDatasource,
  );
});
