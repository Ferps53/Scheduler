enum NamedRoutes {
  home(routeName: "home", routePath: "/home"),
  login(routeName: 'login', routePath: '/'),
  forgotPassword(routeName: 'forgotPassword', routePath: '/forgot-password'),
  createAccount(routeName: 'createAccount', routePath: '/create-account'),
  tarefas(routeName: 'tarefas', routePath: '/tarefas');

  final String routeName;
  final String routePath;

  const NamedRoutes({
    required this.routeName,
    required this.routePath,
  });
}
