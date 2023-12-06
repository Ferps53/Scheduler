import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/src/model/auth.dart';
import 'package:todo_list/src/model/tarefa.dart';
import 'package:todo_list/src/model/tarefa_list.dart';

import '../dialogs/tarefa_form_dialog.dart';

class TarefaTile extends StatelessWidget {
  const TarefaTile({super.key});

  @override
  Widget build(BuildContext context) {
    final tarefa = Provider.of<Tarefa>(context);
    final msg = ScaffoldMessenger.of(context);
    final auth = Provider.of<Auth>(context);
    final date = tarefa.expiryDate;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        elevation: 2,
        child: ListTile(
          onTap: () async => await showDialog(
            context: context,
            builder: (context) => TarefaFormDialog(tarefa),
          ),
          leading: const Icon(Icons.edit_calendar),
          title: FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              children: [
                Text(
                  tarefa.title,
                  style: const TextStyle(fontSize: 20),
                ),
                Row(
                  children: [
                    Text(
                      "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year} - ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}",
                      style: const TextStyle(fontSize: 14),
                    )
                  ],
                )
              ],
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<Tarefa>(
                builder: (context, tarefa, child) => IconButton(
                  onPressed: () async {
                    try {
                      tarefa.toggleConcluded(
                        auth.token ?? '',
                        auth.uid ?? '',
                      );
                      msg.clearSnackBars();
                      msg.showSnackBar(
                        SnackBar(
                          content: Text(tarefa.isConcluded
                              ? "Tarefa marcada como concluída!!"
                              : "Tarefa desmarcada como concluída!"),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    } catch (error) {
                      msg.clearSnackBars();
                      msg.showSnackBar(
                        SnackBar(
                          content: Text(
                            error.toString(),
                          ),
                        ),
                      );
                    }
                  },
                  icon: Icon(
                    tarefa.isConcluded
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                    color: Colors.lightGreen,
                    size: 20,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Excluir Tarefa?"),
                      content: const Text("Tem certeza?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: const Text("Não"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          child: const Text("Sim"),
                        ),
                      ],
                    ),
                  ).then((value) async {
                    if (value ?? false) {
                      try {
                        await Provider.of<TarefaList>(
                          context,
                          listen: false,
                        ).removeTarefa(tarefa);
                      } catch (error) {
                        msg.showSnackBar(
                          SnackBar(
                            content: Text(
                              error.toString(),
                            ),
                          ),
                        );
                      }
                    }
                  });
                },
                icon: Icon(
                  Icons.delete,
                  color: ColorScheme.fromSwatch().error,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
