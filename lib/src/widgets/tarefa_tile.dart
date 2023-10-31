import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/src/model/auth.dart';
import 'package:todo_list/src/model/tarefa.dart';
import 'package:todo_list/src/model/tarefa_list.dart';
import 'package:todo_list/src/utils/router.dart';

class TarefaTile extends StatelessWidget {
  const TarefaTile({super.key});

  @override
  Widget build(BuildContext context) {
    final tarefa = Provider.of<Tarefa>(context);
    final msg = ScaffoldMessenger.of(context);
    final auth = Provider.of<Auth>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        elevation: 2,
        child: ListTile(
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRouter.FORM_TAREFAS,
              arguments: tarefa,
            );
          },
          leading: const Icon(Icons.edit_calendar),
          title: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              tarefa.title,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
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
                          duration: const Duration(seconds: 1),
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
                    tarefa.isConcluded ? Icons.star : Icons.star_border,
                    color: Colors.amber,
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
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
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
