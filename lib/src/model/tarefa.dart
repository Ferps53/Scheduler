import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_list/src/utils/backendRoot.dart';
import 'package:todo_list/src/utils/http_exception.dart';

class Tarefa with ChangeNotifier {
  int id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime expiryDate;
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
    isConcluded ?? false;
    isConcluded = !isConcluded!;
    notifyListeners();
  }

  Future<void> toggleConcluded(String token) async {
    _toggleConcluded();
    final response = await http.put(
      Uri.parse(
        "${BackendRoot.path}/tarefa/$id/atualizarStatus",
      ),
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json"
      },
      body: jsonEncode({"fgConcluded": isConcluded}),
    );

    if (response.statusCode >= 400) {
      _toggleConcluded();
      print(response.statusCode);
      throw HttpException(
        msg: response.body,
        statusCode: response.statusCode,
      );
    }
  }
}
