import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/firebase_options.dart';
import 'package:todo_list/src/api/firebase/firebase_messaging.dart';
import 'package:todo_list/src/model/auth.dart';
import 'package:todo_list/src/model/tarefa_list.dart';
import 'package:todo_list/src/view/screen/auth_home.dart';
import 'package:todo_list/src/view/screen/tarefas.dart';
import 'package:todo_list/src/utils/router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try{
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await FirebaseMessagingApi().iniciarNotificacoes();
  }catch(e){
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
          create: (_) => TarefaList([], '', ''),
          update: (context, auth, previous) {
            return TarefaList(
              previous?.tarefas ?? [],
              auth.token ?? '',
              auth.uid ?? '',
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
          AppRouter.AUTH: (context) => const AuthOrHome(),
          AppRouter.TAREFAS: (context) => const TarefaScreen(),
        },
      ),
    );
  }
}
