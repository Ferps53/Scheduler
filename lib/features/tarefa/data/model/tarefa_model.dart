import 'package:freezed_annotation/freezed_annotation.dart';

part 'tarefa_model.g.dart';
part 'tarefa_model.freezed.dart';

@freezed
class TarefaModel with _$TarefaModel {
  factory TarefaModel({
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
  }) = _TarefaModel;

  factory TarefaModel.fromJson(Map<String, Object?> json) =>
      _$TarefaModelFromJson(json);
}
