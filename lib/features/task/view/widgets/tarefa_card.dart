import 'package:flutter/material.dart';
import 'package:scheduler/features/task/domain/entities/entities.dart';
import 'package:scheduler/features/task/view/widgets/create_task_dialog.dart';

class TarefaCard extends StatelessWidget {
  const TarefaCard({super.key, required this.task});
  final TaskEntity task;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        child: ListTile(
          onLongPress: () async {
            await showDialog(
                context: context,
                builder: (context) => const TaskFullscreenDialog());
          },
          title: Text(task.title),
          subtitle: Text('${task.description} - ${task.createdAt.toString()}'),
        ),
      ),
    );
  }
}
