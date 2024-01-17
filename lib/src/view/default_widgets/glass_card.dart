import 'dart:ui';

import 'package:flutter/material.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final double width;
  final double heigth;
  final Color backgroundColor;
  final double startGradient;
  final double endGradient;

  const GlassCard(
      {required this.child,
      required this.width,
      required this.heigth,
      required this.backgroundColor,
      this.startGradient = 0.3,
      this.endGradient = 0.25,
      super.key});

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(20);
    return Container(
      width: width,
      height: heigth,
      constraints: const BoxConstraints(
        maxHeight: double.infinity,
        maxWidth: double.infinity,
      ),
      decoration: BoxDecoration(
        borderRadius: borderRadius,
      ),
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5,
              sigmaY: 5,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.2)),
              borderRadius: borderRadius,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  backgroundColor.withOpacity(startGradient),
                  backgroundColor.withOpacity(endGradient)
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: child),
          ),
        ],
      ),
    );
  }
}
