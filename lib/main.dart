import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scheduler/core/core.dart';

void main() {
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
      title: "Scheduler",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.compact,
        fontFamily: 'Ubuntu',
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Ubuntu',
              bodyColor: AppColors.infoColors.textColor,
              displayColor: AppColors.infoColors.textColor,
            ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.infoColors.baseColor,
          primary: AppColors.infoColors.primaryColor,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xffdfdfdf),
        appBarTheme: AppBarTheme(
          foregroundColor: Colors.white,
          backgroundColor: AppColors.infoColors.baseColor,
        ),
      ),
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
