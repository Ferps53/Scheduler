import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:scheduler/features/auth/auth.dart';

final statusUsuarioProvider = Provider<StatusUsuarioProvider>((ref) {
  return StatusUsuarioProvider();
});

class StatusUsuarioProvider with ChangeNotifier {
  StatusLogin _statusUsuario = StatusLogin.deslogado;
  StatusLogin get statusUsuario => _statusUsuario;

  set statusUsuario(StatusLogin statusUsuario) {
    _statusUsuario = statusUsuario;
    notifyListeners();
  }
}
