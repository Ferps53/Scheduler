import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/src/model/auth.dart';
import 'package:todo_list/src/utils/router.dart';
import 'package:todo_list/src/view/widgets/default_app_bar.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    String username =
        Provider.of<Auth>(context, listen: false).username ?? "Sem nome";
    return Drawer(
      child: Column(
        children: [
          DefaultAppBar(
            label: "Seja bem-vindo $username!",
            implyLeading: false,
          ),
          const Spacer(),
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
                AppRouter.AUTH,
              );
            },
          )
        ],
      ),
    );
  }
}
