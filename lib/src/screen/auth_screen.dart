import 'package:flutter/material.dart';
import 'package:todo_list/src/widgets/auth_form.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColorLight,
                  Theme.of(context).primaryColorDark,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 8,
                      color: Theme.of(context).primaryColorDark,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 20,
                        ),
                        child: Text(
                          "Lista de Tarefas",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                    ),
                    const AuthForm()
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
