import 'package:todo_list/core/store/store.dart';
import 'package:todo_list/features/auth/auth.dart';

abstract class JwtDatasource {
  Future<JwtModel> fetchJwt(DadosLogin dadosLogin);

  Future<void> saveJwt(JwtModel jwt, String key, Store store);

  JwtModel? getJwtFromLocalStorage(String key);

  void removeJwt();
}
