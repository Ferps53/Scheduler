import 'package:scheduler/core/core.dart';
import 'package:scheduler/features/auth/auth.dart';

class BackgroundGradientScaffold extends StatelessWidget {
  const BackgroundGradientScaffold({
    super.key,
    required this.child,
    required this.appBarLabel,
    this.hideBackArrow = false,
  });

  final Widget child;
  final String appBarLabel;
  final bool hideBackArrow;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Background(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: !hideBackArrow,
            backgroundColor: Colors.transparent,
            foregroundColor: context.colorScheme.onPrimary,
            title: Text(
              appBarLabel,
              style: const TextStyle(fontSize: 24),
            ),
          ),
          body: child,
        )
      ],
    );
  }
}
