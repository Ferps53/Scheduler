import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:todo_list/features/auth/domain/repo/login_repo.dart';

import '../../auth.dart';

class LoginRepoImpl implements LoginRepo {
  final JwtDatasource _jwtDatasource;

  LoginRepoImpl({required JwtDatasource jwtDatasource})
      : _jwtDatasource = jwtDatasource;

  @override
  StatusUsuario autoLogin() {
    JwtModel? jwtModel = _jwtDatasource.getJwtFromLocalStorage('token');
    return _jwtToStatus(jwtModel);
  }

  @override
  void deslogar() {
    _jwtDatasource.removeJwt();
  }

  @override
  Future<StatusUsuario> login(DadosLogin dadosLogin) async {
    final JwtModel jwtModel = await _jwtDatasource.fetchJwt(dadosLogin);
    return _jwtToStatus(jwtModel);
  }

  StatusUsuario _jwtToStatus(JwtModel? jwtModel) {
    print(jwtModel);
    if (jwtModel != null) {
      final Map<String, dynamic> tokenPayload =
          JwtDecoder.decode(jwtModel.access_token);

      final groups = tokenPayload['groups'][0];

      return switch (groups) {
        'Usuario' => StatusUsuario.logado,
        Object() => StatusUsuario.deslogado,
        null => StatusUsuario.deslogado,
      };
    }
    return StatusUsuario.deslogado;
  }
}
