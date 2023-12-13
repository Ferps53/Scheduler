import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingApi{

  final _firebaseMessaging = FirebaseMessaging.instance;

   Future<void> iniciarNotificacoes() async{

    final token = await _firebaseMessaging.getToken();

    print("Token:$token");

  }

}