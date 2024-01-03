import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/src/model/lixeira_list.dart';
import 'package:todo_list/src/view/default_widgets/app_drawer.dart';
import 'package:todo_list/src/view/default_widgets/default_app_bar.dart';
import 'package:todo_list/src/view/lixeira/widgets/lixeira_appbar_action_button.dart';
import 'package:todo_list/src/view/lixeira/widgets/lixeira_tile.dart';

class LixeiraScreen extends StatefulWidget {
  const LixeiraScreen({super.key});

  @override
  State<LixeiraScreen> createState() => _LixeiraScreenState();
}

class _LixeiraScreenState extends State<LixeiraScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    Provider.of<LixeiraList>(context, listen: false)
        .loadTarefas()
        .then((value) {
      setState(() => _isLoading = false);
    });
    super.initState();
  }

  Future<void> _refreshTarefas(BuildContext context) {
    return Provider.of<LixeiraList>(
      context,
      listen: false,
    ).loadTarefas();
  }

  @override
  Widget build(BuildContext context) {
    LixeiraList lixeiraList = Provider.of(context);
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: const DefaultAppBar(
        label: "Lixeira",
        actions: [LixeiraAppBarButton()],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => _refreshTarefas(context),
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: lixeiraList.quantidadeTarefas == 0
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Você não tem nenhuma tarefa na lixeira",
                            style: TextStyle(fontSize: 16),
                          ),
                          Image.asset(
                            "assets/images/relaxed.jpg",
                          ),
                        ],
                      )
                    : ListView.builder(
                        itemCount: lixeiraList.quantidadeTarefas,
                        itemBuilder: (context, index) =>
                            ChangeNotifierProvider.value(
                                value: lixeiraList.tarefas[index],
                                child: const LixeiraTile()),
                      ),
              ),
            ),
    );
  }
}
