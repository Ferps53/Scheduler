import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:scheduler/core/core.dart';
import 'package:scheduler/features/auth/auth.dart';

final loginAsyncNotifierProvider =
    AsyncNotifierProvider.autoDispose<LoginAsyncNotifier, StatusLogin>(() {
  return LoginAsyncNotifier();
});

class LoginAsyncNotifier extends AutoDisposeAsyncNotifier<StatusLogin> {
  @override
  Future<StatusLogin> build() async {
    final loginRepo = ref.read(loginRepoProvider);
    return loginRepo.autoLogin();
  }

  void login(DadosLogin dadosLogin, BuildContext context) async {
    state = const AsyncLoading();
    final loginRepo = ref.read(loginRepoProvider);
    state = await AsyncValue.guard(
      () async => await loginRepo.login(dadosLogin),
    );
    if (state.value == StatusLogin.logado) {
      if (context.mounted) {
        context.goNamed(NamedRoutes.tarefas.routeName);
      }
    } else {
      if (context.mounted) {
        context.showSnackBar(
          'Falha no Login',
        );
      }
    }
  }
}
