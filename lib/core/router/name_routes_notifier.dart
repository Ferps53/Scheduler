import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:todo_list/features/auth/domain/domain.dart';
import 'package:todo_list/features/auth/domain/entities/entities.dart';
import 'package:todo_list/features/auth/domain/entities/status_usuario.dart';

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
