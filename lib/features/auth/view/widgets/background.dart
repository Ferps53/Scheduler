import 'package:flutter/material.dart';
import 'package:scheduler/core/core.dart';

class Background extends StatelessWidget {
  const Background({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: context.brightness == Brightness.light
              ? [
                  context.colorScheme.inversePrimary,
                  context.colorScheme.primary,
                ]
              : [
                  context.colorScheme.primary,
                  context.colorScheme.inversePrimary
                ],
        ),
      ),
    );
  }
}
