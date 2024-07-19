import 'package:scheduler/features/auth/auth.dart';
import 'package:scheduler/features/auth/data/model/user_model.dart';

import '../model/user_sign_in_model.dart';

abstract class JwtDatasource {
  Future<UserModel> signInUser(UserSignInModel userSignIn);

  Future<JwtModel> fetchJwt(DadosLogin dadosLogin);

  Future<void> saveJwt(JwtModel jwt, String key);

  Future<JwtModel?> getJwtFromLocalStorage();

  Future<void> removeJwt();

  Future<String> getCurrentUserId();
}
