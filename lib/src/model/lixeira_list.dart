import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:todo_list/src/model/tarefa.dart';

import '../utils/backend_root.dart';
import '../utils/http_utils/http_defaults.dart';
import '../utils/http_utils/http_methods_enum.dart';

class LixeiraList with ChangeNotifier {
  final String _token;
  final List<Tarefa> _tarefas = [];

  LixeiraList(tarefas, this._token);

  List<Tarefa> get tarefas {
    return [..._tarefas];
  }

  int get quantidadeTarefas {
    return _tarefas.length;
  }

  Future<void> addTarefaToLixeira(Tarefa tarefa) async {
    _tarefas.add(tarefa);
    notifyListeners();
  }

  Future<void> loadTarefas() async {
    _tarefas.clear();

    final response = await HttpDefaults.gerarChamadaHttpPadrao(
        rootPath: BackendRoot.path,
        endpoints: "/tarefa/lixeira",
        headers: HttpDefaults.gerarHeaderPadrao(token: _token),
        httpMethod: HttpMethods.get);

    if (jsonDecode(response.body) == null) {
      notifyListeners();
      return;
    }
    var data = jsonDecode(response.body);

    data.forEach((tarefaData) {
      _tarefas.add(Tarefa(
        id: tarefaData['id'],
        title: tarefaData["titulo"],
        description: tarefaData["descricao"],
        createdAt: DateTime.parse(tarefaData["dataCriacao"]),
        expiryDate: DateTime.parse(tarefaData["dataExpiracao"]),
        isConcluded: tarefaData["fgConcluida"] ?? false,
      ));
    });

    notifyListeners();
  }
}
