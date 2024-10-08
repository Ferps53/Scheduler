import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:scheduler/core/core.dart';
import 'package:scheduler/features/auth/auth.dart';
import 'package:scheduler/features/auth/data/model/user_model.dart';
import 'package:scheduler/features/auth/data/model/user_sign_in_model.dart';

class LoginRepositoryImpl implements LoginRepository {
  final AuthDatasource _authDatasource;
  final StatusUsuarioProvider _statusUsuarioProvider;

  LoginRepositoryImpl({
    required AuthDatasource jwtDatasource,
    required statusUsuarioProvider,
  })  : _authDatasource = jwtDatasource,
        _statusUsuarioProvider = statusUsuarioProvider;

  @override
  Future<StatusLogin> autoLogin() async {
    JwtModel? jwtModel = await _authDatasource.getJwtFromLocalStorage();
    return _jwtToStatus(jwtModel);
  }

  @override
  Future<void> deslogar() async {
    await _authDatasource.removeJwt();
    _statusUsuarioProvider.statusUsuario = StatusLogin.deslogado;
  }

  @override
  Future<StatusLogin> login(LoginData dadosLogin) async {
    final JwtModel jwtModel = await _authDatasource.fetchJwt(dadosLogin);
    _authDatasource.saveJwt(jwtModel, 'token');
    return _jwtToStatus(jwtModel);
  }

  StatusLogin _jwtToStatus(JwtModel? jwtModel) {
    if (jwtModel != null) {
      final Map<String, dynamic> tokenPayload =
          JwtDecoder.decode(jwtModel.accessToken);
      if (tokenPayload.isNotEmpty) {
        return StatusLogin.logado;
      }
    }
    return StatusLogin.deslogado;
  }

  @override
  Future<UserModel> signIn(LoginData dadosLogin) async {
    final userSignIn = UserSignInModel.fromLoginData(dadosLogin);
    return await _authDatasource.signInUser(userSignIn);
  }

  @override
  Future<void> confirmEmail(String code, String email) async {
    await _authDatasource.confirmEmail(email, code);
  }

  @override
  Future<void> resendEmail(String email) async {
    await _authDatasource.resendEmail(email);
  }
}
