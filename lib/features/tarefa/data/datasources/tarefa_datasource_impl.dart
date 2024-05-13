import 'package:dio/dio.dart';
import 'package:scheduler/features/tarefa/data/datasources/datasource.dart';
import 'package:scheduler/features/tarefa/data/model/tarefa_model.dart';

class TarefaDatasourceImpl implements TarefaDatasource {
  final Dio _dio;

  TarefaDatasourceImpl(this._dio);

  @override
  Future<void> deleteTarefa(int id) async {
    await _dio.delete('/tarefa/{$id}');
  }

  @override
  Future<TarefaModel> getTarefaById(int id) {
    // TODO: implement getTarefaById
    throw UnimplementedError();
  }

  @override
  Future<List<TarefaModel>> getTarefas() {
    // TODO: implement getTarefas
    throw UnimplementedError();
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
