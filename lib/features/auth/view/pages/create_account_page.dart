import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scheduler/core/core.dart';
import 'package:scheduler/features/auth/auth.dart';
import 'package:scheduler/features/auth/data/model/user_model.dart';
import 'package:scheduler/features/auth/view/providers/sign_in_provider.dart';

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
          child: _ContentForm(),
        ),
      ),
    );
  }
}

class _ContentForm extends StatefulWidget {
  _ContentForm();
  final passwordController = TextEditingController();
  final verifyPasswordController = TextEditingController();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();

  @override
  State<_ContentForm> createState() => _ContentFormState();
}

class _ContentFormState extends State<_ContentForm> {
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

class SaveButton extends ConsumerStatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController username;
  final TextEditingController email;
  final TextEditingController password;

  const SaveButton(
    this.username,
    this.email,
    this.password,
    this.formKey, {
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => SaveButtonState();
}

class SaveButtonState extends ConsumerState<SaveButton> {
  @override
  Widget build(BuildContext context) {
    final signInState = ref.watch(signInProvider);
    return switch (signInState) {
      AsyncData<UserModel?>(:final value) => GlassTextButton(
          onPressed: value != null
              ? null
              : () {
                  if (widget.formKey.currentState!.validate()) {
                    ref.read(signInProvider.notifier).signIn(
                          DadosLogin(
                            email: widget.email.text,
                            nomeUsuario: widget.username.text,
                            senha: widget.password.text,
                          ),
                          widget.formKey.currentContext!,
                        );
                  }
                },
          buttonLabel: 'Criar Conta',
        ),
      AsyncError(:final error) => Text('Error: $error'),
      _ => const GlassTextLoadingButton(),
    };
  }
}
