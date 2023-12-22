import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:todo_list/src/utils/backendRoot.dart';

class FirebaseMessagingApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> iniciarNotificacoes(String token) async {
    final fcmToken = await _firebaseMessaging.getToken();

    print("${BackendRoot.path}/notificacao/salvar/token");

    var data = jsonEncode(
      {'fcmToken': '$fcmToken'},
    );

    var response = await http.put(
      Uri.parse("${BackendRoot.path}/notificacao/salvar/token"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: data,
    );

    print(jsonDecode(response.body));
  }
}
