// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_concluded_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskConcludedDTOImpl _$$TaskConcludedDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$TaskConcludedDTOImpl(
      concludedDate: json['concludedDate'] as String,
      concludedStatus: json['concludedStatus'] as bool?,
    );

Map<String, dynamic> _$$TaskConcludedDTOImplToJson(
        _$TaskConcludedDTOImpl instance) =>
    <String, dynamic>{
      'concludedDate': instance.concludedDate,
      'concludedStatus': instance.concludedStatus,
    };
