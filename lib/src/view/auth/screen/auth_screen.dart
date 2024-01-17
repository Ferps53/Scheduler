import 'package:flutter/material.dart';
import 'package:todo_list/src/view/auth/widgets/auth_form.dart';
import 'package:todo_list/src/view/default_widgets/glass_card.dart';

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
                Theme.of(context).primaryColorLight.withOpacity(0.5),
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
                    GlassCard(
                      startGradient: 0.75,
                      endGradient: 0.6,
                      heigth: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.width * 0.8,
                      backgroundColor: Theme.of(context).primaryColorDark,
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
