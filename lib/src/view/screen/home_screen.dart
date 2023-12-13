import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff03A9F4),
        foregroundColor: Colors.white,
        title: const Text(
          "Página Inicial",
        ),
      ),
    );
  }
}
