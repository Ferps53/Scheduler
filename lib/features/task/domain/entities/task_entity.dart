import 'package:freezed_annotation/freezed_annotation.dart';

import '../../task.dart';

part '../../../../generated/features/task/domain/entities/task_entity.freezed.dart';

@freezed
class TaskEntity with _$TaskEntity {
  factory TaskEntity({
    int? id,
    required String title,
    required String description,
    required bool? isConcluded,
    required bool? isInTrashBin,
    required DateTime? createdAt,
    required DateTime? expiresIn,
  }) = _TaskEntity;

  factory TaskEntity.fromModel({required TaskModel taskModel}) {
    return TaskEntity(
      id: taskModel.id,
      title: taskModel.title,
      description: taskModel.description,
      isConcluded: taskModel.isConcluded,
      isInTrashBin: taskModel.isInTrashBin,
      createdAt: DateTime.tryParse(taskModel.createdAt ?? ''),
      expiresIn: DateTime.tryParse(taskModel.expiresIn ?? ''),
    );
  }
}
