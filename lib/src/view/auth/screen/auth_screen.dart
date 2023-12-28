import 'package:flutter/material.dart';
import 'package:todo_list/src/view/auth/widgets/auth_form.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(colors: [
                Theme.of(context).primaryColorLight,
                const Color(0xff0099d4),
              ], radius: 1, focalRadius: 2),
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
                          vertical: 10.0,
                          horizontal: 35,
                        ),
                        child: Text(
                          "Scheduler",
                          style: TextStyle(color: Colors.white, fontSize: 45),
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
