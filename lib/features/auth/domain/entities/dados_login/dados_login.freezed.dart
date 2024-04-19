// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dados_login.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DadosLogin _$DadosLoginFromJson(Map<String, dynamic> json) {
  return _DadosLogin.fromJson(json);
}

/// @nodoc
mixin _$DadosLogin {
  String get login => throw _privateConstructorUsedError;
  String get senha => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DadosLoginCopyWith<DadosLogin> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DadosLoginCopyWith<$Res> {
  factory $DadosLoginCopyWith(
          DadosLogin value, $Res Function(DadosLogin) then) =
      _$DadosLoginCopyWithImpl<$Res, DadosLogin>;
  @useResult
  $Res call({String login, String senha});
}

/// @nodoc
class _$DadosLoginCopyWithImpl<$Res, $Val extends DadosLogin>
    implements $DadosLoginCopyWith<$Res> {
  _$DadosLoginCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? login = null,
    Object? senha = null,
  }) {
    return _then(_value.copyWith(
      login: null == login
          ? _value.login
          : login // ignore: cast_nullable_to_non_nullable
              as String,
      senha: null == senha
          ? _value.senha
          : senha // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DadosLoginImplCopyWith<$Res>
    implements $DadosLoginCopyWith<$Res> {
  factory _$$DadosLoginImplCopyWith(
          _$DadosLoginImpl value, $Res Function(_$DadosLoginImpl) then) =
      __$$DadosLoginImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String login, String senha});
}

/// @nodoc
class __$$DadosLoginImplCopyWithImpl<$Res>
    extends _$DadosLoginCopyWithImpl<$Res, _$DadosLoginImpl>
    implements _$$DadosLoginImplCopyWith<$Res> {
  __$$DadosLoginImplCopyWithImpl(
      _$DadosLoginImpl _value, $Res Function(_$DadosLoginImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? login = null,
    Object? senha = null,
  }) {
    return _then(_$DadosLoginImpl(
      login: null == login
          ? _value.login
          : login // ignore: cast_nullable_to_non_nullable
              as String,
      senha: null == senha
          ? _value.senha
          : senha // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DadosLoginImpl with DiagnosticableTreeMixin implements _DadosLogin {
  const _$DadosLoginImpl({required this.login, required this.senha});

  factory _$DadosLoginImpl.fromJson(Map<String, dynamic> json) =>
      _$$DadosLoginImplFromJson(json);

  @override
  final String login;
  @override
  final String senha;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DadosLogin(login: $login, senha: $senha)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DadosLogin'))
      ..add(DiagnosticsProperty('login', login))
      ..add(DiagnosticsProperty('senha', senha));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DadosLoginImpl &&
            (identical(other.login, login) || other.login == login) &&
            (identical(other.senha, senha) || other.senha == senha));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, login, senha);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DadosLoginImplCopyWith<_$DadosLoginImpl> get copyWith =>
      __$$DadosLoginImplCopyWithImpl<_$DadosLoginImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DadosLoginImplToJson(
      this,
    );
  }
}

abstract class _DadosLogin implements DadosLogin {
  const factory _DadosLogin(
      {required final String login,
      required final String senha}) = _$DadosLoginImpl;

  factory _DadosLogin.fromJson(Map<String, dynamic> json) =
      _$DadosLoginImpl.fromJson;

  @override
  String get login;
  @override
  String get senha;
  @override
  @JsonKey(ignore: true)
  _$$DadosLoginImplCopyWith<_$DadosLoginImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
