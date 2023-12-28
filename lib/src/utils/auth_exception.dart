class AuthException implements Exception {
  static const Map<String, String> errors = {
    'USUARIO_EXISTE': 'Nome de usuário ou email já foram cadastrados',
    "DADOS_INCORRETOS": 'A senha ou nome de usuário informados estão incorretos'
  };

  final String key;

  AuthException(this.key);

  @override
  String toString() {
    return errors[key] ?? "Ocorreu um erro no processo de Autenticação";
  }
}
