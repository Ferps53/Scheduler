import 'package:scheduler/features/auth/auth.dart';
import 'package:scheduler/features/auth/data/model/user_model.dart';

import '../model/user_sign_in_model.dart';

abstract class AuthDatasource {
  Future<UserModel> signInUser(UserSignInModel userSignIn);

  Future<void> confirmEmail(String email, String code);

  Future<void> resendEmail(String email);

  Future<JwtModel> fetchJwt(DadosLogin dadosLogin);

  Future<void> saveJwt(JwtModel jwt, String key);

  Future<JwtModel?> getJwtFromLocalStorage();

  Future<void> removeJwt();

  Future<String> getCurrentUserId();
}
