import 'package:flutter/material.dart';

class GlassTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonLabel;
  final FocusNode? focusNode;
  final double? textSize;
  final double transparency;

  const GlassTextButton({
    required this.onPressed,
    required this.buttonLabel,
    this.focusNode,
    super.key,
    this.textSize,
    this.transparency = .2,
  });

  const GlassTextButton.moreTransparent({
    required this.onPressed,
    required this.buttonLabel,
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
        backgroundColor: Theme.of(context)
            .colorScheme
            .primaryContainer
            .withOpacity(transparency),
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
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          fontSize: textSize,
        ),
      ),
    );
  }
}
