import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_list/src/model/tarefa.dart';
import 'package:todo_list/src/utils/backend_root.dart';
import 'package:todo_list/src/utils/http_exception.dart';

class TarefaList with ChangeNotifier {
  final String _token;
  final List<Tarefa> _tarefas = [];

  List<Tarefa> get tarefas {
    return [..._tarefas];
  }

  int get quantidadeTarefas {
    return _tarefas.length;
  }

  List<Tarefa> get tarefasConcluidas {
    return _tarefas.where((tarefa) => tarefa.isConcluded ?? false).toList();
  }

  TarefaList(tarefas, this._token);

  Future<void> loadTarefas() async {
    _tarefas.clear();

    final response = await http.get(Uri.parse("${BackendRoot.path}/tarefa"),
        headers: {'Authorization': 'Bearer $_token'});
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
        isConcluded: tarefaData["fgConcluida"] as bool?,
      ));
    });
    notifyListeners();
  }

  Future<void> addTarefa(Tarefa tarefa) async {
    final response = await http.post(
      Uri.parse("${BackendRoot.path}/tarefa"),
      headers: {
        'Authorization': 'Bearer $_token',
        'Content-Type': 'application/json'
      },
      body: jsonEncode({
        "titulo": tarefa.title,
        "descricao": tarefa.description,
        "dataExpiracao": tarefa.expiryDate.toIso8601String()
      }),
    );

    print(response.statusCode);
    print(response.body);

    final id = jsonDecode(response.body)['id'];

    _tarefas.add(Tarefa(
      id: id,
      title: tarefa.title,
      description: tarefa.description,
      createdAt: tarefa.createdAt,
      expiryDate: tarefa.expiryDate,
      isConcluded: false,
    ));

    notifyListeners();
  }

  Future<void> updateTarefa(Tarefa tarefa) async {
    int index = _tarefas.indexWhere(
      (element) => element.id == tarefa.id,
    );

    print("Onde vai: ${BackendRoot.path}/tarefa/${tarefa.id}");
    if (index > 0) {
      var response = await http.put(
        Uri.parse("${BackendRoot.path}/tarefa/${tarefa.id}"),
        headers: {
          'Authorization': 'Bearer $_token',
          "Content-Type": "application/json"
        },
        body: jsonEncode({
          'id': tarefa.id,
          'titulo': tarefa.title,
          'descricao': tarefa.description,
          'dataExpiracao': tarefa.expiryDate.toIso8601String(),
        }),
      );
    }
    _tarefas[index] = tarefa;

    notifyListeners();
  }

  Future<void> removeTarefa(Tarefa tarefa) async {
    int index = _tarefas.indexWhere(
      (element) => element.id == tarefa.id,
    );

    if (index >= 0) {
      final tarefa = _tarefas[index];

      _tarefas.remove(tarefa);
      notifyListeners();

      final response = await http.delete(
        Uri.parse("${BackendRoot.path}/tarefa/${tarefa.id}"),
        headers: {'Authorization': 'Bearer $_token'},
      );

      print(response.statusCode);

      if (response.statusCode >= 400) {
        _tarefas.insert(index, tarefa);
        notifyListeners();
        throw HttpException(
          msg: "Não foi possivel excluir a tarefa ;(",
          statusCode: response.statusCode,
        );
      }
    }
  }

  Future<void> saveTarefa(Map<String, Object> data) {
    bool hasId = data['id'] != null;
    DateTime date = DateTime.now();

    final tarefa = Tarefa(
      id: hasId ? data['id'] as int : 1,
      title: data['title'] as String,
      description: data['description'] as String,
      createdAt: date,
      expiryDate: DateTime.parse(data['expiryDate'] as String),
    );

    if (hasId) {
      return updateTarefa(tarefa);
    } else {
      return addTarefa(tarefa);
    }
  }
}
