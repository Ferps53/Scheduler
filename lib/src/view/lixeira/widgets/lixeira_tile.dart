import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          title: Text(tarefa.title),
          subtitle: Row(
            children: [
              const Icon(Icons.delete_outline),
              Text(
                "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year} - ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}",
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
          leading: Icon(
            Icons.delete_forever_outlined,
            color: ColorScheme.fromSwatch().error,
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.restore_from_trash_outlined,
              color: Colors.lightGreen,
            ),
          ),
        ),
      ),
    );
  }
}
