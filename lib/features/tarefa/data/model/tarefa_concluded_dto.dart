import 'package:freezed_annotation/freezed_annotation.dart';

part 'tarefa_concluded_dto.g.dart';
part 'tarefa_concluded_dto.freezed.dart';

@freezed
class TarefaConcludedDTO with _$TarefaConcludedDTO {
  factory TarefaConcludedDTO({
    required String concludedDate,
    required bool? concludedStatus,
  }) = _TarefaConcludedDTO;

  factory TarefaConcludedDTO.fromJson(Map<String, Object?> json) =>
      _$TarefaConcludedDTOFromJson(json);
}
