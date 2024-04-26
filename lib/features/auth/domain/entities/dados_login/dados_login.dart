import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dados_login.g.dart';
part 'dados_login.freezed.dart';

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
