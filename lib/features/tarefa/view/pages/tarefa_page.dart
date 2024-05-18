import 'package:flutter/material.dart';
import 'package:scheduler/features/tarefa/view/pages/calendario_mes.dart';

class TarefaPage extends StatelessWidget {
  const TarefaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text('Tarefas'),
      ),
      body: const CalendarioMes(),
    );
  }
}

