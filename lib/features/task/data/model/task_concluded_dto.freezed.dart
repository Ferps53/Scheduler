// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_concluded_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TaskConcludedDTO _$TaskConcludedDTOFromJson(Map<String, dynamic> json) {
  return _TaskConcludedDTO.fromJson(json);
}

/// @nodoc
mixin _$TaskConcludedDTO {
  String get concludedDate => throw _privateConstructorUsedError;
  bool? get concludedStatus => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskConcludedDTOCopyWith<TaskConcludedDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskConcludedDTOCopyWith<$Res> {
  factory $TaskConcludedDTOCopyWith(
          TaskConcludedDTO value, $Res Function(TaskConcludedDTO) then) =
      _$TaskConcludedDTOCopyWithImpl<$Res, TaskConcludedDTO>;
  @useResult
  $Res call({String concludedDate, bool? concludedStatus});
}

/// @nodoc
class _$TaskConcludedDTOCopyWithImpl<$Res, $Val extends TaskConcludedDTO>
    implements $TaskConcludedDTOCopyWith<$Res> {
  _$TaskConcludedDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? concludedDate = null,
    Object? concludedStatus = freezed,
  }) {
    return _then(_value.copyWith(
      concludedDate: null == concludedDate
          ? _value.concludedDate
          : concludedDate // ignore: cast_nullable_to_non_nullable
              as String,
      concludedStatus: freezed == concludedStatus
          ? _value.concludedStatus
          : concludedStatus // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaskConcludedDTOImplCopyWith<$Res>
    implements $TaskConcludedDTOCopyWith<$Res> {
  factory _$$TaskConcludedDTOImplCopyWith(_$TaskConcludedDTOImpl value,
          $Res Function(_$TaskConcludedDTOImpl) then) =
      __$$TaskConcludedDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String concludedDate, bool? concludedStatus});
}

/// @nodoc
class __$$TaskConcludedDTOImplCopyWithImpl<$Res>
    extends _$TaskConcludedDTOCopyWithImpl<$Res, _$TaskConcludedDTOImpl>
    implements _$$TaskConcludedDTOImplCopyWith<$Res> {
  __$$TaskConcludedDTOImplCopyWithImpl(_$TaskConcludedDTOImpl _value,
      $Res Function(_$TaskConcludedDTOImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? concludedDate = null,
    Object? concludedStatus = freezed,
  }) {
    return _then(_$TaskConcludedDTOImpl(
      concludedDate: null == concludedDate
          ? _value.concludedDate
          : concludedDate // ignore: cast_nullable_to_non_nullable
              as String,
      concludedStatus: freezed == concludedStatus
          ? _value.concludedStatus
          : concludedStatus // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskConcludedDTOImpl implements _TaskConcludedDTO {
  _$TaskConcludedDTOImpl(
      {required this.concludedDate, required this.concludedStatus});

  factory _$TaskConcludedDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskConcludedDTOImplFromJson(json);

  @override
  final String concludedDate;
  @override
  final bool? concludedStatus;

  @override
  String toString() {
    return 'TaskConcludedDTO(concludedDate: $concludedDate, concludedStatus: $concludedStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskConcludedDTOImpl &&
            (identical(other.concludedDate, concludedDate) ||
                other.concludedDate == concludedDate) &&
            (identical(other.concludedStatus, concludedStatus) ||
                other.concludedStatus == concludedStatus));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, concludedDate, concludedStatus);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskConcludedDTOImplCopyWith<_$TaskConcludedDTOImpl> get copyWith =>
      __$$TaskConcludedDTOImplCopyWithImpl<_$TaskConcludedDTOImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskConcludedDTOImplToJson(
      this,
    );
  }
}

abstract class _TaskConcludedDTO implements TaskConcludedDTO {
  factory _TaskConcludedDTO(
      {required final String concludedDate,
      required final bool? concludedStatus}) = _$TaskConcludedDTOImpl;

  factory _TaskConcludedDTO.fromJson(Map<String, dynamic> json) =
      _$TaskConcludedDTOImpl.fromJson;

  @override
  String get concludedDate;
  @override
  bool? get concludedStatus;
  @override
  @JsonKey(ignore: true)
  _$$TaskConcludedDTOImplCopyWith<_$TaskConcludedDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
