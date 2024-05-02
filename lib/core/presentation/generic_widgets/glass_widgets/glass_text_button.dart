import 'package:flutter/material.dart';
import 'package:scheduler/core/core.dart';

class GlassTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonLabel;
  final FocusNode? focusNode;
  final AppColors colors;
  final double? textSize;

  const GlassTextButton({
    required this.onPressed,
    required this.buttonLabel,
    required this.colors,
    this.focusNode,
    super.key,
    this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      focusNode: focusNode,
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: colors.backgroundColor.withOpacity(0.25),
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 8,
        ),
      ),
      child: Text(
        buttonLabel,
        style: TextStyle(
          color: colors.textColor,
          fontSize: textSize,
        ),
      ),
    );
  }
}
