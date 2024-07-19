// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'jwt_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

JwtModel _$JwtModelFromJson(Map<String, dynamic> json) {
  return _JwtModel.fromJson(json);
}

/// @nodoc
mixin _$JwtModel {
  String get access_token => throw _privateConstructorUsedError;
  String get refresh_token => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  int get expires_in => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JwtModelCopyWith<JwtModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JwtModelCopyWith<$Res> {
  factory $JwtModelCopyWith(JwtModel value, $Res Function(JwtModel) then) =
      _$JwtModelCopyWithImpl<$Res, JwtModel>;
  @useResult
  $Res call(
      {String access_token, String refresh_token, String type, int expires_in});
}

/// @nodoc
class _$JwtModelCopyWithImpl<$Res, $Val extends JwtModel>
    implements $JwtModelCopyWith<$Res> {
  _$JwtModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? access_token = null,
    Object? refresh_token = null,
    Object? type = null,
    Object? expires_in = null,
  }) {
    return _then(_value.copyWith(
      access_token: null == access_token
          ? _value.access_token
          : access_token // ignore: cast_nullable_to_non_nullable
              as String,
      refresh_token: null == refresh_token
          ? _value.refresh_token
          : refresh_token // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      expires_in: null == expires_in
          ? _value.expires_in
          : expires_in // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$JwtModelImplCopyWith<$Res>
    implements $JwtModelCopyWith<$Res> {
  factory _$$JwtModelImplCopyWith(
          _$JwtModelImpl value, $Res Function(_$JwtModelImpl) then) =
      __$$JwtModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String access_token, String refresh_token, String type, int expires_in});
}

/// @nodoc
class __$$JwtModelImplCopyWithImpl<$Res>
    extends _$JwtModelCopyWithImpl<$Res, _$JwtModelImpl>
    implements _$$JwtModelImplCopyWith<$Res> {
  __$$JwtModelImplCopyWithImpl(
      _$JwtModelImpl _value, $Res Function(_$JwtModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? access_token = null,
    Object? refresh_token = null,
    Object? type = null,
    Object? expires_in = null,
  }) {
    return _then(_$JwtModelImpl(
      access_token: null == access_token
          ? _value.access_token
          : access_token // ignore: cast_nullable_to_non_nullable
              as String,
      refresh_token: null == refresh_token
          ? _value.refresh_token
          : refresh_token // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      expires_in: null == expires_in
          ? _value.expires_in
          : expires_in // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$JwtModelImpl implements _JwtModel {
  _$JwtModelImpl(
      {required this.access_token,
      required this.refresh_token,
      required this.type,
      required this.expires_in});

  factory _$JwtModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$JwtModelImplFromJson(json);

  @override
  final String access_token;
  @override
  final String refresh_token;
  @override
  final String type;
  @override
  final int expires_in;

  @override
  String toString() {
    return 'JwtModel(access_token: $access_token, refresh_token: $refresh_token, type: $type, expires_in: $expires_in)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JwtModelImpl &&
            (identical(other.access_token, access_token) ||
                other.access_token == access_token) &&
            (identical(other.refresh_token, refresh_token) ||
                other.refresh_token == refresh_token) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.expires_in, expires_in) ||
                other.expires_in == expires_in));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, access_token, refresh_token, type, expires_in);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$JwtModelImplCopyWith<_$JwtModelImpl> get copyWith =>
      __$$JwtModelImplCopyWithImpl<_$JwtModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JwtModelImplToJson(
      this,
    );
  }
}

abstract class _JwtModel implements JwtModel {
  factory _JwtModel(
      {required final String access_token,
      required final String refresh_token,
      required final String type,
      required final int expires_in}) = _$JwtModelImpl;

  factory _JwtModel.fromJson(Map<String, dynamic> json) =
      _$JwtModelImpl.fromJson;

  @override
  String get access_token;
  @override
  String get refresh_token;
  @override
  String get type;
  @override
  int get expires_in;
  @override
  @JsonKey(ignore: true)
  _$$JwtModelImplCopyWith<_$JwtModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
