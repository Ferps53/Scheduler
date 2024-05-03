import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:scheduler/core/presentation/generic_widgets/glass_widgets/glass_widgets.dart';
import 'package:scheduler/core/styles/app_colors.dart';

class TarefaPage extends StatelessWidget {
  const TarefaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarefas'),
        centerTitle: true,
      ),
      body: Placeholder(
        child: Column(
          children: [
            Center(
              child: Card(
                elevation: 8,
                child: Transform.scale(
                  scale: 0.6,
                  child: LoadingAnimationWidget.inkDrop(
                      color: AppColors.infoColors.primaryColor, size: 80),
                ),
              ),
            ),
            const GlassTextLoadingButton(colors: AppColors.infoColors)
          ],
        ),
      ),
    );
  }
}
