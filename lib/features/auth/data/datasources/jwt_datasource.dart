import 'package:todo_list/features/auth/auth.dart';

abstract class JwtDatasource {
  Future<JwtModel> fetchJwt(DadosLogin dadosLogin);

  Future<void> saveJwt(JwtModel jwt, String key);

  JwtModel? getJwtFromLocalStorage(String key);

  void removeJwt();
}
