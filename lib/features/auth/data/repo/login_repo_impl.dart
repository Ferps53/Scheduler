import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:scheduler/core/core.dart';
import 'package:scheduler/features/auth/auth.dart';

class LoginRepoImpl implements LoginRepo {
  final JwtDatasource _jwtDatasource;
  final StatusUsuarioProvider _statusUsuarioProvider;

  LoginRepoImpl({
    required JwtDatasource jwtDatasource,
    required statusUsuarioProvider,
  })  : _jwtDatasource = jwtDatasource,
        _statusUsuarioProvider = statusUsuarioProvider;

  @override
  StatusLogin autoLogin() {
    JwtModel? jwtModel = _jwtDatasource.getJwtFromLocalStorage();
    return _jwtToStatus(jwtModel);
  }

  @override
  void deslogar() {
    _jwtDatasource.removeJwt();
    _statusUsuarioProvider.statusUsuario = StatusLogin.deslogado;
  }

  @override
  Future<StatusLogin> login(DadosLogin dadosLogin) async {
    final JwtModel jwtModel = await _jwtDatasource.fetchJwt(dadosLogin);
    _jwtDatasource.saveJwt(jwtModel, 'token');
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
