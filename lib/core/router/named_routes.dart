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
