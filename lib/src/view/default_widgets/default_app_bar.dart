import 'package:flutter/material.dart';
import 'package:todo_list/src/styles/app_colors.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String label;
  final bool? implyLeading;
  final List<Widget>? actions;

  const DefaultAppBar(
      {required this.label, super.key, this.implyLeading, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: FittedBox(
        child: Text(label),
      ),
      elevation: 2,
      shadowColor: Colors.black54,
      automaticallyImplyLeading: implyLeading ?? true,
      foregroundColor: Colors.white,
      backgroundColor: AppColors.infoColors.baseColor,
      centerTitle: true,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
