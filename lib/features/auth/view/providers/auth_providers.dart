import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scheduler/core/core.dart';
import 'package:scheduler/features/auth/auth.dart';

final jwtDatasourceProvider = Provider((ref) async {
  final dio = ref.read(dioProvider);
  final store = ref.read(storeProvider);
  return JwtDatasourceImpl(store: await store, dio: await dio);
});

final loginRepoProvider = Provider((ref) async {
  final JwtDatasource jwtDatasource = await ref.read(jwtDatasourceProvider);
  return LoginRepoImpl(jwtDatasource: jwtDatasource);
});
