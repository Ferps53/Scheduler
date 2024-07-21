import 'package:flutter_animate/flutter_animate.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:scheduler/core/core.dart';
import 'package:scheduler/features/task/domain/entities/task_entity.dart';
import 'package:scheduler/features/task/task.dart';
import 'package:scheduler/features/task/view/providers/task_provider.dart';

class TarefaPage extends ConsumerWidget {
  const TarefaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskList = ref.watch(taskProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(taskProvider.notifier).createTask(
                TaskEntity(
                  id: null,
                  titulo: 'Teste',
                  descricao: 'Testoso',
                  fgConcluida: false,
                  fgLixeira: null,
                  dataEnvioLixeira: null,
                  dataCriacao: DateTime.now(),
                  dataExpiracao: null,
                  dataConclusao: null,
                ),
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
          return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return TarefaCard(task: data[index]).animate().move(
                      duration: 200.ms,
                      begin: const Offset(100, 100),
                      end: const Offset(0, 0),
                    );
              });
        },
        error: (error, __) {
          return Text(error.toString());
        },
        loading: () {
          return Center(
            child: GlassCard(
                width: 100,
                height: 100,
                child: LoadingAnimationWidget.inkDrop(
                  color: context.colorScheme.primary,
                  size: 80,
                )),
          );
        },
      ),
    );
  }
}
