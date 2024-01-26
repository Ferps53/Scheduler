import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/src/model/auth.dart';
import 'package:todo_list/src/utils/backend_root.dart';
import 'package:todo_list/src/utils/http_utils/http_defaults.dart';
import 'package:todo_list/src/utils/http_utils/http_methods_enum.dart';

final tokenProvider = FutureProvider((ref) async {
  final asyncToken = ref.read(authProvider);
  return switch (asyncToken) {
    AsyncData<Auth>(:final value) => value.token,
    AsyncError(:final error) => throw Exception(error),
    AsyncValue<Auth>() => throw UnimplementedError(),
  };
});

final authProvider = AsyncNotifierProvider<AuthNotifier, Auth>(() {
  return AuthNotifier();
});

class AuthNotifier extends AsyncNotifier<Auth> {
  @override
  Auth build() {
    throw UnimplementedError();
  }

  Future<Auth> authenticate(
      String username, String password, String email) async {
    final json = await HttpDefaults.gerarChamadaHttpPadrao(
        rootPath: BackendRoot.path,
        endpoints: "auth/login",
        headers: HttpDefaults.gerarHeaderPadrao(),
        httpMethod: HttpMethods.post,
        body: {
          "nomeDoUsuario": username,
          "senha": password,
          "email": email,
        });
    return Auth.fromJson(json as Map<String, dynamic>);
  }
}
