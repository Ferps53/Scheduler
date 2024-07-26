import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../../generated/features/auth/domain/entities/dados_login/dados_login.g.dart';
part '../../../../../generated/features/auth/domain/entities/dados_login/dados_login.freezed.dart';

@freezed
class DadosLogin with _$DadosLogin {
  const factory DadosLogin({
    required String nomeUsuario,
    required String email,
    required String senha,
  }) = _DadosLogin;

  factory DadosLogin.fromJson(Map<String, dynamic> json) =>
      _$DadosLoginFromJson(json);
}
