import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  Future<void> removerTarefaLixeira(Tarefa tarefa) async {
    _tarefas.remove(tarefa);
    notifyListeners();

    var data = {"fgLixeira": false, "dataEnvioLixeira": null};

    var response = await HttpDefaults.gerarChamadaHttpPadrao(
        rootPath: BackendRoot.path,
        endpoints: "/tarefa/${tarefa.id}/atualizarStatusLixeira",
        headers: HttpDefaults.gerarHeaderPadrao(token: _token),
        httpMethod: HttpMethods.put,
        body: data);

    if (response.statusCode >= 400) {
      _tarefas.add(tarefa);
      notifyListeners();
      throw HttpException(
          "Não foi possível remover tarefa da lixeira : ${response.statusCode}");
    }
  }

  Future<void> removerTarefaDefinitivamente(Tarefa tarefa) async {
    _tarefas.remove(tarefa);
    notifyListeners();

    var response = await HttpDefaults.gerarChamadaHttpPadrao(
        rootPath: BackendRoot.path,
        endpoints: "tarefa/${tarefa.id}",
        headers: HttpDefaults.gerarHeaderPadrao(
          token: _token,
        ),
        httpMethod: HttpMethods.delete);
    if (response.statusCode >= 400) {
      _tarefas.add(tarefa);
      notifyListeners();
      throw HttpException(
          "Não foi possível remover tarefa da lixeira : ${response.statusCode}");
    }
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
    try {
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
    } catch (error) {
      loadTarefas();
      notifyListeners();
    }
  }
}
