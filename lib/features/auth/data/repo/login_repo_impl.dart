import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:scheduler/features/auth/auth.dart';
import 'package:scheduler/features/auth/domain/entities/status_login.dart';

class LoginRepoImpl implements LoginRepo {
  final JwtDatasource _jwtDatasource;

  LoginRepoImpl({required JwtDatasource jwtDatasource})
      : _jwtDatasource = jwtDatasource;

  @override
  StatusLogin autoLogin() {
    JwtModel? jwtModel = _jwtDatasource.getJwtFromLocalStorage('token');
    return _jwtToStatus(jwtModel);
  }

  @override
  void deslogar() {
    _jwtDatasource.removeJwt();
  }

  @override
  Future<StatusLogin> login(DadosLogin dadosLogin) async {
    final JwtModel jwtModel = await _jwtDatasource.fetchJwt(dadosLogin);
    return _jwtToStatus(jwtModel);
  }

  StatusLogin _jwtToStatus(JwtModel? jwtModel) {
    if (jwtModel != null) {
      final Map<String, dynamic> tokenPayload =
          JwtDecoder.decode(jwtModel.access_token);
      if (tokenPayload.isNotEmpty) {
        return StatusLogin.logado;
      }
    }
    return StatusLogin.deslogado;
  }
}
