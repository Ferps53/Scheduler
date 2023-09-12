import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/src/model/auth.dart';
import 'package:todo_list/src/model/tarefa_list.dart';
import 'package:todo_list/src/screen/tarefa_from_screen.dart';

void main() {
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
          title: 'Todo List',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
            primarySwatch: Colors.blue,
            useMaterial3: true,
            datePickerTheme: const DatePickerThemeData(elevation: 0),
            timePickerTheme: const TimePickerThemeData(elevation: 0),
          ),
          home: const TarefaFormScreen()),
    );
  }
}
