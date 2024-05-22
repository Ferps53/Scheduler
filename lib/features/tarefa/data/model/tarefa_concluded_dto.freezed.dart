// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tarefa_concluded_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TarefaConcludedDTO _$TarefaConcludedDTOFromJson(Map<String, dynamic> json) {
  return _TarefaConcludedDTO.fromJson(json);
}

/// @nodoc
mixin _$TarefaConcludedDTO {
  String get concludedDate => throw _privateConstructorUsedError;
  bool? get concludedStatus => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TarefaConcludedDTOCopyWith<TarefaConcludedDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TarefaConcludedDTOCopyWith<$Res> {
  factory $TarefaConcludedDTOCopyWith(
          TarefaConcludedDTO value, $Res Function(TarefaConcludedDTO) then) =
      _$TarefaConcludedDTOCopyWithImpl<$Res, TarefaConcludedDTO>;
  @useResult
  $Res call({String concludedDate, bool? concludedStatus});
}

/// @nodoc
class _$TarefaConcludedDTOCopyWithImpl<$Res, $Val extends TarefaConcludedDTO>
    implements $TarefaConcludedDTOCopyWith<$Res> {
  _$TarefaConcludedDTOCopyWithImpl(this._value, this._then);

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
abstract class _$$TarefaConcludedDTOImplCopyWith<$Res>
    implements $TarefaConcludedDTOCopyWith<$Res> {
  factory _$$TarefaConcludedDTOImplCopyWith(_$TarefaConcludedDTOImpl value,
          $Res Function(_$TarefaConcludedDTOImpl) then) =
      __$$TarefaConcludedDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String concludedDate, bool? concludedStatus});
}

/// @nodoc
class __$$TarefaConcludedDTOImplCopyWithImpl<$Res>
    extends _$TarefaConcludedDTOCopyWithImpl<$Res, _$TarefaConcludedDTOImpl>
    implements _$$TarefaConcludedDTOImplCopyWith<$Res> {
  __$$TarefaConcludedDTOImplCopyWithImpl(_$TarefaConcludedDTOImpl _value,
      $Res Function(_$TarefaConcludedDTOImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? concludedDate = null,
    Object? concludedStatus = freezed,
  }) {
    return _then(_$TarefaConcludedDTOImpl(
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
class _$TarefaConcludedDTOImpl implements _TarefaConcludedDTO {
  _$TarefaConcludedDTOImpl(
      {required this.concludedDate, required this.concludedStatus});

  factory _$TarefaConcludedDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$TarefaConcludedDTOImplFromJson(json);

  @override
  final String concludedDate;
  @override
  final bool? concludedStatus;

  @override
  String toString() {
    return 'TarefaConcludedDTO(concludedDate: $concludedDate, concludedStatus: $concludedStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TarefaConcludedDTOImpl &&
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
  _$$TarefaConcludedDTOImplCopyWith<_$TarefaConcludedDTOImpl> get copyWith =>
      __$$TarefaConcludedDTOImplCopyWithImpl<_$TarefaConcludedDTOImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TarefaConcludedDTOImplToJson(
      this,
    );
  }
}

abstract class _TarefaConcludedDTO implements TarefaConcludedDTO {
  factory _TarefaConcludedDTO(
      {required final String concludedDate,
      required final bool? concludedStatus}) = _$TarefaConcludedDTOImpl;

  factory _TarefaConcludedDTO.fromJson(Map<String, dynamic> json) =
      _$TarefaConcludedDTOImpl.fromJson;

  @override
  String get concludedDate;
  @override
  bool? get concludedStatus;
  @override
  @JsonKey(ignore: true)
  _$$TarefaConcludedDTOImplCopyWith<_$TarefaConcludedDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
