import 'package:scheduler/core/core.dart';
import 'package:scheduler/features/task/domain/entities/entities.dart';
import 'package:scheduler/features/task/view/providers/task_provider.dart';
import 'package:scheduler/features/task/view/widgets/create_task_dialog.dart';

class TarefaCard extends ConsumerWidget {
  TarefaCard({super.key, required this.task});
  final TaskEntity task;
  final _key = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      onDismissed: (_) => ref.read(taskProvider.notifier).deleteTask(task.id!),
      background: Container(
        color: context.colorScheme.error,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(
              size: 32,
              Icons.delete,
              color: context.colorScheme.onError,
            ),
          ),
        ),
      ),
      key: _key,
      direction: DismissDirection.endToStart,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Card(
          child: ListTile(
            onLongPress: () async {
              await showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                barrierColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                builder: (context) => CreateTaskBottomModal(
                  task: task,
                ),
              );
            },
            title: Text('Cód: ${task.id} - ${task.title}'),
            subtitle:
                Text('${task.description} - ${task.expiresIn.toString()}'),
            trailing: Checkbox(
              value: task.isConcluded,
              onChanged: (value) async {
                await ref.read(taskProvider.notifier).toggleStatus(task.id!);
              },
            ),
          ),
        ),
      ),
    );
  }
}
