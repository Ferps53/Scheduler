enum NamedRoutes {
  home(routeName: 'home', routePath: '/home'),
  login(routeName: 'login', routePath: '/start'),
  forgotPassword(
      routeName: 'forgotPassword', routePath: '/start/forgot-password'),
  createAccount(routeName: 'createAccount', routePath: '/start/create-account'),
  confirmEmail(routeName: 'confirmEmail', routePath: '/start/confirm-email'),
  tasks(routeName: 'tasks', routePath: '/tasks');

  final String routeName;
  final String routePath;

  const NamedRoutes({
    required this.routeName,
    required this.routePath,
  });
}
