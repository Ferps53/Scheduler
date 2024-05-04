import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:scheduler/core/core.dart';
import 'package:scheduler/features/auth/auth.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Background(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              "Recuperar senha",
              style: TextStyle(
                  color: AppColors.infoColors.textColor, fontSize: 24),
            ),
          ),
          body: Center(
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
        )
      ],
    );
  }
}
