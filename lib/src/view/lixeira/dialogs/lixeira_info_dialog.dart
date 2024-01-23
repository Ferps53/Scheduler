import 'package:flutter/material.dart';
import 'package:todo_list/src/view/default_widgets/glass_alert_dialog.dart';

class LixeiraInfoDialog extends StatelessWidget {
  const LixeiraInfoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassAlertDialog.info(
      height: 250,
      headerLabel: "Sobre a Lixeira",
      textContent:
          "Tarefas duram 15 dias na lixeira antes de serem excluídas pernamentemente",
      firstButtonText: "Fechar",
      firstButtonAction: () => Navigator.of(context).pop(),
    );
  }
}
