import 'package:scheduler/core/core.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    super.key,
    required this.title,
    required this.message,
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: GlassCard(
        isFrosted: true,
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: context.headlineMedium,
              ),
              Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: GlassTextButton(
                  onPressed: context.pop,
                  buttonLabel: ' Ok ',
                  textSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
