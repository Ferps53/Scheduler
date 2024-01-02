import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/src/model/auth.dart';
import 'package:todo_list/src/utils/router.dart';
import 'package:todo_list/src/view/default_widgets/default_app_bar.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    Color iconColor = Colors.grey.shade800;
    String username =
        Provider.of<Auth>(context, listen: false).username ?? "Sem nome";
    return Drawer(
      child: Column(
        children: [
          DefaultAppBar(
            label: "Seja bem-vindo $username!",
            implyLeading: false,
          ),
          ListTile(
              leading: Icon(
                Icons.edit_calendar_outlined,
                color: iconColor,
              ),
              title: const Text("Tarefas"),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(AppRouter.tarefas);
              }),
          const Divider(),
          ListTile(
              leading: Icon(
                Icons.delete,
                color: iconColor,
              ),
              title: const Text("Lixeira"),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(AppRouter.lixeira);
              }),
          const Divider(),
          ListTile(
              leading: Icon(
                Icons.settings_outlined,
                color: iconColor,
              ),
              title: const Text("Configurações"),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(AppRouter.config);
              }),
          const Divider(),
          ListTile(
            leading: Icon(
              Icons.info_outline,
              color: iconColor,
            ),
            title: const Text("Sobre o App"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRouter.info);
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: ColorScheme.fromSwatch().error,
            ),
            title: const Text("Sair"),
            onTap: () {
              Provider.of<Auth>(
                context,
                listen: false,
              ).signOut();
              Navigator.of(context).pushReplacementNamed(
                AppRouter.auth,
              );
            },
          ),
          const Divider(),
          const Spacer(),
          const Text(
            "Scheduler - Organize suas tarefas",
            style: TextStyle(height: 2),
          ),
        ],
      ),
    );
  }
}
