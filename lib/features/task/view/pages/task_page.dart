import 'package:flutter/material.dart';
import 'package:scheduler/core/core.dart';
import 'package:scheduler/features/task/task.dart';

class TarefaPage extends StatelessWidget {
  const TarefaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: SchedulerAppbar(
        title: 'Tarefas',
      ),
      body: CalendarioMes(),
    );
  }
}
