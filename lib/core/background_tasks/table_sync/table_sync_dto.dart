import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/core/background_tasks/table_sync/table_sync_dto.freezed.dart';
part '../../../generated/core/background_tasks/table_sync/table_sync_dto.g.dart';

@freezed
class TableSyncDto with _$TableSyncDto {
  factory TableSyncDto({
    required String name,
    required int userId,
    required List<Map<String, Object?>> rows,
  }) = _TableSyncDto;

  factory TableSyncDto.fromJson(Map<String, Object?> json) =>
      _$TableSyncDtoFromJson(json);
}
