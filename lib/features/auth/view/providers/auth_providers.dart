import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/core/dio/dio_provider.dart';
import 'package:todo_list/core/store/store.dart';
import 'package:todo_list/features/auth/data/datasources/datasources.dart';
import 'package:todo_list/features/auth/data/repo/login_repo_impl.dart';

final jwtDatasourceProvider = Provider((ref) async {
  final dio = ref.read(dioProvider);
  final store = ref.read(storeProvider);
  return JwtDatasourceImpl(store: await store, dio: dio);
});

final loginRepoProvider = Provider((ref) async {
  final JwtDatasource jwtDatasource = await ref.read(jwtDatasourceProvider);
  return LoginRepoImpl(jwtDatasource: jwtDatasource);
});

