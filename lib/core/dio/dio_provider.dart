import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scheduler/core/core.dart';
import 'package:scheduler/features/auth/auth.dart';

final dioProvider = Provider((ref) async {
  final Store store = await ref.read(storeProvider);
  final Dio dio = Dio(BaseOptions(baseUrl: Environments.backendRoot));
  dio.interceptors.add(DioInterceptor(store));
  return dio;
});

class DioInterceptor extends Interceptor {
  final Store _store;

  DioInterceptor(this._store);

  //TODO: Nesse método trocar o uso direto da JwtModel pela Datasource
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({'Content-Type': 'application/json'});
    final mapToken = _store.getMap('token');
    if (mapToken.isNotEmpty) {
      final JwtModel jwtModel = JwtModel.fromJson(mapToken);
      options.headers.addAll(
        {
          'Authorization': 'Bearer ${jwtModel.access_token}',
          'Refresh-Token': 'Bearer ${jwtModel.refresh_token}'
        },
      );
    }
    return super.onRequest(options, handler);
  }
}
