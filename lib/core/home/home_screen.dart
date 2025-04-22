import 'package:flutter/material.dart';

/// This screen exists to validate if the user is logged in.
/// If it is then it should redirect to the dashboard, otherwise the user is asked to login
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.cyan, Colors.lightBlue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),

        SafeArea(
          child: Center(
            child: Card(
              margin: const EdgeInsets.all(48),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Transform.scale(
                  scale: 2,
                  child: CircularProgressIndicator.adaptive(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
