import 'package:scheduler/features/features.dart';
import '../core.dart';

export 'named_routes.dart';
export 'name_routes_notifier.dart';

final goRouterProvider = Provider(
  (ref) {
    final statusUsuarioNotifier = ref.read(statusUsuarioProvider);
    return GoRouter(
      initialLocation: '/start',
      refreshListenable: statusUsuarioNotifier,
      redirect: (ctx, state) async {
        final loginRepo = ref.read(loginRepoProvider);
        final statusLogin = await loginRepo.autoLogin();

        if (statusUsuarioNotifier.statusUsuario != statusLogin) {
          statusUsuarioNotifier.statusUsuario = statusLogin;
        }

        final indoParaLogin = state.fullPath == NamedRoutes.login.routePath;
        if (indoParaLogin) {
          switch (statusUsuarioNotifier.statusUsuario) {
            case StatusLogin.deslogado:
              return NamedRoutes.login.routePath;
            case StatusLogin.logado:
              return NamedRoutes.tasks.routePath;
          }
        }
        if (!state.fullPath!.contains('start') &&
            statusUsuarioNotifier.statusUsuario == StatusLogin.deslogado) {
          return NamedRoutes.login.routePath;
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
          path: NamedRoutes.tasks.routePath,
          name: NamedRoutes.tasks.routeName,
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
          path: NamedRoutes.confirmEmail.routePath,
          name: NamedRoutes.confirmEmail.routeName,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: ConfirmEmailPage(email: state.extra as String?),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      SlideTransition(
                position: animation.drive(
                  Tween<Offset>(
                    begin: const Offset(0, 1),
                    end: Offset.zero,
                  ).chain(
                    CurveTween(
                      curve: Curves.easeInOut,
                    ),
                  ),
                ),
                child: child,
              ),
            );
          },
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
