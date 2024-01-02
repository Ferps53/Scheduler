import 'package:flutter/material.dart';
import 'package:todo_list/src/view/lixeira/dialogs/lixeira_info_dialog.dart';

class LixeiraAppBarButton extends StatelessWidget {
  const LixeiraAppBarButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          await showDialog(
              context: context,
              builder: (context) => const LixeiraInfoDialog());
        },
        icon: const Icon(Icons.info_outline));
  }
}
