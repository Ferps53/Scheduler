import 'package:scheduler/core/core.dart';
import 'package:scheduler/features/auth/auth.dart';
import 'package:scheduler/features/auth/view/providers/sign_in_notifier.dart';

class SaveButton extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final signInState = ref.watch(signInProvider);

    ref.listen(signInProvider, (previous, next) {
      if (next.hasError && !next.isLoading) {
        showDialog(
            context: context,
            builder: (_) {
              final error = next.error as Map<String, Object?>;
              final String message = error['message'] as String;

              return ErrorDialog(
                message: message,
                title: 'Ocorreu um erro',
              );
            });
      }
      if (next.hasValue && !next.isLoading) {
        context.goNamed(NamedRoutes.confirmEmail.routeName);
      }
    });

    return switch (signInState) {
      AsyncLoading() => const GlassTextLoadingButton(),
      _ => GlassTextButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              ref.read(signInProvider.notifier).signIn(
                    DadosLogin(
                      email: email.text,
                      nomeUsuario: username.text,
                      senha: password.text,
                    ),
                    formKey.currentContext!,
                  );
            }
          },
          buttonLabel: 'Criar Conta',
          textSize: 24,
        ),
    };
  }
}
