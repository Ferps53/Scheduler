import '../../auth.dart';

abstract class LoginRepo {
  Future<StatusUsuario> login(DadosLogin dadosLogin);

  StatusUsuario autoLogin();

  void deslogar();
}
