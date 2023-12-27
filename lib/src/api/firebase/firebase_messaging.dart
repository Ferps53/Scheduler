import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:todo_list/src/utils/backend_root.dart';
import 'package:todo_list/src/utils/http_utils/http_defaults.dart';
import 'package:todo_list/src/utils/http_utils/http_methods_enum.dart';

class FirebaseMessagingApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> iniciarNotificacoes(String token) async {
    final fcmToken = await _firebaseMessaging.getToken();

    var data = {"fcmToken": "$fcmToken"};

    await HttpDefaults.gerarChamadaHttpPadrao(
      rootPath: BackendRoot.path,
      endpoints: "notificacao/salvar/token",
      headers: HttpDefaults.gerarHeaderPadrao(token: token),
      httpMethod: HttpMethods.put,
      body: data,
    );

  }
}
