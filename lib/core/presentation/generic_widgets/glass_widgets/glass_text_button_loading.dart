import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class GlassTextLoadingButton extends StatelessWidget {
  const GlassTextLoadingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          backgroundColor:
              Theme.of(context).colorScheme.surface.withOpacity(.2),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8)),
      onPressed: null,
      child: Center(
        child: Transform.scale(
          scale: 0.8,
          child: LoadingAnimationWidget.waveDots(
              color: Theme.of(context).colorScheme.onSurface, size: 32),
        ),
      ),
    );
  }
}
