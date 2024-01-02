import 'package:flutter/material.dart';
import 'package:todo_list/src/view/default_widgets/app_drawer.dart';
import 'package:todo_list/src/view/default_widgets/default_app_bar.dart';
import 'package:todo_list/src/view/lixeira/widgets/lixeira_appbar_action_button.dart';

class LixeiraScreen extends StatelessWidget {
  const LixeiraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      drawer: AppDrawer(),
      appBar: DefaultAppBar(
        label: "Lixeira",
        actions: [LixeiraAppBarButton()],
      ),
    );
  }
}
