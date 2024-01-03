part of '../screen/info_screen.dart';

class _AboutAppCard extends StatelessWidget {
  const _AboutAppCard();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage("assets/icons/icon.png"),
            ),
            title: Text("Objetivos do Aplicativo"),
            subtitle: Text(
              "O Scheduler é um aplicativo android/ios, com o objetivo de facilitar a organização e realização de tarefas.",
              softWrap: true,
            ),
          )
        ],
      ),
    );
  }
}
