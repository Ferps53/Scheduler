import 'package:flutter/material.dart';

class TarefaPage extends StatelessWidget {
  const TarefaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarefas'),
        centerTitle: true,
      ),
      body: const Placeholder(),
    );
  }
}
