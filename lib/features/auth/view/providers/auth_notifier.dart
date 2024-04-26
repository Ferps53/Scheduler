import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/core/router/named_routes.dart';
import 'package:todo_list/features/auth/domain/entities/entities.dart';
import 'package:todo_list/features/auth/view/providers/auth_providers.dart';

final loginAsyncNotifierProvider =
    AsyncNotifierProvider.autoDispose<LoginAsyncNotifier, StatusUsuario>(() {
  return LoginAsyncNotifier();
});

class LoginAsyncNotifier extends AutoDisposeAsyncNotifier<StatusUsuario> {
  @override
  Future<StatusUsuario> build() async {
    final loginRepo = await ref.read(loginRepoProvider);
    return loginRepo.autoLogin();
  }

  void login(DadosLogin dadosLogin, BuildContext context) async {
    state = const AsyncLoading();
    final loginRepo = await ref.read(loginRepoProvider);
    state = await AsyncValue.guard(
      () async => await loginRepo.login(dadosLogin),
    );
    if (state.value == StatusUsuario.logado) {
      if (context.mounted) {
        context.goNamed(NamedRoutes.tarefas.routeName);
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Falha no login")));
      }
    }
  }
}
