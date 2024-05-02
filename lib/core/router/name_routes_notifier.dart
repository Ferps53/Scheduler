import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:scheduler/features/auth/auth.dart';

final statusUsuarioProvider = Provider<StatusUsuarioProvider>((ref) {
  return StatusUsuarioProvider();
});

class StatusUsuarioProvider with ChangeNotifier {
  StatusUsuario _statusUsuario = StatusUsuario.deslogado;
  StatusUsuario get statusUsuario => _statusUsuario;

  set statusUsuario(StatusUsuario statusUsuario) {
    _statusUsuario = statusUsuario;
    notifyListeners();
  }
}
