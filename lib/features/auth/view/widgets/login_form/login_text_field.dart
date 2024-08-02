import 'package:scheduler/core/core.dart';

class CustomTextField extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isSecret;
  final bool isDense;
  final double padding;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Widget? glassTextButton;
  final bool diposeController;
  final bool readOnly;
  final VoidCallback? onTap;

  const CustomTextField({
    super.key,
    required this.icon,
    required this.label,
    required this.controller,
    this.isSecret = false,
    this.isDense = false,
    this.padding = 8,
    this.validator,
    this.glassTextButton,
    this.diposeController = true,
    this.readOnly = false,
    this.onTap,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isHidden = false;

  @override
  void initState() {
    super.initState();
    isHidden = widget.isSecret;
  }

  @override
  void dispose() {
    if (widget.diposeController) {
      widget.controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: widget.padding),
      child: Column(
        children: [
          TextFormField(
            onTap: widget.onTap,
            readOnly: widget.readOnly,
            cursorColor: context.colorScheme.primary,
            validator: widget.validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: widget.controller,
            obscureText: isHidden,
            decoration: InputDecoration(
              label: Text(widget.label),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: context.colorScheme.onPrimary),
                borderRadius: BorderRadius.circular(16),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: context.colorScheme.primary.withOpacity(.5),
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: context.colorScheme.primary),
                borderRadius: BorderRadius.circular(16),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: context.colorScheme.error),
                borderRadius: BorderRadius.circular(16),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: context.colorScheme.error),
                borderRadius: BorderRadius.circular(16),
              ),
              labelStyle: TextStyle(color: context.colorScheme.primary),
              prefixIcon: Icon(
                widget.icon,
                color: context.colorScheme.primary,
              ),
              suffixIcon: widget.isSecret
                  ? IconButton(
                      onPressed: () {
                        setState(() => isHidden = !isHidden);
                      },
                      icon: Icon(
                        isHidden ? Icons.visibility : Icons.visibility_off,
                        color: context.colorScheme.primary,
                      ),
                    )
                  : null,
            ),
          ),
          if (widget.glassTextButton != null) widget.glassTextButton as Widget
        ],
      ),
    );
  }
}
