import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/src/model/auth.dart';
import 'package:todo_list/src/utils/router.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            title: const Text(
              "Mantenha suas Tarefas em dia!",
            ),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: const Text("Sair"),
            onTap: () {
              Provider.of<Auth>(
                context,
                listen: false,
              ).signOut();
              Navigator.of(context).pushReplacementNamed(
                AppRouter.AUTH,
              );
            },
          )
        ],
      ),
    );
  }
}
