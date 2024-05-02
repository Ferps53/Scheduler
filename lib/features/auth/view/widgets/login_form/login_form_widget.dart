import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scheduler/core/core.dart';
import 'package:scheduler/core/presentation/presentation.dart';
import 'package:scheduler/features/auth/auth.dart';
import 'package:scheduler/features/auth/view/providers/auth_notifier.dart';
import 'package:scheduler/features/auth/view/widgets/login_form/login_text_field.dart';

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
              const SizedBox(
                height: 4,
              ),
              FormBody(
                formKey: formKey,
                formContext: context,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FormBody extends StatelessWidget {
  const FormBody({
    super.key,
    required this.formKey,
    required this.formContext,
  });

  final BuildContext formContext;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      height: 296,
      backgroundColor: AppColors.infoColors.backgroundColor,
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              const _EmailField(),
              const SizedBox(
                height: 8,
              ),
              const _PasswordField(),
              const Spacer(),
              LoginButton(formContext: formContext),
            ],
          ),
        ),
      ),
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField();

  @override
  Widget build(BuildContext context) {
    return LoginTextField(
      glassTextButton: Container(
        alignment: Alignment.topRight,
        child: GlassTextButton(
          onPressed: () {},
          buttonLabel: 'Esqueceu a senha?',
          colors: AppColors.infoColors,
          textSize: 12,
        ),
      ),
      icon: Icons.lock,
      label: 'Senha',
      isSecret: true,
      controller: TextEditingController(),
      validator: (String? senha) {
        if (senha == null || senha.isEmpty) {
          return 'Digite sua senha';
        }
        if (senha.length < 6) {
          return 'Digite uma senha maior';
        }
        return null;
      },
    );
  }
}

class _EmailField extends StatelessWidget {
  const _EmailField();

  @override
  Widget build(BuildContext context) {
    return LoginTextField(
      icon: Icons.email,
      label: 'Email',
      isSecret: false,
      controller: TextEditingController(),
      validator: (String? email) {
        if (email == null || email.isEmpty) {
          return 'Escreva seu email de acesso';
        }
        if (!email.contains('@')) {
          return 'Email inválido';
        }
        return null;
      },
    );
  }
}

class LoginButton extends ConsumerWidget {
  const LoginButton({super.key, required this.formContext});

  final BuildContext formContext;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginAsyncNotifierProvider);
    return loginState.when(
      data: (data) => LoginButtonWithAction(formContext: formContext),
      error: (_, __) => LoginButtonWithAction(formContext: formContext),
      loading: () => const GlassTextLoadingButton(colors: AppColors.infoColors),
    );
  }
}

class LoginButtonWithAction extends ConsumerWidget {
  const LoginButtonWithAction({
    super.key,
    required this.formContext,
  });

  final BuildContext formContext;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GlassTextButton(
      onPressed: () async {
        ref.read(loginAsyncNotifierProvider.notifier).login(
              const DadosLogin(
                nomeUsuario: "",
                email: 'teste7@gmail.com',
                senha: '123453',
              ),
              formContext,
            );
      },
      buttonLabel: 'Entrar',
      colors: AppColors.infoColors,
      textSize: 24,
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
      height: 80,
      child: GlassCard(
        backgroundColor: AppColors.infoColors.textColor,
        child: const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 72,
              child: Image(
                image: AssetImage('assets/icons/calendar.png'),
              ),
            ),
            Text(
              'Scheduler',
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
