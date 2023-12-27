import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/src/model/tarefa_list.dart';
import 'package:todo_list/src/view/default_widgets/app_drawer.dart';

import '../../default_widgets/default_app_bar.dart';
import '../widgets/tarefa_floating_icon_button.dart';
import '../widgets/tarefa_tile.dart';

class TarefaScreen extends StatefulWidget {
  const TarefaScreen({super.key});

  @override
  State<TarefaScreen> createState() => _TarefaScreenState();
}

class _TarefaScreenState extends State<TarefaScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    Provider.of<TarefaList>(context, listen: false).loadTarefas().then((value) {
      setState(() => _isLoading = false);
    });
    super.initState();
  }

  Future<void> _refreshTarefas(BuildContext context) {
    return Provider.of<TarefaList>(
      context,
      listen: false,
    ).loadTarefas();
  }

  @override
  Widget build(BuildContext context) {
    TarefaList tarefasList = Provider.of(context);
    return Scaffold(
      drawer: const AppDrawer(),
      floatingActionButton: const TarefaFloatingActionButton(),
      appBar: const DefaultAppBar(label: "Tarefas"),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => _refreshTarefas(context),
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: tarefasList.quantidadeTarefas == 0
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Você não tem nenhuma tarefa no momento",
                            style: TextStyle(fontSize: 16),
                          ),
                          Image.asset(
                            "assets/images/relaxed.jpg",
                          ),
                        ],
                      )
                    : ListView.builder(
                        itemCount: tarefasList.quantidadeTarefas,
                        itemBuilder: (context, index) =>
                            ChangeNotifierProvider.value(
                                value: tarefasList.tarefas[index],
                                child: const TarefaTile()),
                      ),
              ),
            ),
    );
  }
}
