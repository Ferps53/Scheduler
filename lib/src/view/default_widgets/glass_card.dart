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
      this.endGradient = 0.05,
      super.key});

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(20);
    return AnimatedContainer(
      width: width,
      height: heigth,
      constraints: const BoxConstraints(
        maxHeight: double.infinity,
        maxWidth: double.infinity,
      ),
      decoration: BoxDecoration(
        borderRadius: borderRadius,
      ),
      duration: const Duration(milliseconds: 300),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 3,
            sigmaY: 3,
          ),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                  borderRadius: borderRadius,
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(3, 10),
                        blurRadius: 20,
                        spreadRadius: 5,
                        color: Colors.white.withOpacity(0.05)),
                  ],
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
              Center(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
