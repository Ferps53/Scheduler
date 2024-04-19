import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/core/core.dart';
import 'package:todo_list/core/presentation/generic_widgets/glass_card.dart';

class LoginForm extends ConsumerWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Center(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          alignment: Alignment.center,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GlassCard(
                  backgroundColor: AppColors.infoColors.textColor,
                  child: const Row(
                    children: [
                      Image(
                        image: AssetImage('assets/calendar.png'),
                      ),
                      Text('Scheduler')
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
