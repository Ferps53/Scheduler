import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scheduler/core/core.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TarefaPage extends StatelessWidget {
  const TarefaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text('Tarefas'),
      ),
      body: Column(
        children: [
          OutlinedButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.clear();
              context.go(NamedRoutes.login.routePath);
            },
            child: const Text("Clear"),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemCount: 30,
                  itemBuilder: (context, index) {
                    index++;
                    return GridTile(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: GlassCard(
                          child: Center(
                            child: Text(
                              "$index",
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}
