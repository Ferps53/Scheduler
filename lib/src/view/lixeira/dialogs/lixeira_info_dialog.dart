import 'package:flutter/material.dart';
import 'package:todo_list/src/view/default_widgets/default_dialog.dart';

class LixeiraInfoDialog extends StatelessWidget {
  const LixeiraInfoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultDialog(
      headerLabel: "Sobre a Lixeira",
      content: const Text(
          "Tarefas duram 15 dias na lixeira antes de serem excluídas pernamentemente"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Fechar"),
        )
      ],
    );
  }
}
