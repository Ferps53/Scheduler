import 'package:flutter/material.dart';
import 'package:todo_list/src/model/tarefa.dart';

class TarefaTile extends StatelessWidget {
  final Tarefa tarefa;
  const TarefaTile({super.key, required this.tarefa});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        elevation: 2,
        child: ListTile(
          leading: const Icon(Icons.edit_calendar),
          title: Text(
            tarefa.title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
