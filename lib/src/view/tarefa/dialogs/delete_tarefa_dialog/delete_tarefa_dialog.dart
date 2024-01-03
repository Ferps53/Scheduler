import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../model/lixeira_list.dart';
import '../../../../model/tarefa.dart';
import '../../../default_widgets/default_dialog.dart';

class DeleteTarefaDialog extends StatelessWidget {
  final Tarefa tarefa;
  const DeleteTarefaDialog({required this.tarefa, super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultDialog(
      headerLabel: "Deletar tarefa",
      content: const Padding(
        padding: EdgeInsets.all(8),
        child: Text("Tem certeza que quer deletar esta tarefa definitvamente?"),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Provider.of<LixeiraList>(context, listen: false)
                .removerTarefaDefinitivamente(tarefa);
            Navigator.of(context).pop();
          },
          child: const Text("Deletar Definitvamente"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancelar"),
        ),
      ],
    );
  }
}
