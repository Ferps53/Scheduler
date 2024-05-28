import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:scheduler/features/task/domain/entities/task_entity.dart';

part 'task_model.g.dart';
part 'task_model.freezed.dart';

@freezed
class TaskModel with _$TaskModel {
  factory TaskModel({
    required int? id,
    required String titulo,
    required String? idUsusario,
    required String descricao,
    required bool? fgConcluida,
    required bool? fgLixeira,
    required String? dataEnvioLixeira,
    required String? dataCriacao,
    required String? dataExpiracao,
    required String? dataConclusao,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, Object?> json) =>
      _$TaskModelFromJson(json);

  factory TaskModel.fromEntity({
    required TaskEntity taskEntity,
    int? id,
    String? idUsusario,
  }) {
    return TaskModel(
      id: id,
      titulo: taskEntity.titulo,
      descricao: taskEntity.descricao,
      idUsusario: idUsusario,
      fgConcluida: taskEntity.fgConcluida,
      fgLixeira: taskEntity.fgLixeira,
      dataEnvioLixeira: taskEntity.dataEnvioLixeira?.toIso8601String(),
      dataCriacao: taskEntity.dataCriacao?.toIso8601String(),
      dataExpiracao: taskEntity.dataExpiracao?.toIso8601String(),
      dataConclusao: taskEntity.dataConclusao?.toIso8601String(),
    );
  }
}
