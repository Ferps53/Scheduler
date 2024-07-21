import 'package:scheduler/core/core.dart';

import '../../view.dart';
import 'save_button.dart';

class ContentForm extends StatefulWidget {
  ContentForm({super.key});
  final passwordController = TextEditingController();
  final verifyPasswordController = TextEditingController();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();

  @override
  State<ContentForm> createState() => _ContentFormState();
}

class _ContentFormState extends State<ContentForm> {
  @override
  void dispose() {
    widget.verifyPasswordController.dispose();
    widget.passwordController.dispose();
    widget.emailController.dispose();
    widget.usernameController.dispose();

    super.dispose();
  }

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
            LoginTextField(
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
              controller: widget.usernameController,
            ),
            LoginTextField(
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
              controller: widget.emailController,
            ),
            LoginTextField(
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
              controller: widget.passwordController,
            ),
            LoginTextField(
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
                if (value != widget.passwordController.text) {
                  return 'Senhas não coincidem';
                }

                return null;
              },
              controller: widget.verifyPasswordController,
            ),
            const Spacer(),
            SaveButton(
              widget.usernameController,
              widget.emailController,
              widget.passwordController,
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
