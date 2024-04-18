import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/features/auth/view/pages/home_page.dart';

enum NamedRoutes {
  home(
    routeName: "home",
    routePath: "/",
  );

  final String routeName;
  final String routePath;

  const NamedRoutes({
    required this.routeName,
    required this.routePath,
  });
}

final goRouterProvider = Provider(
  (ref) {
    return GoRouter(
      initialLocation: "/",
      routes: [
        GoRoute(
          path: NamedRoutes.home.routePath,
          name: NamedRoutes.home.routeName,
          pageBuilder: (ctx, state) {
            return const MaterialPage(child: HomePage());
          },
        ),
      ],
    );
  },
);
