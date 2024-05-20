import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:scheduler/core/router/named_routes.dart';
import 'package:scheduler/core/styles/styles.dart';
import 'package:scheduler/features/auth/view/providers/provider.dart';

class SchedulerAppbar extends ConsumerWidget implements PreferredSizeWidget {
  const SchedulerAppbar({
    required this.title,
    super.key,
  });
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      backgroundColor: context.colorScheme.primary,
      foregroundColor: context.colorScheme.onPrimary,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
        ),
      ),
      actions: [
        PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              child: ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                  color: context.colorScheme.error,
                ),
                title: Text(
                  "Sair do app",
                  style: TextStyle(
                    color: context.colorScheme.onSurface,
                  ),
                ),
                onTap: () async {
                  final loginRepo = await ref.read(loginRepoProvider);
                  final routerNotifier = 
                  loginRepo.deslogar();
                  
                },
              ),
            ),
          ],
          icon: const Icon(
            Icons.account_box,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
