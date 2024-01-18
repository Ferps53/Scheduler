import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/firebase_options.dart';
import 'package:todo_list/src/model/auth.dart';
import 'package:todo_list/src/model/lixeira_list.dart';
import 'package:todo_list/src/model/tarefa_list.dart';
import 'package:todo_list/src/styles/app_colors.dart';
import 'package:todo_list/src/utils/router.dart';
import 'package:todo_list/src/view/auth/screen/auth_home.dart';
import 'package:todo_list/src/view/configuracao/screen/config_screen.dart';
import 'package:todo_list/src/view/info/screen/info_screen.dart';
import 'package:todo_list/src/view/lixeira/screen/lixeira_screen.dart';
import 'package:todo_list/src/view/tarefa/screen/tarefa_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    print(e);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, TarefaList>(
          create: (_) => TarefaList(
            [],
            '',
          ),
          update: (context, auth, previous) {
            return TarefaList(
              previous?.tarefas ?? [],
              auth.token ?? '',
            );
          },
        ),
        ChangeNotifierProxyProvider<Auth, LixeiraList>(
          create: (_) => LixeiraList(
            [],
            '',
          ),
          update: (context, auth, previous) {
            return LixeiraList(
              previous?.tarefas ?? [],
              auth.token ?? '',
            );
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo List',
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'), // English
          Locale('pt'), // Spanish
        ],
        theme: ThemeData(
          fontFamily: 'Ubuntu', // <-- 1
          textTheme: Theme.of(context).textTheme.apply(
                fontFamily: 'Ubuntu',
                bodyColor: AppColors.textColor,
                displayColor: AppColors.textColor,
              ),
          colorScheme: ColorScheme.fromSeed(
            primary: const Color(
              0xfe0379C4,
            ),
            seedColor: const Color(
              0xff03A9F4,
            ),
          ),
          useMaterial3: true,
          datePickerTheme: const DatePickerThemeData(elevation: 0),
          timePickerTheme: const TimePickerThemeData(elevation: 0),
        ),
        routes: {
          AppRouter.auth: (context) => const AuthOrHome(),
          AppRouter.tarefas: (context) => const TarefaScreen(),
          AppRouter.info: (context) => const InfoScreen(),
          AppRouter.config: (context) => const ConfigScreen(),
          AppRouter.lixeira: (context) => const LixeiraScreen(),
        },
      ),
    );
  }
}
