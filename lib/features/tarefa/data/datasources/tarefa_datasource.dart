import 'package:scheduler/features/tarefa/data/data.dart';

abstract class TarefaDatasource {
  Future<TarefaModel> getTarefaById(int id);

  Future<List<TarefaModel>> getTarefas();

  Future<TarefaModel> updateTarefa(TarefaModel tarefaModel);

  Future<void> deleteTarefa(int id);

  Future<TarefaModel> toggleConcluded(int id, bool? concludedStatus);
}
