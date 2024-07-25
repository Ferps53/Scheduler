import 'package:scheduler/core/core.dart';
import 'package:scheduler/features/auth/auth.dart';

final authDatasourceProvider = Provider((ref) {
  final dio = ref.read(dioAuthProvider);
  final store = ref.read(storeProvider);
  return AuthDatasourceImpl(store: store, dio: dio);
});

final loginRepoProvider = Provider(
  (ref) {
    final AuthDatasourceImpl authDatasource = ref.read(authDatasourceProvider);
    final StatusUsuarioProvider statusUsuario = ref.read(statusUsuarioProvider);
    return LoginRepoImpl(
      jwtDatasource: authDatasource,
      statusUsuarioProvider: statusUsuario,
    );
  },
);
