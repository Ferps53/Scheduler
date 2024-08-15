import 'package:flutter_animate/flutter_animate.dart';
import 'package:scheduler/core/core.dart';
import 'package:scheduler/features/auth/auth.dart';

class LoginForm extends ConsumerWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Center(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          alignment: Alignment.center,
          child: Column(
            children: [
              const AppLogo()
                  .animate()
                  .fade(
                    duration: 400.ms,
                    begin: 0,
                    end: 1,
                    curve: Curves.easeInOut,
                  )
                  .scale(
                    curve: Curves.easeInOut,
                  ),
              const SizedBox(
                height: 4,
              ),
              FormBody(
                formKey: formKey,
                formContext: context,
              )
                  .animate()
                  .fade(
                    duration: 400.ms,
                    begin: 0,
                    end: 1,
                    curve: Curves.easeInOut,
                  )
                  .scale(
                    curve: Curves.easeInOut,
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
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    return GlassCard(
      height: 296,
      backgroundColor: context.colorScheme.primaryContainer,
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              _EmailField(emailController),
              const SizedBox(
                height: 8,
              ),
              _PasswordField(passwordController),
              const Spacer(),
              LoginButton(
                formContext: formContext,
                emailController,
                passwordController,
                formKey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField(this.passwordController);

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      glassTextButton: const _ButtonRowPassword(),
      icon: Icons.lock,
      label: 'Senha',
      isSecret: true,
      controller: passwordController,
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

class _ButtonRowPassword extends StatelessWidget {
  const _ButtonRowPassword();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GlassTextButton.moreTransparent(
            onPressed: () {
              context.pushNamed(NamedRoutes.createAccount.routeName);
            },
            buttonLabel: 'Criar Conta',
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Expanded(
          child: GlassTextButton.moreTransparent(
            onPressed: () {
              context.pushNamed(NamedRoutes.forgotPassword.routeName);
            },
            buttonLabel: 'Esqueceu a senha?',
            textSize: 12,
          ),
        ),
      ],
    );
  }
}

class _EmailField extends StatelessWidget {
  const _EmailField(this.emailController);
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      icon: Icons.email,
      label: 'Email',
      isSecret: false,
      controller: emailController,
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
  const LoginButton(this.emailController, this.passwordController, this.formKey,
      {super.key, required this.formContext});

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final BuildContext formContext;
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginAsyncNotifierProvider);
    return loginState.when(
      data: (data) => LoginButtonWithAction(
        formKey,
        formContext: formContext,
        passwordController: passwordController,
        emailController: emailController,
      ),
      error: (_, __) => LoginButtonWithAction(
        formKey,
        formContext: formContext,
        passwordController: passwordController,
        emailController: emailController,
      ),
      loading: () => const GlassTextLoadingButton(),
    );
  }
}

class LoginButtonWithAction extends ConsumerWidget {
  const LoginButtonWithAction(
    this.formKey, {
    super.key,
    required this.formContext,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController passwordController;
  final TextEditingController emailController;
  final BuildContext formContext;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GlassTextButton(
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          ref.read(loginAsyncNotifierProvider.notifier).login(
                LoginData(
                  username: '',
                  email: emailController.text,
                  password: passwordController.text,
                ),
                formContext,
              );
        }
      },
      buttonLabel: 'Entrar',
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
        backgroundColor: context.colorScheme.primary,
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
              'Agenda',
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
