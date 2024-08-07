import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:scheduler/core/core.dart';

class GlassTextLoadingButton extends StatelessWidget {
  const GlassTextLoadingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: context.colorScheme.surface.withOpacity(.2),
      ),
      onPressed: null,
      child: Center(
        child: Transform.scale(
          scale: 0.8,
          child: LoadingAnimationWidget.waveDots(
              color: context.colorScheme.onSurface, size: 32),
        ),
      ),
    );
  }
}
