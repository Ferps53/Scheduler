import 'package:dio/dio.dart';
import 'package:todo_list/core/core.dart';
import 'package:todo_list/features/auth/auth.dart';

class JwtDatasourceImpl implements JwtDatasource {
  final Store _store;
  final Dio _dio;

  JwtDatasourceImpl({required Store store, required Dio dio})
      : _store = store,
        _dio = dio;

  @override
  Future<JwtModel> fetchJwt(DadosLogin dadosLogin) async {
    final response = await _dio.post("${Environments.backendRoot}/auth/login");
    final jwtModel = JwtModel.fromJson(response.data);
    saveJwt(jwtModel, 'token', _store);
    return jwtModel;
  }

  @override
  JwtModel? getJwtFromLocalStorage(String key) {
    final jsonStored = _store.getMap(key);
    if (jsonStored != {}) {
      return JwtModel.fromJson(_store.getMap(key));
    } else {
      return null;
    }
  }

  @override
  void removeJwt() {
    _store.remove('token');
  }

  @override
  Future<void> saveJwt(JwtModel jwt, String key, Store store) async {
    await store.saveMap(key, jwt.toJson());
  }
}
