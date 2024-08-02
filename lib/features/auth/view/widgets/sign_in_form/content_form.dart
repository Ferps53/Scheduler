import 'package:scheduler/core/core.dart';

import '../../view.dart';
import 'save_button.dart';

class ContentForm extends StatelessWidget {
  ContentForm({super.key});

  final passwordController = TextEditingController();
  final verifyPasswordController = TextEditingController();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
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
              'Criação de Conta',
              style: TextStyle(
                color: context.colorScheme.onPrimary,
                fontSize: 24,
              ),
            ),
            const Spacer(),
            CustomTextField(
              icon: Icons.person,
              label: 'Nome do Usuário',
              isSecret: false,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Digite seu nome de usuário';
                }
                if (value.trim().length < 6) {
                  return 'Nome de usuário tem que ser maior que 6 caractéres';
                }
                return null;
              },
              controller: usernameController,
            ),
            CustomTextField(
              icon: Icons.email,
              label: 'Email',
              isSecret: false,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Digite seu email';
                }
                if (!value.contains('@')) {
                  return 'Email inválido';
                }
                return null;
              },
              controller: emailController,
            ),
            CustomTextField(
              icon: Icons.lock,
              label: 'Senha',
              isSecret: true,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Digite sua senha';
                }
                if (value.trim().length < 8) {
                  return 'Digite uma senha maior que 8 caractéres';
                }
                return null;
              },
              controller: passwordController,
            ),
            CustomTextField(
              icon: Icons.lock,
              label: 'Digite a Senha Novamente',
              isSecret: true,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Digite sua senha';
                }
                if (value.length < 8) {
                  return 'Digite uma senha maior que 8 caractéres';
                }
                if (value != passwordController.text) {
                  return 'Senhas não coincidem';
                }

                return null;
              },
              controller: verifyPasswordController,
            ),
            const Spacer(),
            SaveButton(
              usernameController,
              emailController,
              passwordController,
              formKey,
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
