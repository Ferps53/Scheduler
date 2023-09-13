import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../data/store.dart';
import '../utils/auth_exception.dart';

class Auth with ChangeNotifier {
  String? _token;
  String? _email;
  String? _uid;
  DateTime? _expDate;
  Timer? _signOutTimer;

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

  String? get uid {
    return isAuth ? _uid : null;
  }

  Future<void> _authenticate(
      String email, String password, String urlFragment) async {
    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:$urlFragment?key=AIzaSyAYffe5cGS4BrMNTS7eNx_fghIjB8tAh-E";
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(
        {
          'email': email,
          'password': password,
          "returnSecureToken": true,
        },
      ),
    );

    final body = jsonDecode(response.body);

    if (body['error'] != null) {
      throw AuthException(body["error"]["message"]);
    } else {
      _token = body['idToken'];
      _email = body['email'];
      _uid = body['localId'];
      _expDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            body['expiresIn'],
          ),
        ),
      );

      Store.saveMap("userData", {
        'token': _token,
        'email': _email,
        'uid': _uid,
        'expDate': _expDate!.toIso8601String(),
      });

      _autoSignOut();
      notifyListeners();
    }
  }

  Future<void> tryAutoLogin() async {
    if (isAuth) return;

    final userData = await Store.getMap('userData');

    if (userData.isEmpty) return;

    final expiryDate = DateTime.parse(userData["expDate"]);
    if (expiryDate.isBefore(DateTime.now())) return;

    _token = userData['token'];
    _email = userData['email'];
    _uid = userData['uid'];
    _expDate = expiryDate;

    _autoSignOut();
    notifyListeners();
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password, "signUp");
  }

  Future<void> signIn(String email, String password) async {
    return _authenticate(email, password, "signInWithPassword");
  }

  void signOut() {
    _token = null;
    _email = null;
    _expDate = null;
    _uid = null;
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
    print(timeToSignOut);
    _signOutTimer = Timer(Duration(seconds: timeToSignOut ?? 0), signOut);
  }
}
