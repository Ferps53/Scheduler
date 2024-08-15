import 'package:scheduler/features/auth/auth.dart';

import '../../data/model/user_model.dart';

abstract class LoginRepository {
  Future<StatusLogin> login(LoginData loginData);

  Future<StatusLogin> autoLogin();

  void deslogar();

  Future<UserModel> signIn(LoginData loginData);

  Future<void> confirmEmail(String code, String email);

  Future<void> resendEmail(String email);
}
