import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scheduler/core/core.dart';
import 'package:scheduler/features/auth/auth.dart';

final jwtDatasourceProvider = Provider((ref) {
  final dio = ref.read(dioProvider);
  final store = ref.read(storeProvider);
  return JwtDatasourceImpl(store: store, dio: dio);
});

final loginRepoProvider = Provider(
  (ref) {
    final JwtDatasourceImpl jwtDatasource = ref.read(jwtDatasourceProvider);
    final StatusUsuarioProvider statusUsuario = ref.read(statusUsuarioProvider);
    return LoginRepoImpl(
      jwtDatasource: jwtDatasource,
      statusUsuarioProvider: statusUsuario,
    );
  },
);
