import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:scheduler/core/core.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GlassCard(
        width: 100,
        height: 100,
        child: Transform.scale(
          scale: 0.8,
          child: LoadingAnimationWidget.inkDrop(
            color: context.colorScheme.primary,
            size: 80,
          ),
        ),
      ),
    );
  }
}
