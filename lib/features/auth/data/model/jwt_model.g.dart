// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jwt_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$JwtModelImpl _$$JwtModelImplFromJson(Map<String, dynamic> json) =>
    _$JwtModelImpl(
      access_token: json['access_token'] as String,
      refresh_token: json['refresh_token'] as String?,
    );

Map<String, dynamic> _$$JwtModelImplToJson(_$JwtModelImpl instance) =>
    <String, dynamic>{
      'access_token': instance.access_token,
      'refresh_token': instance.refresh_token,
    };
