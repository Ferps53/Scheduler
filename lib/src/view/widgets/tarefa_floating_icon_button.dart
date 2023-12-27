import 'package:flutter/material.dart';

import '../dialogs/tarefa_form_dialog.dart';

class TarefaFloatingActionButton extends StatelessWidget {
  const TarefaFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
      backgroundColor: Colors.lightGreen,
      onPressed: () async => await showDialog(
        context: context,
        builder: (context) => const TarefaFormDialog(null),
      ),
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
