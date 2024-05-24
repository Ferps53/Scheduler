import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_model.g.dart';
part 'task_model.freezed.dart';

@freezed
class TaskModel with _$TaskModel {
  factory TaskModel({
    required int id,
    required String titulo,
    required String idUsusario,
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
}
