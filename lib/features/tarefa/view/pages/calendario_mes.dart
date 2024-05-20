import 'package:flutter/material.dart';
import 'package:scheduler/core/core.dart';

class CalendarioMes extends StatelessWidget {
  const CalendarioMes({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14),
      child: Center(
        child: SizedBox(
          height: 364,
          width: 364,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_back),
                  ),
                  Text(
                    "Julho - 2024",
                    style: TextStyle(
                      fontSize: 24,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_forward),
                  ),
                ],
              ),
              Expanded(
                child: GlassCard(
                  startGradient: 0.5,
                  endGradient: 0.2,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        color: context.colorScheme.primary,
                        child: const Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _DiaCalendario(dia: "D"),
                            _DiaCalendario(dia: "S"),
                            _DiaCalendario(dia: "T"),
                            _DiaCalendario(dia: "Q"),
                            _DiaCalendario(dia: "Q"),
                            _DiaCalendario(dia: "S"),
                            _DiaCalendario(dia: "S"),
                          ],
                        ),
                      ),
                      const _GridDias(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GridDias extends StatelessWidget {
  const _GridDias();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
        itemCount: 31,
        itemBuilder: (context, index) {
          index++;
          return GridTile(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Badge(
                child: GlassCard(
                  startGradient: 0.8,
                  endGradient: 0.3,
                  child: Center(
                    child: Text(
                      "$index",
                      style: TextStyle(
                        color: context.colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DiaCalendario extends StatelessWidget {
  final String dia;
  const _DiaCalendario({
    required this.dia,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      dia,
      style: TextStyle(color: context.colorScheme.onPrimary, fontSize: 18),
    );
  }
}
