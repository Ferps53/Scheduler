import 'package:scheduler/core/core.dart';
import 'package:scheduler/features/auth/auth.dart';

class ConfirmEmailPage extends StatelessWidget {
  const ConfirmEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackgroundGradientScaffold(
      appBarLabel: 'Confirmação de email',
      child: Center(
        child: ConfirmEmailForm(),
      ),
    );
  }
}

class ConfirmEmailForm extends ConsumerStatefulWidget {
  const ConfirmEmailForm({
    super.key,
  });

  @override
  ConsumerState<ConfirmEmailForm> createState() => _ConfirmEmailFormState();
}

class _ConfirmEmailFormState extends ConsumerState<ConfirmEmailForm> {
  final _emailController = TextEditingController();
  final _codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: GlassCard(
        height: 240,
        child: Column(
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
            LoginTextField(
              icon: Icons.email,
              label: 'Email',
              isSecret: false,
              controller: _emailController,
            ),
            GlassTextButton(onPressed: () {}, buttonLabel: 'Enviar Email')
          ],
        ),
      ),
    );
  }
}
