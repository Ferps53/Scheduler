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

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({'Content-Type': 'application/json'});
    final JwtModel? jwtModel = JwtDatasourceImpl(
      store: _store,
      dio: Dio(),
    ).getJwtFromLocalStorage();
    if (jwtModel != null) {
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
