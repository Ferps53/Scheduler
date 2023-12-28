part of '../screen/info_screen.dart';

class _ServicesCard extends StatelessWidget {
  const _ServicesCard();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage("assets/icons/icon.png"),
            ),
            title: Text("Serviços do Aplicativo"),
            subtitle: Text(
              "O schdeuler conta com um sistema de notificações sobre as tarefas que estão para vencer. Além da interface simples para organizar seus afazeres.",
              softWrap: true,
            ),
          )
        ],
      ),
    );
  }
}
