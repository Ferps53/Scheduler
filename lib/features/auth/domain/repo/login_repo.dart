import 'package:scheduler/features/auth/auth.dart';

abstract class LoginRepo {
  Future<StatusLogin> login(DadosLogin dadosLogin);

  Future<StatusLogin> autoLogin();

  void deslogar();
}
