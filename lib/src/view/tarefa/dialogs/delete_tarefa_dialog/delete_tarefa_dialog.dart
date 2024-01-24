import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/src/view/default_widgets/glass_alert_dialog.dart';

import '../../../../model/lixeira_list.dart';
import '../../../../model/tarefa.dart';

class DeleteTarefaDialog extends StatelessWidget {
  final Tarefa tarefa;
  const DeleteTarefaDialog({required this.tarefa, super.key});

  @override
  Widget build(BuildContext context) {
    return GlassAlertDialog.danger(
      height: 250,
      headerLabel: "Deletar tarefa",
      textContent: "Tem certeza que quer deletar esta tarefa definitvamente?",
      firstButtonText: "Deletar",
      firstButtonAction: () {
        Provider.of<LixeiraList>(context, listen: false)
            .removerTarefaDefinitivamente(tarefa);
        Navigator.of(context).pop();
      },
      secondButtonAction: () => Navigator.of(context).pop(),
      secondButtonText: "Cancelar",
    );
  }
}
