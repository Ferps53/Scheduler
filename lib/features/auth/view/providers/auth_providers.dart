import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scheduler/core/dio/dio_provider.dart';
import 'package:scheduler/core/store/store.dart';
import 'package:scheduler/features/auth/auth.dart';

final jwtDatasourceProvider = Provider((ref) async {
  final dio = ref.read(dioProvider);
  final store = ref.read(storeProvider);
  return JwtDatasourceImpl(store: await store, dio: dio);
});

final loginRepoProvider = Provider((ref) async {
  final JwtDatasource jwtDatasource = await ref.read(jwtDatasourceProvider);
  return LoginRepoImpl(jwtDatasource: jwtDatasource);
});

