import 'dart:convert';

import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:scheduler/core/core.dart';
import 'package:scheduler/features/auth/auth.dart';

final dioProvider = Provider((ref) {
  final Store store = ref.read(storeProvider);
  final Dio dio = Dio(BaseOptions(baseUrl: Environments.backendRoot));
  dio.interceptors.add(DioInterceptor(store));
  dio.interceptors.add(RetryInterceptor(dio: dio));
  return dio;
});

final dioAuthProvider = Provider((ref) {
  final dio = Dio(BaseOptions(baseUrl: Environments.backendRoot));
  dio.interceptors.add(DioAuthInterceptor());
  return dio;
});

final String _encodedBasic =
    'Basic ${base64Encode(utf8.encode('${Environments.basicUsername}:${Environments.basicPassword}'))}';

class DioAuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': _encodedBasic,
    });
    return super.onRequest(options, handler);
  }
}

class DioInterceptor extends Interceptor {
  final Store _store;

  DioInterceptor(this._store);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers.addAll({'Content-Type': 'application/json'});
    final JwtModel? jwtModel = await AuthDatasourceImpl(
      store: _store,
      dio: Dio(),
    ).getJwtFromLocalStorage();
    if (jwtModel != null) {
      options.headers.addAll(
        {
          'Authorization': 'Bearer ${jwtModel.accessToken}',
          'Refresh-Token': 'Bearer ${jwtModel.refreshToken}'
        },
      );
    }
    return super.onRequest(options, handler);
  }
}
