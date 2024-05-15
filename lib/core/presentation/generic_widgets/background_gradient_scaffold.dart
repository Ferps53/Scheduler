import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scheduler/core/styles/app_colors.dart';
import 'package:scheduler/features/auth/auth.dart';

class BackgroundGradientScaffold extends StatelessWidget {
  const BackgroundGradientScaffold(
      {super.key, required this.child, required this.appBarLabel});

  final Widget child;
  final String appBarLabel;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Theme.of(context).colorScheme.primary));
    return Stack(
      children: [
        const Background(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
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
