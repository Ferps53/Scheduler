import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/features/auth/domain/entities/entities.dart';
import 'package:todo_list/features/auth/view/providers/auth_providers.dart';

class LoginAsyncNotifier extends AutoDisposeAsyncNotifier<StatusUsuario> {
  @override
  Future<StatusUsuario> build() async {
    final loginRepo = await ref.read(loginRepoProvider);
    return loginRepo.autoLogin();
  }

  void login(DadosLogin dadosLogin) async {
    state = const AsyncLoading();
    final loginRepo = await ref.read(loginRepoProvider);
    state = await AsyncValue.guard(
      () async => await loginRepo.login(dadosLogin),
    );
  }
}
