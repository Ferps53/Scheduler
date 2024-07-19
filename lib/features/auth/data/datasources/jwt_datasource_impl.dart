import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:scheduler/core/core.dart';
import 'package:scheduler/features/auth/auth.dart';
import 'package:scheduler/features/auth/data/model/user_model.dart';
import 'package:scheduler/features/auth/data/model/user_sign_in_model.dart';

class JwtDatasourceImpl implements JwtDatasource {
  final Store _store;
  final Dio _dio;

  JwtDatasourceImpl({required Store store, required Dio dio})
      : _store = store,
        _dio = dio;

  @override
  Future<JwtModel> fetchJwt(DadosLogin dadosLogin) async {
    try {
      final response = await _dio.get('auth/login', queryParameters: {
        'usernameOrEmail': dadosLogin.email,
        'password': dadosLogin.senha,
      });

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
  Future<void> removeJwt() async {
    await _store.remove('token');
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

  @override
  Future<UserModel> signInUser(UserSignInModel userSignIn) async {
    print(userSignIn);

    final response = await _dio.get('auth/sign-in', queryParameters: {
      'username': userSignIn.username,
      'email': userSignIn.email,
      'password': userSignIn.password,
    });

    print(response.data);

    return UserModel.fromJson(response.data);
  }
}
