import 'package:flutter/material.dart';
import 'package:scheduler/core/core.dart';

class GlassTextLoadingButton extends StatelessWidget {
  final AppColors colors;

  const GlassTextLoadingButton({
    super.key,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          backgroundColor: colors.backgroundColor.withOpacity(0.25),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8)),
      onPressed: null,
      child: Center(
        child: Transform.scale(
          scale: 0.8,
          child: CircularProgressIndicator(
            color: colors.textColor,
          ),
        ),
      ),
    );
  }
}
