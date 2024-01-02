import 'package:flutter/material.dart';
import 'package:todo_list/src/utils/backend_root.dart';
import 'package:todo_list/src/utils/http_utils/http_defaults.dart';
import 'package:todo_list/src/utils/http_utils/http_exception.dart';
import 'package:todo_list/src/utils/http_utils/http_methods_enum.dart';

class Tarefa with ChangeNotifier {
  int id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime expiryDate;
  DateTime? concludedAt;
  bool? isConcluded;
  bool isDelayed;

  Tarefa(
      {required this.title,
      required this.description,
      required this.createdAt,
      required this.expiryDate,
      this.isConcluded = false,
      this.isDelayed = false,
      required this.id});

  void _toggleConcluded() {
    concludedAt == null ? concludedAt = DateTime.now() : concludedAt = null;
    print(concludedAt?.toIso8601String());
    isConcluded ??= false;
    isConcluded = !isConcluded!;
    notifyListeners();
  }

  Future<void> toggleConcluded(String token) async {
    _toggleConcluded();

    final data = {
      "fgConcluida": isConcluded,
      "dataConclusao": concludedAt?.toIso8601String()
    };
    final String endpoint = "tarefa/$id/atualizarStatus";

    final response = await HttpDefaults.gerarChamadaHttpPadrao(
      rootPath: BackendRoot.path,
      endpoints: endpoint,
      headers: HttpDefaults.gerarHeaderPadrao(token: token),
      httpMethod: HttpMethods.put,
      body: data,
    );

    if (response.statusCode >= 400) {
      _toggleConcluded();
      throw HttpException(
        msg: response.body,
        statusCode: response.statusCode,
      );
    }
  }
}
