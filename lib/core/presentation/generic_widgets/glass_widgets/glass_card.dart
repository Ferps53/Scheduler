import 'dart:ui';

import 'package:scheduler/core/core.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final bool isFrosted;

  const GlassCard({
    required this.child,
    this.width,
    this.height,
    this.backgroundColor,
    this.isFrosted = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColorWidget =
        backgroundColor ?? context.colorScheme.primaryContainer;

    final borderRadius = BorderRadius.circular(20);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: Border.all(color: Colors.white.withOpacity(0.2)),
        color: backgroundColorWidget.withOpacity(0.15),
      ),
      child: isFrosted
          ? ClipRRect(
              borderRadius: borderRadius,
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 3,
                  sigmaY: 3,
                ),
                child: child,
              ),
            )
          : child,
    );
  }
}
