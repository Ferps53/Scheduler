import 'package:flutter/material.dart';
import 'package:scheduler/core/core.dart';

class CalendarDay extends StatelessWidget {
  final int dayNumber;
  final int tasksQuantity;
  const CalendarDay({
    super.key,
    required this.dayNumber,
    required this.tasksQuantity,
  });

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Badge(
          isLabelVisible: false,
          child: GlassCard(
            startGradient: 0.8,
            endGradient: 0.3,
            child: Center(
              child: Text(
                '$dayNumber',
                style: TextStyle(
                  color: context.colorScheme.onPrimaryContainer,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
