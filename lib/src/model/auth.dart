import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_list/src/utils/auth_exception.dart';
import 'package:todo_list/src/utils/backendRoot.dart';

import '../api/firebase/firebase_messaging.dart';
import '../data/store.dart';

class Auth with ChangeNotifier {
  String? _token;
  String? _username;
  String? _email;
  DateTime? _expDate;
  Timer? _signOutTimer;
  String? _refreshToken;
  DateTime? _expDateRefresh;

  bool get isAuth {
    final isValid = _expDate?.isAfter(DateTime.now()) ?? false;

    return _token != null && isValid;
  }

  String? get token {
    return isAuth ? _token : null;
  }

  String? get email {
    return isAuth ? _email : null;
  }

  String? get username {
    return isAuth ? _username : null;
  }

  String? get refreshToken {
    return isAuth ? _refreshToken : null;
  }

  DateTime? get refreshTokenExp {
    return _expDateRefresh;
  }

  Future<void> _authenticate(
      String username, String password, String? email, String urlFrag) async {
    var data = jsonEncode(
        {'nomeUsuario': username, 'senha': password, 'email': email ?? ''});

    if (urlFrag == "cadastro") {
      var response = await http.post(
        Uri.parse("${BackendRoot.path}/$urlFrag"),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: data,
      );

      print(response.statusCode);

      if (response.statusCode == 409) {
        throw AuthException('USUARIO_EXISTE');
      }
      urlFrag = "login";
    }
    var response = await http.post(
      Uri.parse("${BackendRoot.path}/$urlFrag"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
      body: data,
    );

    if (response.statusCode == 401) {
      throw AuthException('DADOS_INCORRETOS');
    }

    var body = jsonDecode(response.body);

    _token = body['access_token'];
    _refreshToken = body['refresh_token'];
    _expDate = DateTime.now().add(
      Duration(
        seconds: int.parse(
          body['expires_in'].toString(),
        ),
      ),
    );
    _expDateRefresh = DateTime.now().add(
      Duration(
        seconds: int.parse(
          body['refresh_expires_in'].toString(),
        ),
      ),
    );

    print(_token!);

    await FirebaseMessagingApi().iniciarNotificacoes(_token!);

    Store.saveMap("userData", {
      'token': _token,
      'email': _email,
      'username': _username,
      'expDate': _expDate!.toIso8601String(),
    });
    _autoSignOut();
    notifyListeners();
  }

  Future<void> tryAutoLogin() async {
    if (isAuth) return;

    final userData = await Store.getMap('userData');

    if (userData.isEmpty) return;

    final expiryDate = DateTime.parse(userData["expDate"]);
    if (expiryDate.isBefore(DateTime.now())) return;

    _token = userData['token'];
    _email = userData['email'];
    _username = userData['username'];
    _expDate = expiryDate;

    _autoSignOut();
    notifyListeners();
  }

  Future<void> signUp(String username, String password, String email) async {
    return _authenticate(
      username,
      password,
      email,
      "cadastro",
    );
  }

  Future<void> signIn(String username, String password, String email) async {
    return _authenticate(
      username,
      password,
      email,
      "login",
    );
  }

  void signOut() {
    _token = null;
    _email = null;
    _expDate = null;
    _username = null;
    _clearAutoSignOut();
    Store.remove("userData").then((value) => notifyListeners());
  }

  void _clearAutoSignOut() {
    _signOutTimer?.cancel();
    _signOutTimer = null;
  }

  void _autoSignOut() {
    _clearAutoSignOut();
    final timeToSignOut = _expDate?.difference(DateTime.now()).inSeconds;

    _signOutTimer = Timer(Duration(seconds: timeToSignOut ?? 0), signOut);
  }
}
