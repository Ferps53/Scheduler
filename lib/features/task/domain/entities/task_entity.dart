import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_entity.freezed.dart';

@freezed
class TaskEntity with _$TaskEntity {
  factory TaskEntity({
    required int id,
    required String titulo,
    required String descricao,
    required bool? fgConcluida,
    required bool? fgLixeira,
    required DateTime? dataEnvioLixeira,
    required DateTime? dataCriacao,
    required DateTime? dataExpiracao,
    required DateTime? dataConclusao,
  }) = _TaskEntity;
}
