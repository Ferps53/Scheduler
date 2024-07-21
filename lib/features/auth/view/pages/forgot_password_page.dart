import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:scheduler/core/core.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundGradientScaffold(
      appBarLabel: 'Recuperar Senha',
      child: Center(
        child: GlassCard(
          backgroundColor: Colors.white,
          height: 100,
          width: 100,
          child: Transform.scale(
            scale: 0.6,
            child: LoadingAnimationWidget.inkDrop(
                color: AppColors.infoColors.baseColor, size: 100),
          ),
        ),
      ),
    );
  }
}
