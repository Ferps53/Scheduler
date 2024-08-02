import 'package:scheduler/core/core.dart';
import 'package:scheduler/features/auth/auth.dart';
import 'package:scheduler/features/auth/view/providers/confirmation_email_provider.dart';

final _formKey = GlobalKey<FormState>();

class ConfirmEmailPage extends StatelessWidget {
  const ConfirmEmailPage({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: BackgroundGradientScaffold(
        hideBackArrow: true,
        appBarLabel: 'Confirmação de email',
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: ConfirmEmailForm(email),
          ),
        ),
      ),
    );
  }
}

class ConfirmEmailForm extends ConsumerStatefulWidget {
  const ConfirmEmailForm(
    this.email, {
    super.key,
  });

  final String? email;

  @override
  ConsumerState<ConfirmEmailForm> createState() => _ConfirmEmailFormState();
}

class _ConfirmEmailFormState extends ConsumerState<ConfirmEmailForm> {
  final _emailController = TextEditingController();
  final _codeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.email != null) {
      _emailController.text = widget.email!;
      Future(() => ref.read(confirmationEmailState.notifier).add());
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int step = ref.watch(confirmationEmailState);
    return Form(
      key: _formKey,
      child: GlassCard(
        height: 240,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: step == 0
              ? _EmailStep(emailController: _emailController)
              : _CodeStep(
                  codeController: _codeController,
                  emailController: _emailController,
                ),
        ),
      ),
    );
  }
}

class _CodeStep extends ConsumerWidget {
  const _CodeStep({
    required TextEditingController emailController,
    required TextEditingController codeController,
  })  : _codeController = codeController,
        _emailController = emailController;

  final TextEditingController _codeController;
  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Confirme seu email',
          style: context.headlineMedium,
        ),
        const Text(
          'Insira seu código, que foi enviado em seu email, no campo abaixo',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        CustomTextField(
          icon: Icons.lock,
          label: 'Código',
          isSecret: false,
          controller: _codeController,
          diposeController: false,
        ),
        _SaveButton(
            codeController: _codeController, emailController: _emailController),
      ],
    );
  }
}

class _SaveButton extends ConsumerWidget {
  const _SaveButton({
    required TextEditingController codeController,
    required TextEditingController emailController,
  })  : _codeController = codeController,
        _emailController = emailController;

  final TextEditingController _codeController;
  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final confirmationState = ref.watch(confirmationEmailProvider);
    final retryCount = ref.watch(emailConfirmationRetryCountProvider);

    ref.listen(confirmationEmailProvider, (previous, next) {
      if (next.hasError && !next.isLoading) {
        showDialog(
            context: context,
            builder: (_) {
              try {
                Future(() => ref
                    .read(emailConfirmationRetryCountProvider.notifier)
                    .add());
                Map<String, Object?> error;
                error = next.error as Map<String, Object?>;
                final String message = error['message'] as String;
                final int statusCode = error['code'] as int;

                if (statusCode == 404 && retryCount >= 3) {
                  Future(() =>
                      ref.read(confirmationEmailState.notifier).substract());
                }
                return ErrorDialog(
                  message: message,
                  title: 'Ocorreu um erro',
                );
              } catch (e) {
                return ErrorDialog(
                    title: 'Ocorreu um erro', message: e.toString());
              }
            });
      } else if (next.hasValue && !next.isLoading) {
        context.goNamed(NamedRoutes.login.routeName);
      }
    });

    return switch (confirmationState) {
      AsyncLoading() => const GlassTextLoadingButton(),
      _ => GlassTextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              await ref.read(confirmationEmailProvider.notifier).confirmEmail(
                    _codeController.text,
                    _emailController.text,
                  );
            }
          },
          buttonLabel: 'Enviar Código',
          textSize: 24,
        ),
    };
  }
}

class _EmailStep extends ConsumerWidget {
  const _EmailStep({
    required TextEditingController emailController,
  }) : _emailController = emailController;

  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Confirme seu email',
          style: context.headlineMedium,
        ),
        const Text(
          'Precisamos que digite seu email para te enviar um código de confirmação',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        CustomTextField(
          icon: Icons.email,
          label: 'Email',
          isSecret: false,
          controller: _emailController,
          diposeController: false,
        ),
        GlassTextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              await ref
                  .read(loginRepoProvider)
                  .resendEmail(_emailController.text);

              ref.read(confirmationEmailState.notifier).add();
            }
          },
          buttonLabel: 'Enviar Email',
          textSize: 24,
        )
      ],
    );
  }
}
