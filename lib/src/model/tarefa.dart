import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_list/src/utils/firebase_location.dart';
import 'package:todo_list/src/utils/http_exception.dart';

class Tarefa with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime expiryDate;
  bool isConcluded;
  bool isDelayed;

  Tarefa(
      {required this.id,
      required this.title,
      required this.description,
      required this.createdAt,
      required this.expiryDate,
      this.isConcluded = false,
      this.isDelayed = false});

  void _toggleConcluded() {
    isConcluded = !isConcluded;
    notifyListeners();
  }

  Future<void> toggleConcluded(String token, String uid) async {
    _toggleConcluded();
    final response = await http.patch(
      Uri.parse(
        "${FireBaseLocation.baseUrl}/$uid/$id.json?auth=$token",
      ),
      body: jsonEncode({"isConcluded": isConcluded}),
    );

    if (response.statusCode >= 400) {
      _toggleConcluded();
      print(response.statusCode);
      throw HttpException(
        msg: "Erro de server",
        statusCode: response.statusCode,
      );
    }
  }
}
