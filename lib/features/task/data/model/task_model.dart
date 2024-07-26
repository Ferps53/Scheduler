import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:scheduler/features/task/domain/entities/task_entity.dart';

part '../../../../generated/features/task/data/model/task_model.g.dart';
part '../../../../generated/features/task/data/model/task_model.freezed.dart';

@freezed
class TaskModel with _$TaskModel {
  const TaskModel._();
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

  Map<String, Object?> toDatabaseMap() {
    return {
      'id': id,
      'titulo': titulo,
      'idUsuario': idUsusario,
      'descricao': descricao,
      'fgConcluida': fgConcluida == true ? 1 : 0,
      'fgLixeira': fgLixeira == true ? 1 : 0,
      'dataEnvioLixeira': dataEnvioLixeira,
      'dataCriacao': dataCriacao,
      'dataExpiracao': dataExpiracao,
      'dataConclusao': dataConclusao,
    };
  }

  factory TaskModel.fromDatabase(Map<String, Object?> databaseMap) {
    return TaskModel(
      id: databaseMap['id'] as int?,
      titulo: databaseMap['titulo'] as String,
      idUsusario: databaseMap['idUsuario'] as String,
      descricao: databaseMap['descricao'] as String,
      fgConcluida: databaseMap['fgConcluida'] as int == 1 ? true : false,
      fgLixeira: databaseMap['fgLixeira'] as int == 1 ? true : false,
      dataEnvioLixeira: databaseMap['dataEnvioLixeira'] as String?,
      dataCriacao: databaseMap['dataCriacao'] as String?,
      dataExpiracao: databaseMap['dataExpiracao'] as String?,
      dataConclusao: databaseMap['dataConclusao'] as String?,
    );
  }

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
