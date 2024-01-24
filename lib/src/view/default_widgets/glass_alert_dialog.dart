import 'package:flutter/material.dart';
import 'package:todo_list/src/styles/app_colors.dart';
import 'package:todo_list/src/view/default_widgets/default_dialog.dart';
import 'package:todo_list/src/view/default_widgets/glass_text_button.dart';

class GlassAlertDialog extends StatelessWidget {
  final String headerLabel;
  final double height;
  final String textContent;
  final String firstButtonText;
  final void Function()? firstButtonAction;
  final String? secondButtonText;
  final void Function()? secondButtonAction;
  final AppColors colors;

  const GlassAlertDialog.info({
    super.key,
    required this.headerLabel,
    required this.textContent,
    required this.firstButtonText,
    this.firstButtonAction,
    this.secondButtonText,
    this.secondButtonAction,
    this.height = 250,
    this.colors = AppColors.infoColors,
  });

  const GlassAlertDialog.danger({
    super.key,
    required this.headerLabel,
    required this.textContent,
    required this.firstButtonText,
    this.firstButtonAction,
    this.secondButtonText,
    this.secondButtonAction,
    this.height = 250,
    this.colors = AppColors.danger,
  });

  const GlassAlertDialog.warn({
    super.key,
    required this.headerLabel,
    required this.textContent,
    required this.firstButtonText,
    this.firstButtonAction,
    this.secondButtonText,
    this.secondButtonAction,
    this.height = 250,
    this.colors = AppColors.warn,
  });

  const GlassAlertDialog.success({
    super.key,
    required this.headerLabel,
    required this.textContent,
    required this.firstButtonText,
    this.firstButtonAction,
    this.secondButtonText,
    this.secondButtonAction,
    this.height = 250,
    this.colors = AppColors.success,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultDialog(
      color: colors,
      headerLabel: headerLabel,
      content: Text(
        textContent,
        softWrap: true,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
      actions: _gerarActionButtons(),
      height: height,
    );
  }

  List<Widget> _gerarActionButtons() {
    if (secondButtonText != null && secondButtonAction != null) {
      return [
        GlassTextButton(
          colors: colors,
          onPressed: firstButtonAction,
          buttonLabel: firstButtonText,
        ),
        GlassTextButton(
          colors: colors,
          onPressed: secondButtonAction,
          buttonLabel: secondButtonText!,
        ),
      ];
    }
    return [
      GlassTextButton(
        colors: colors,
        onPressed: firstButtonAction,
        buttonLabel: firstButtonText,
      ),
    ];
  }
}
