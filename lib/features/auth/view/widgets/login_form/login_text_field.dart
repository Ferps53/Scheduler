import 'package:flutter/material.dart';
import 'package:todo_list/core/core.dart';

class LoginTextField extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isSecret;
  final bool isDense;
  final double padding;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Widget? glassTextButton;

  const LoginTextField({
    super.key,
    required this.icon,
    required this.label,
    required this.isSecret,
    required this.controller,
    this.isDense = false,
    this.padding = 8,
    this.validator,
    this.glassTextButton,
  });

  @override
  State<LoginTextField> createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  bool isHidden = false;

  @override
  void initState() {
    super.initState();
    isHidden = widget.isSecret;
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: widget.padding),
      child: Column(
        children: [
          TextFormField(
            cursorColor: AppColors.infoColors.textColor,
            validator: widget.validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: widget.controller,
            obscureText: isHidden,
            decoration: InputDecoration(
              label: Text(widget.label),
              border: OutlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.infoColors.backgroundColor),
                borderRadius: BorderRadius.circular(16),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.infoColors.textColor),
                borderRadius: BorderRadius.circular(16),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.infoColors.textColor),
                borderRadius: BorderRadius.circular(16),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.danger.textColor),
                borderRadius: BorderRadius.circular(16),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.danger.textColor),
                borderRadius: BorderRadius.circular(16),
              ),
              labelStyle: TextStyle(color: AppColors.infoColors.textColor),
              prefixIcon: Icon(
                widget.icon,
                color: AppColors.infoColors.textColor,
              ),
              suffixIcon: widget.isSecret
                  ? IconButton(
                      onPressed: () {
                        setState(() => isHidden = !isHidden);
                      },
                      icon: Icon(
                          isHidden ? Icons.visibility : Icons.visibility_off),
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
