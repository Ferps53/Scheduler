import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scheduler/core/styles/styles.dart';
import 'package:scheduler/features/auth/auth.dart';

class TaskFullscreenDialog extends StatelessWidget {
  const TaskFullscreenDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      child: Column(
        children: [
          ListTile(
            title: Center(
              child: Text(
                'Editar Tarefa',
                style: context.titleLarge,
              ),
            ),
            trailing: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(Icons.close),
            ),
          ),
          Form(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Column(
                children: [
                  LoginTextField(
                    icon: Icons.light,
                    label: 'Teste',
                    isSecret: false,
                    controller: TextEditingController(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
