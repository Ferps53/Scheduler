import 'package:flutter/material.dart';
import 'package:todo_list/src/view/default_widgets/app_drawer.dart';
import 'package:todo_list/src/view/default_widgets/default_app_bar.dart';

class ConfigScreen extends StatelessWidget {
  const ConfigScreen({super.key});

  //TODO: Implementar essa tela
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      drawer: AppDrawer(),
      appBar: DefaultAppBar(label: "Configurações do App"),
      body: Placeholder(),
    );
  }
}
