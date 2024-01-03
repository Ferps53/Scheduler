import 'package:flutter/material.dart';

class DefaultDialog extends StatelessWidget {
  final String headerLabel;
  final List<Widget> actions;
  final Widget content;

  const DefaultDialog(
      {required this.headerLabel,
      required this.content,
      required this.actions,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            elevation: 8,
            shadowColor: Colors.black54,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xff03A9F4),
            title: Text(headerLabel),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            constraints: const BoxConstraints(minHeight: 100),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: content,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: actions,
          )
        ],
      ),
    );
  }
}
