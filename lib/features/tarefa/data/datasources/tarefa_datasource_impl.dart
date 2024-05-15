import 'package:dio/dio.dart';
import 'package:scheduler/features/tarefa/data/datasources/datasource.dart';
import 'package:scheduler/features/tarefa/data/model/tarefa_model.dart';

class TarefaDatasourceImpl implements TarefaDatasource {
  final Dio _dio;

  TarefaDatasourceImpl(this._dio);

  @override
  Future<void> deleteTarefa(int id) async {
    await _dio.delete('/tarefa/$id');
  }

  @override
  Future<TarefaModel> getTarefaById(int id) async {
    final response = await _dio.get<Map<String, Object?>>('/tarefa/$id');

    return TarefaModel.fromJson(response.data!);
  }

  @override
  Future<List<TarefaModel>> getTarefas() async {
    final response = await _dio.get<List<Map<String, Object?>>>('/tarefa');

    List<TarefaModel> listTarefas = [];
    if (response.data != null) {
      for (var tarefa in response.data!) {
        listTarefas.add(TarefaModel.fromJson(tarefa));
      }
    }
    return listTarefas;
  }

  @override
  Future<TarefaModel> toggleConcluded(int id) {
    // TODO: implement toggleConcluded
    throw UnimplementedError();
  }

  @override
  Future<TarefaModel> updateTarefa(int id) {
    // TODO: implement updateTarefa
    throw UnimplementedError();
  }
}
