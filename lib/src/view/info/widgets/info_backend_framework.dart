part of '../screen/info_screen.dart';

class _InfoBackendFramework extends StatelessWidget {
  const _InfoBackendFramework();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage("assets/images/quarkus.jpg"),
            ),
            title: Text("Backend"),
            subtitle: Text(
              "Para a criação do servidor por trás dessa aplicação foi utilizado o Quarkus, um framework de Java. Este serviço roda na nuvem através do Railway.app",
              softWrap: true,
            ),
          )
        ],
      ),
    );
  }
}
