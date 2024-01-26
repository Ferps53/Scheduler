import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/usuario_login.freezed.dart';

@freezed
class UsuarioLogin with _$UsuarioLogin {
  const factory UsuarioLogin({
    required String nomeDoUsuario,
    required String senha,
    required String email,
  }) = _UsuarioLogin;
}
