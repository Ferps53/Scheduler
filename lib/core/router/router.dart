import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:scheduler/core/router/name_routes_notifier.dart';
import 'package:scheduler/features/auth/auth.dart';
import 'package:scheduler/features/tarefa/view/pages/tarefa_page.dart';

import 'named_routes.dart';

export 'named_routes.dart';

final goRouterProvider = Provider(
  (ref) {
    final statusUsuarioNotifier = ref.read(statusUsuarioProvider);
    return GoRouter(
      initialLocation: "/",
      refreshListenable: statusUsuarioNotifier,
      redirect: (ctx, state) async {
        final loginRepo = await ref.read(loginRepoProvider);
        final statusLogin = loginRepo.autoLogin();

        if (statusUsuarioNotifier.statusUsuario != statusLogin) {
          statusUsuarioNotifier.statusUsuario = statusLogin;
        }

        final indoParaLogin = state.fullPath == NamedRoutes.login.routePath;
        if (indoParaLogin) {
          switch (statusUsuarioNotifier.statusUsuario) {
            case StatusLogin.deslogado:
              return NamedRoutes.login.routePath;
            case StatusLogin.logado:
              return NamedRoutes.tarefas.routePath;
          }
        }
        return null;
      },
      routes: [
        GoRoute(
          path: NamedRoutes.home.routePath,
          name: NamedRoutes.home.routeName,
          pageBuilder: (ctx, state) {
            return const MaterialPage(child: HomePage());
          },
        ),
        GoRoute(
          path: NamedRoutes.login.routePath,
          name: NamedRoutes.login.routeName,
          pageBuilder: (ctx, state) => const MaterialPage(child: LoginPage()),
        ),
        GoRoute(
          path: NamedRoutes.tarefas.routePath,
          name: NamedRoutes.tarefas.routeName,
          pageBuilder: (ctx, state) => const MaterialPage(child: TarefaPage()),
        ),
        GoRoute(
          path: NamedRoutes.createAccount.routePath,
          name: NamedRoutes.createAccount.routeName,
          pageBuilder: (ctx, state) => CustomTransitionPage(
            child: const CreateAccountPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    SlideTransition(
              position: animation.drive(
                Tween<Offset>(
                  begin: const Offset(-1, 0),
                  end: Offset.zero,
                ).chain(
                  CurveTween(
                    curve: Curves.easeInOut,
                  ),
                ),
              ),
              child: child,
            ),
          ),
        ),
        GoRoute(
          path: NamedRoutes.forgotPassword.routePath,
          name: NamedRoutes.forgotPassword.routeName,
          pageBuilder: (ctx, state) => CustomTransitionPage(
            child: const ForgotPasswordPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    SlideTransition(
              position: animation.drive(
                Tween<Offset>(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ).chain(
                  CurveTween(
                    curve: Curves.easeInOut,
                  ),
                ),
              ),
              child: child,
            ),
          ),
        )
      ],
    );
  },
);
