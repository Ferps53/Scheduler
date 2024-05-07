import 'package:flutter/material.dart';
import 'package:scheduler/core/core.dart';

class GlassTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonLabel;
  final FocusNode? focusNode;
  final AppColors colors;
  final double? textSize;
  final double transparency;

  const GlassTextButton({
    required this.onPressed,
    required this.buttonLabel,
    required this.colors,
    this.focusNode,
    super.key,
    this.textSize,
    this.transparency = .2,
  });

  const GlassTextButton.moreTransparent({
    required this.onPressed,
    required this.buttonLabel,
    required this.colors,
    this.focusNode,
    super.key,
    this.textSize = 12,
    this.transparency = .1,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      focusNode: focusNode,
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: colors.backgroundColor.withOpacity(transparency),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: Colors.white.withOpacity(.1),
          ),
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
