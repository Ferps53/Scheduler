import 'package:flutter/material.dart';

import '../../styles/app_colors.dart';

class GlassTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonLabel;
  final FocusNode? focusNode;

  const GlassTextButton({
    required this.onPressed,
    required this.buttonLabel,
    this.focusNode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      focusNode: focusNode,
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: AppColors.backgroundColor.withOpacity(0.25),
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 8,
        ),
      ),
      child: Text(
        buttonLabel,
        style: const TextStyle(color: AppColors.textColor),
      ),
    );
  }
}
