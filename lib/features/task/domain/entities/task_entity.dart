import 'package:freezed_annotation/freezed_annotation.dart';

import '../../task.dart';

part 'task_entity.freezed.dart';

@freezed
class TaskEntity with _$TaskEntity {
  factory TaskEntity({
    required int? id,
    required String titulo,
    required String descricao,
    required bool? fgConcluida,
    required bool? fgLixeira,
    required DateTime? dataEnvioLixeira,
    required DateTime? dataCriacao,
    required DateTime? dataExpiracao,
    required DateTime? dataConclusao,
  }) = _TaskEntity;

  factory TaskEntity.fromModel({required TaskModel taskModel}) {
    return TaskEntity(
      id: taskModel.id,
      titulo: taskModel.titulo,
      descricao: taskModel.descricao,
      fgConcluida: taskModel.fgConcluida,
      fgLixeira: taskModel.fgLixeira,
      dataEnvioLixeira: DateTime.tryParse(taskModel.dataEnvioLixeira ?? ''),
      dataCriacao: DateTime.tryParse(taskModel.dataCriacao ?? ''),
      dataExpiracao: DateTime.tryParse(taskModel.dataExpiracao ?? ''),
      dataConclusao: DateTime.tryParse(taskModel.dataConclusao ?? ''),
    );
  }
}
