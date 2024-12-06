import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/providers/game_provider.dart';

class ResourcePanel extends ConsumerWidget {
  const ResourcePanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameNotifierProvider);
    final resources = gameState.resources;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: _ResourceIndicator(
                  icon: Icons.water_drop,
                  color: Colors.blue,
                  value: resources.water,
                  label: 'Water',
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: _ResourceIndicator(
                  icon: Icons.bolt,
                  color: Colors.yellow,
                  value: resources.energy,
                  label: 'Energy',
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: _ResourceIndicator(
                  icon: Icons.landscape,
                  color: Colors.brown,
                  value: resources.soil,
                  label: 'Soil',
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ResourceIndicator extends StatelessWidget {
  final IconData icon;
  final Color color;
  final int value;
  final String label;

  const _ResourceIndicator({
    required this.icon,
    required this.color,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 2),
        FittedBox(
          child: Text(
            value.toString(),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 14,
            ),
          ),
        ),
        FittedBox(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
