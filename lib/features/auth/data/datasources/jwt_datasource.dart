import '../model/jwt_model.dart';

abstract class JwtDatasource {
  
    Future<JwtModel> login();

    Future<JwtModel> autoLogin();

    void signOut();

}
