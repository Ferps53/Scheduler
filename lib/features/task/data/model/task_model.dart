import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:scheduler/features/task/data/model/new_task_model.dart';
import 'package:scheduler/features/task/domain/entities/task_entity.dart';

part '../../../../generated/features/task/data/model/task_model.g.dart';
part '../../../../generated/features/task/data/model/task_model.freezed.dart';

@freezed
class TaskModel with _$TaskModel {
  const TaskModel._();
  factory TaskModel({
    int? id,
    required String title,
    int? userId,
    required String description,
    required bool? isConcluded,
    required bool? isInTrashBin,
    String? sentToTrashBinAt,
    required String? createdAt,
    required DateTime expiresIn,
    String? concludedAt,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, Object?> json) =>
      _$TaskModelFromJson(json);

  Map<String, Object?> toDatabaseMap() {
    return {
      'id': id,
      'title': title,
      'userId': userId,
      'description': description,
      'isConcluded': isConcluded == true ? 1 : 0,
      'isInTrashBin': isInTrashBin == true ? 1 : 0,
      'sentToTrashBinAt': sentToTrashBinAt,
      'createdAt': createdAt,
      'expiresIn': expiresIn.toIso8601String(),
      'concludedAt': concludedAt,
    };
  }

  factory TaskModel.fromDatabase(Map<String, Object?> databaseMap) {
    return TaskModel(
      id: databaseMap['id'] as int?,
      title: databaseMap['title'] as String,
      userId: databaseMap['userId'] as int,
      description: databaseMap['description'] as String,
      isConcluded: databaseMap['isConcluded'] as int == 1 ? true : false,
      isInTrashBin: databaseMap['isInTrashBin'] as int == 1 ? true : false,
      sentToTrashBinAt: databaseMap['sentToTrashBinAt'] as String?,
      createdAt: databaseMap['createdAt'] as String?,
      expiresIn: DateTime.parse(databaseMap['expiresIn'] as String),
      concludedAt: databaseMap['concludedAt'] as String?,
    );
  }

  factory TaskModel.fromEntity({
    required TaskEntity taskEntity,
    int? id,
    int? userId,
  }) {
    return TaskModel(
      id: id,
      title: taskEntity.title,
      description: taskEntity.description,
      userId: userId,
      isConcluded: taskEntity.isConcluded,
      isInTrashBin: taskEntity.isInTrashBin,
      createdAt: taskEntity.createdAt?.toIso8601String(),
      expiresIn: taskEntity.expiresIn!,
    );
  }

  factory TaskModel.fromNewTask({required NewTaskModel newTaskModel}) {
    return TaskModel(
      id: newTaskModel.id,
      title: newTaskModel.title,
      description: newTaskModel.description,
      expiresIn: newTaskModel.expiresIn,
      createdAt: DateTime.now().toIso8601String(),
      isInTrashBin: false,
      isConcluded: false,
    );
  }
}
