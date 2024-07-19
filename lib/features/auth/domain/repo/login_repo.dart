import 'package:scheduler/features/auth/auth.dart';

import '../../data/model/user_model.dart';

abstract class LoginRepo {
  Future<StatusLogin> login(DadosLogin dadosLogin);

  Future<StatusLogin> autoLogin();

  void deslogar();

  Future<UserModel> signIn(DadosLogin dadosLogin);
}
