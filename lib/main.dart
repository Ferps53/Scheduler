import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:scheduler/core/core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await BackgroundTaskLoader.initializeServices();
  runApp(
    const ProviderScope(
      child: MainWidget(),
    ),
  );
}

class MainWidget extends ConsumerWidget {
  const MainWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    return MaterialApp.router(
      title: 'Scheduler',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.comfortable,
        fontFamily: 'Ubuntu',
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Ubuntu',
              bodyColor: context.colorScheme.onSurface,
              displayColor: context.colorScheme.onPrimary,
            ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.cyan,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
    );
  }
}
