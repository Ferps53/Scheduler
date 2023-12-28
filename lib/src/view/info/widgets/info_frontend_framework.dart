part of '../screen/info_screen.dart';

class _InfoFrontendFramework extends StatelessWidget {
  const _InfoFrontendFramework();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage:
                  AssetImage("assets/images/flutter_framework.jpg"),
            ),
            title: Text("Framework Frontend"),
            subtitle: Text(
              "O framework utilizado para a criação das telas deste aplicativo é o Flutter.",
              softWrap: true,
            ),
          )
        ],
      ),
    );
  }
}
