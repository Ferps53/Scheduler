import 'package:flutter_animate/flutter_animate.dart';
import 'package:scheduler/core/core.dart';
import 'package:scheduler/features/task/domain/entities/task_entity.dart';
import 'package:scheduler/features/task/task.dart';
import 'package:scheduler/features/task/view/providers/task_provider.dart';
import 'package:scheduler/features/task/view/widgets/create_task_dialog.dart';

import '../widgets/loading_indicator.dart';

class TarefaPage extends ConsumerWidget {
  const TarefaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskList = ref.watch(taskProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adicionar uma nova tarefa',
        onPressed: () async {
          await showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            barrierColor: Colors.transparent,
            builder: (context) {
              return const CreateTaskBottomModal();
            },
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      appBar: const SchedulerAppbar(
        title: 'Tarefas',
      ),
      body: switch (taskList) {
        AsyncData(:final value) => _Content(value: value),
        AsyncError(:final error) => Text(error.toString()),
        _ => const LoadingIndicator(),
      },
    );
  }
}

class _Content extends ConsumerWidget {
  const _Content({
    required this.value,
  });

  final List<TaskEntity>? value;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () => ref.refresh(taskProvider.future),
      child: value!.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(
                  child: Text(
                    'Sem tarefas por aqui',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GlassTextButton(
                    onPressed: () => ref.refresh(taskProvider.future),
                    buttonLabel: 'Recarregar',
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemCount: value!.length,
              itemBuilder: (context, index) {
                return TarefaCard(task: value![index]).animate().move(
                      duration: 200.ms,
                      begin: const Offset(0, 600),
                      end: const Offset(0, 0),
                      delay: Duration(milliseconds: 100 * index),
                    );
              },
            ),
    );
  }
}
