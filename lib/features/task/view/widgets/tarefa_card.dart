import 'package:scheduler/core/core.dart';
import 'package:scheduler/features/task/domain/entities/entities.dart';
import 'package:scheduler/features/task/view/providers/task_provider.dart';
import 'package:scheduler/features/task/view/widgets/create_task_dialog.dart';

class TarefaCard extends ConsumerWidget {
  const TarefaCard({super.key, required this.task});
  final TaskEntity task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        child: ListTile(
          onLongPress: () async {
            await showDialog(
                context: context, builder: (context) => TaskFullscreenDialog());
          },
          title: Text(task.title),
          subtitle: Text('${task.description} - ${task.createdAt.toString()}'),
          trailing: Checkbox(
              value: task.isConcluded,
              onChanged: (value) {
                ref.read(taskProvider.notifier).toggleStatus(task.id!);
              }),
        ),
      ),
    );
  }
}
