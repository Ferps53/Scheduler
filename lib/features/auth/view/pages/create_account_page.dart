import 'package:flutter/material.dart';
import 'package:scheduler/core/core.dart';
import 'package:scheduler/features/auth/auth.dart';

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackgroundGradientScaffold(
      appBarLabel: 'Criar uma Conta',
      child: _FormCreateAccount(),
    );
  }
}

class _FormCreateAccount extends StatelessWidget {
  const _FormCreateAccount();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
        ),
        child: GlassCard(
          backgroundColor: context.colorScheme.primaryContainer,
          height: 432,
          child: const _ContentForm(),
        ),
      ),
    );
  }
}

class _ContentForm extends StatelessWidget {
  const _ContentForm();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 4,
            ),
            Text(
              "Criação de Conta",
              style: TextStyle(
                color: context.colorScheme.onPrimary,
                fontSize: 24,
              ),
            ),
            const Spacer(),
            LoginTextField(
              icon: Icons.person,
              label: 'Nome do Usuário',
              isSecret: false,
              controller: TextEditingController(),
            ),
            LoginTextField(
              icon: Icons.email,
              label: 'Email',
              isSecret: false,
              controller: TextEditingController(),
            ),
            LoginTextField(
              icon: Icons.lock,
              label: 'Senha',
              isSecret: true,
              controller: TextEditingController(),
            ),
            LoginTextField(
              icon: Icons.lock,
              label: 'Digite a Senha Novamente',
              isSecret: true,
              controller: TextEditingController(),
            ),
            const Spacer(),
            GlassTextButton(
              onPressed: () {},
              buttonLabel: 'Criar Conta',
              textSize: 24,
            ),
            const SizedBox(
              height: 4,
            )
          ],
        ),
      ),
    );
  }
}
