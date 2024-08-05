import 'package:flutter_animate/flutter_animate.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:scheduler/core/core.dart';
import 'package:scheduler/features/task/task.dart';
import 'package:scheduler/features/task/view/providers/task_provider.dart';
import 'package:scheduler/features/task/view/widgets/create_task_dialog.dart';

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
      body: taskList.when(
        data: (data) {
          return data.isEmpty
              ? const Center(
                  child: Text('Sem tarefas por aqui'),
                )
              : ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return TarefaCard(task: data[index]).animate().move(
                          duration: 200.ms,
                          begin: const Offset(0, 400),
                          end: const Offset(0, 0),
                          delay: Duration(milliseconds: 100 * index),
                        );
                  },
                );
        },
        error: (error, __) {
          return Text(error.toString());
        },
        loading: () {
          return Center(
            child: GlassCard(
              width: 100,
              height: 100,
              child: Transform.scale(
                scale: 0.8,
                child: LoadingAnimationWidget.inkDrop(
                  color: context.colorScheme.primary,
                  size: 80,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
