import 'package:flutter/material.dart';
import 'package:todo_list/src/styles/app_colors.dart';

import '../dialogs/tarefa_form_dialog.dart';

class TarefaFloatingActionButton extends StatelessWidget {
  const TarefaFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
      backgroundColor: AppColors.infoColors.primaryColor,
      onPressed: () async => await showDialog(
        context: context,
        builder: (context) => const TarefaFormDialog(null),
      ),
      child: Icon(
        Icons.add,
        color: AppColors.infoColors.backgroundColor,
      ),
    );
  }
}
