import 'package:scheduler/core/core.dart';
import 'package:scheduler/features/auth/auth.dart';
import 'package:scheduler/features/auth/view/providers/sign_in_notifier.dart';

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
          child: ContentForm(),
        ),
      ),
    );
  }
}
