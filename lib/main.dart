import 'package:flutter/material.dart';
import 'package:scheduler/core/database/database.dart';
import 'package:scheduler/core/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = await DatabaseProvider().database;

  print(db);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scheduler',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
      ),
      home: const HomeScreen(),
    );
  }
}
