import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:scheduler/features/auth/auth.dart';

final statusUsuarioProvider = Provider<StatusUsuarioProvider>((ref) {
  return StatusUsuarioProvider();
});

class StatusUsuarioProvider with ChangeNotifier {
  StatusLogin _statusLogin = StatusLogin.deslogado;
  StatusLogin get statusUsuario => _statusLogin;

  set statusUsuario(StatusLogin statusUsuario) {
    _statusLogin = statusUsuario;
    notifyListeners();
  }
}
