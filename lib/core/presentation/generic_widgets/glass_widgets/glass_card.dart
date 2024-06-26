import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:scheduler/core/core.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final double startGradient;
  final double endGradient;
  final bool isDialog;

  const GlassCard({
    required this.child,
    this.width,
    this.height,
    this.backgroundColor,
    this.startGradient = 0.3,
    this.endGradient = 0.05,
    this.isDialog = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColorWidget =
        backgroundColor ?? context.colorScheme.primaryContainer;

    final borderRadius = isDialog
        ? const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          )
        : BorderRadius.circular(20);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
      ),
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
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      backgroundColorWidget.withOpacity(startGradient),
                      backgroundColorWidget.withOpacity(endGradient)
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
