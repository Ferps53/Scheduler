import 'package:flutter/material.dart';
import 'package:todo_list/src/view/default_widgets/app_drawer.dart';
import 'package:todo_list/src/view/default_widgets/default_app_bar.dart';

part '../widgets/info_about_app_card.dart';
part '../widgets/info_backend_framework.dart';
part '../widgets/info_developer_card.dart';
part '../widgets/info_frontend_framework.dart';
part '../widgets/info_services_card.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      drawer: AppDrawer(),
      appBar: DefaultAppBar(label: "Sobre o App"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(4.0),
          child: Card(
            elevation: 10,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _AboutAppCard(),
                  _ServicesCard(),
                  _InfoFrontendFramework(),
                  _InfoBackendFramework(),
                  _InfoDeveloperCard(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
