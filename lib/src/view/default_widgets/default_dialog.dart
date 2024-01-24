import 'package:flutter/material.dart';
import 'package:todo_list/src/styles/app_colors.dart';
import 'package:todo_list/src/view/default_widgets/glass_card.dart';

class DefaultDialog extends StatelessWidget {
  final String headerLabel;
  final List<Widget> actions;
  final Widget content;
  final double height;
  final AppColors color;

  const DefaultDialog(
      {required this.headerLabel,
      required this.content,
      required this.actions,
      required this.height,
      required this.color,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: const Color(0x00000000),
      child: GlassCard(
        height: height,
        backgroundColor: color.backgroundColor,
        startGradient: 0.5,
        endGradient: 0.05,
        child: Column(
          children: [
            AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              elevation: 0,
              shadowColor: Colors.black54,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              foregroundColor: Colors.white,
              backgroundColor: color.baseColor.withOpacity(0.7),
              title: FittedBox(
                fit: BoxFit.fitHeight,
                child: Text(
                  headerLabel,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              constraints: const BoxConstraints(minHeight: 100, maxWidth: 300),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: content,
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: actions,
              ),
            )
          ],
        ),
      ),
    );
  }
}
