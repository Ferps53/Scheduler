import 'package:flutter/material.dart';
import 'package:scheduler/features/auth/auth.dart';
import 'package:scheduler/core/core.dart';

class BackgroundGradientScaffold extends StatelessWidget {
  const BackgroundGradientScaffold(
      {super.key, required this.child, required this.appBarLabel});

  final Widget child;
  final String appBarLabel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Background(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            foregroundColor: context.colorScheme.onPrimary,
            title: Text(
              appBarLabel,
              style: const TextStyle(fontSize: 24),
            ),
          ),
          body: child,
        )
      ],
    );
  }
}
