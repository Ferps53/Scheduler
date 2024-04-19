enum NamedRoutes {
  home(routeName: "home", routePath: "/"),
  login(routeName: 'login', routePath: '/login'),
  tarefas(routeName: 'tarefas', routePath: '/tarefas');

  final String routeName;
  final String routePath;

  const NamedRoutes({
    required this.routeName,
    required this.routePath,
  });
}
