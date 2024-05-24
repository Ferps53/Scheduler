import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_concluded_dto.g.dart';
part 'task_concluded_dto.freezed.dart';

@freezed
class TaskConcludedDTO with _$TaskConcludedDTO {
  factory TaskConcludedDTO({
    required String concludedDate,
    required bool? concludedStatus,
  }) = _TaskConcludedDTO;

  factory TaskConcludedDTO.fromJson(Map<String, Object?> json) =>
      _$TaskConcludedDTOFromJson(json);
}
