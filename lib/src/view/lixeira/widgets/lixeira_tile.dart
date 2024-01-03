import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/src/model/lixeira_list.dart';
import 'package:todo_list/src/view/tarefa/dialogs/delete_tarefa_dialog/delete_tarefa_dialog.dart';

import '../../../model/tarefa.dart';
import '../../tarefa/dialogs/tarefa_form_dialog.dart';

class LixeiraTile extends StatelessWidget {
  const LixeiraTile({super.key});

  @override
  Widget build(BuildContext context) {
    final tarefa = Provider.of<Tarefa>(context);
    final msg = ScaffoldMessenger.of(context);
    final date = tarefa.expiryDate;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 2,
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        elevation: 2,
        child: ListTile(
          onTap: () async => await showDialog(
            context: context,
            builder: (context) => TarefaFormDialog(tarefa),
          ),
          title: FittedBox(fit: BoxFit.scaleDown, child: Text(tarefa.title)),
          subtitle: Row(
            children: [
              const Icon(
                Icons.auto_delete_outlined,
                size: 12,
              ),
              Text(
                "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year} - ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}",
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
          leading: Icon(
            Icons.delete_sweep_outlined,
            color: Colors.grey.shade800,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () async {
                  await Provider.of<LixeiraList>(context, listen: false)
                      .removerTarefaLixeira(tarefa);
                  msg.clearSnackBars();
                  msg.showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Tarefa removida da Lixeira",
                      ),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.restore_from_trash_outlined,
                  color: Colors.lightGreen,
                ),
              ),
              IconButton(
                onPressed: () async {
                  await showDialog(
                    context: context,
                    builder: (context) => DeleteTarefaDialog(tarefa: tarefa),
                  );
                },
                icon: Icon(
                  Icons.delete_forever_outlined,
                  color: ColorScheme.fromSwatch().error,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
