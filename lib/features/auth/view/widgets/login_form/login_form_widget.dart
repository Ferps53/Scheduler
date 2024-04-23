import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/core/core.dart';
import 'package:todo_list/core/presentation/generic_widgets/glass_card.dart';
import 'package:todo_list/features/auth/view/widgets/login_form/login_text_field.dart';

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
          child: Column(
            children: [
              const AppLogo(),
              GlassCard(
                backgroundColor: Colors.grey,
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      LoginTextField(
                        icon: Icons.email,
                        label: 'Email',
                        isSecret: false,
                        controller: TextEditingController(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      LoginTextField(
                        icon: Icons.password,
                        label: 'Senha',
                        isSecret: true,
                        controller: TextEditingController(),
                        validator: (String? senha) {
                          if (senha == null || senha.isEmpty) {
                            return 'Digite sua senha';
                          } if(senha.length < 6) return 'Digite uma senha maior';
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: GlassCard(
        backgroundColor: AppColors.infoColors.textColor,
        child: const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              child: Image(
                fit: BoxFit.scaleDown,
                image: AssetImage('assets/icons/calendar.png'),
              ),
            ),
            Text(
              'Scheduler',
              style: TextStyle(fontSize: 40, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
