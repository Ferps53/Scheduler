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
      idUsusario: ['idUsusario'] as String,
      descricao: ['descricao'] as String,
      fgConcluida: ['fgConcluida'] as int == 1 ? true : false,
      fgLixeira: ['fgLixeira'] as int == 1 ? true : false,
      dataEnvioLixeira: ['dataEnvioLixeira'] as String,
      dataCriacao: ['dataCriacao'] as String,
      dataExpiracao: ['dataExpiracao'] as String,
      dataConclusao: ['dataConclusao'] as String,
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
