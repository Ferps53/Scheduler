import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:todo_list/features/auth/domain/entities/entities.dart';
import 'package:todo_list/features/auth/domain/entities/status_usuario.dart';

final statusUsuarioProvider = Provider<StatusUsuarioProvider>((ref) {
  return StatusUsuarioProvider();
});

class StatusUsuarioProvider extends Notifier<StatusUsuario>
    with ChangeNotifier {
  StatusUsuario get statusUsuario => state;

  set statusUsuario(StatusUsuario statusUsuario) {
    state = statusUsuario;
    notifyListeners();
  }

  @override
  StatusUsuario build() {
    return StatusUsuario.deslogado;
  }
}
