import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_list/src/model/tarefa.dart';
import 'package:todo_list/src/utils/firebase_location.dart';
import 'package:todo_list/src/utils/http_exception.dart';

class TarefaList with ChangeNotifier {
  final String _token;
  final String _uid;
  List<Tarefa> _tarefas = [];

  List<Tarefa> get tarefas {
    return [..._tarefas];
  }

  int get quantidadeTarefas {
    return _tarefas.length;
  }

  List<Tarefa> get tarefasConcluidas {
    return _tarefas.where((tarefa) => tarefa.isConcluded).toList();
  }

  TarefaList(this._tarefas, this._token, this._uid);

  Future<void> loadTarefas() async {
    _tarefas.clear();

    final response = await http.get(
      Uri.parse("${FireBaseLocation.baseUrl}/$_uid.json?auth=$_token"),
    );
    if (jsonDecode(response.body) == null) {
      notifyListeners();
      return;
    }
    Map<String, dynamic> data = jsonDecode(response.body);

    data.forEach((tarefaId, tarefaData) {
      _tarefas.add(Tarefa(
        id: tarefaId,
        title: tarefaData["title"],
        description: tarefaData["description"],
        createdAt: DateTime.parse(tarefaData["createdAt"]),
        expiryDate: DateTime.parse(tarefaData["expiryDate"]),
        isConcluded: tarefaData["isConcluded"] as bool,
      ));
    });
    notifyListeners();
  }

  Future<void> addTarefa(Tarefa tarefa) async {
    final createdAt = DateTime.now();

    final response = await http.post(
      Uri.parse("${FireBaseLocation.baseUrl}/$_uid.json?auth=$_token"),
      body: jsonEncode({
        'title': tarefa.title,
        'description': tarefa.description,
        'createdAt': createdAt.toIso8601String(),
        'expiryDate': tarefa.expiryDate.toIso8601String(),
        'isConcluded': tarefa.isConcluded,
      }),
    );

    final id = jsonDecode(response.body)['name'];
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

    if (index >= 0) {
      await http.patch(
        Uri.parse("${FireBaseLocation.baseUrl}?$_uid.json?auth=$_token"),
        body: jsonEncode({
          'title': tarefa.title,
          'description': tarefa.description,
          'createdAt': tarefa.createdAt.toIso8601String(),
          'expiryDate': tarefa.expiryDate.toIso8601String(),
        }),
      );

      _tarefas[index] = tarefa;
      notifyListeners();
    }
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
        Uri.parse(
            "${FireBaseLocation.baseUrl}/$_uid/${tarefa.id}.json?auth=$_token"),
      );

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
      id: hasId ? data['id'] as String : Random().nextDouble.toString(),
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
