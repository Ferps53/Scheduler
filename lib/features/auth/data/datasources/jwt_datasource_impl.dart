import 'package:dio/dio.dart';
import 'package:todo_list/core/core.dart';
import 'package:todo_list/features/auth/auth.dart';

class FakeJwtDatasource implements JwtDatasource {
  final Store _store;

  FakeJwtDatasource({required Store store}) : _store = store;

  @override
  Future<JwtModel> fetchJwt(DadosLogin dadosLogin) {
    if (dadosLogin.login == "felipebrostolinribeiro@gmail.com" &&
        dadosLogin.senha == "123456") {
      return Future.delayed(const Duration(milliseconds: 200),
          () => JwtModel(access_token: "aa", refresh_token: "a"));
    }
    throw Exception("Rapaiz");
  }

  @override
  JwtModel? getJwtFromLocalStorage(String key) {
    final jsonStored = _store.getMap(key);
    if (jsonStored.isNotEmpty) {
      return JwtModel.fromJson(_store.getMap(key));
    } else {
      return null;
    }
  }

  @override
  void removeJwt() {}

  @override
  Future<void> saveJwt(JwtModel jwt, String key) async {
    _store.saveMap(key, jwt.toJson());
  }
}

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
    saveJwt(jwtModel, 'token');
    return jwtModel;
  }

  @override
  JwtModel? getJwtFromLocalStorage(String key) {
    final jsonStored = _store.getMap(key);
    if (jsonStored.isNotEmpty) {
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
  Future<void> saveJwt(JwtModel jwt, String key) async {
    await _store.saveMap(key, jwt.toJson());
  }
}
