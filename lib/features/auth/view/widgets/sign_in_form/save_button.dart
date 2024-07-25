import 'package:scheduler/core/core.dart';
import 'package:scheduler/features/auth/auth.dart';
import 'package:scheduler/features/auth/view/providers/sign_in_notifier.dart';

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
  ConsumerState<ConsumerStatefulWidget> createState() => _SaveButtonState();
}

class _SaveButtonState extends ConsumerState<SaveButton> {
  @override
  Widget build(BuildContext context) {
    final signInState = ref.watch(signInProvider);

    ref.listen(signInProvider, (previous, next) {
      if (next.hasError && !next.isLoading) {
        showDialog(
            context: context,
            builder: (_) {
              try {
                Map<String, Object?> error;
                error = next.error as Map<String, Object?>;
                final String message = error['message'] as String;

                return ErrorDialog(
                  message: message,
                  title: 'Ocorreu um erro',
                );
              } catch (e) {
                return ErrorDialog(
                    title: 'Ocorreu um erro', message: e.toString());
              }
            });
      } else if (next.hasValue && next.value != null && !next.isLoading) {
        context.goNamed(NamedRoutes.confirmEmail.routeName,
            extra: widget.email.text);
      }
    });

    return switch (signInState) {
      AsyncLoading() => const GlassTextLoadingButton(),
      _ => GlassTextButton(
          onPressed: () {
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
          textSize: 24,
        ),
    };
  }
}
