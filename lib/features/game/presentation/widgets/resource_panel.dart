import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eco_tycoon/features/game/domain/providers/game_provider.dart';

class ResourcePanel extends ConsumerWidget {
  const ResourcePanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameNotifierProvider);
    final resources = gameState.resources;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildResourceIndicator(
            icon: resources.water.icon,
            color: Colors.blue,
            value: resources.water.amount,
          ),
          _buildResourceIndicator(
            icon: resources.energy.icon,
            color: Colors.yellow,
            value: resources.energy.amount,
          ),
          _buildResourceIndicator(
            icon: resources.soil.icon,
            color: Colors.brown,
            value: resources.soil.amount,
          ),
        ],
      ),
    );
  }

  Widget _buildResourceIndicator({
    required IconData icon,
    required Color color,
    required int value,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: color,
          size: 20,
        ),
        const SizedBox(width: 4),
        Text(
          value.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
