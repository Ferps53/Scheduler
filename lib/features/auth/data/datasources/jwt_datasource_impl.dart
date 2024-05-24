import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:scheduler/core/core.dart';
import 'package:scheduler/features/auth/auth.dart';

class FakeJwtDatasource implements JwtDatasource {
  final Store _store;

  FakeJwtDatasource({required Store store}) : _store = store;

  @override
  Future<JwtModel> fetchJwt(DadosLogin dadosLogin) {
    if (dadosLogin.email == 'felipebrostolinribeiro@gmail.com' &&
        dadosLogin.senha == '123456') {
      return Future.delayed(
        const Duration(milliseconds: 200),
        () => JwtModel(access_token: 'aa', refresh_token: 'a'),
      );
    }
    throw Exception('Rapaiz');
  }

  @override
  Future<JwtModel?> getJwtFromLocalStorage() async {
    final jsonStored = await _store.getMap('token');
    if (jsonStored != null) {
      return JwtModel.fromJson(jsonStored);
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
    _store.saveMap(key, jwt.toJson());
  }

  @override
  Future<String> getCurrentUserId() {
    // TODO: implement getCurrentUserId
    throw UnimplementedError();
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
    try {
      final response =
          await _dio.post('/auth/login', data: dadosLogin.toJson());
      return JwtModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<JwtModel?> getJwtFromLocalStorage() async {
    final jsonStored = await _store.getMap('token');
    if (jsonStored != null) {
      final jwt = JwtModel.fromJson(jsonStored);
      return jwt;
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

  @override
  Future<String> getCurrentUserId() async {
    final json = await _store.getMap('token');
    final jwtModel = JwtModel.fromJson(json!);
    final payloadMap = JwtDecoder.decode(jwtModel.access_token);

    return payloadMap['sub'] as String;
  }
}
