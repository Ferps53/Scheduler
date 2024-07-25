enum NamedRoutes {
  home(routeName: 'home', routePath: '/home'),
  login(routeName: 'login', routePath: '/start'),
  forgotPassword(
      routeName: 'forgotPassword', routePath: '/start/forgot-password'),
  createAccount(routeName: 'createAccount', routePath: '/start/create-account'),
  confirmEmail(routeName: 'confirmEmail', routePath: 'start/confirm-email'),
  tarefas(routeName: 'tarefas', routePath: '/tarefas');

  final String routeName;
  final String routePath;

  const NamedRoutes({
    required this.routeName,
    required this.routePath,
  });
}
