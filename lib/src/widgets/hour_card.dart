import 'package:flutter/material.dart';

class HourCard extends StatelessWidget {
  const HourCard({
    super.key,
    required this.horas,
    required this.minutos,
  });

  final String horas;
  final String minutos;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              child: Text(
                "$horas:$minutos",
                style: const TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(
                Icons.query_builder,
                size: 30,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
