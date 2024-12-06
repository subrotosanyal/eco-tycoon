import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eco_tycoon/features/game/domain/providers/game_provider.dart';
import 'package:eco_tycoon/features/game/domain/models/tree_position.dart';
import 'dart:math';

class GameControls extends ConsumerWidget {
  const GameControls({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameNotifierProvider);
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: [
        // Pause/Resume button
        IconButton(
          onPressed: () {
            if (gameState.isPlaying) {
              ref.read(gameNotifierProvider.notifier).pauseGame();
            } else {
              ref.read(gameNotifierProvider.notifier).resumeGame();
            }
          },
          icon: Icon(
            gameState.isPlaying ? Icons.pause : Icons.play_arrow,
            size: 20,
          ),
          style: IconButton.styleFrom(
            backgroundColor: Colors.grey.shade800,
            padding: const EdgeInsets.all(8),
          ),
        ),
        // Reset button
        IconButton(
          onPressed: () => ref.read(gameNotifierProvider.notifier).startGame(),
          icon: const Icon(Icons.refresh, size: 20),
          style: IconButton.styleFrom(
            backgroundColor: Colors.grey.shade800,
            padding: const EdgeInsets.all(8),
          ),
        ),
        const SizedBox(width: 8),
        // Plant Tree button
        ElevatedButton.icon(
          onPressed: (gameState.isPlaying && gameState.resources.canPlantTree())
              ? () {
                  final position = TreePosition(
                    x: -0.5 + Random().nextDouble(),
                    y: -0.5 + Random().nextDouble(),
                  );
                  ref.read(gameNotifierProvider.notifier).plantTree(position);
                }
              : null,
          icon: const Icon(Icons.park, size: 18),
          label: Text(
            'Plant Tree',
            style: TextStyle(fontSize: isSmallScreen ? 14 : 16),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 12 : 16,
              vertical: 8,
            ),
          ),
        ),
        // Clean button
        ElevatedButton.icon(
          onPressed: (gameState.isPlaying && gameState.resources.canCleanPollution())
              ? () => ref.read(gameNotifierProvider.notifier).cleanPollution()
              : null,
          icon: const Icon(Icons.cleaning_services, size: 18),
          label: Text(
            'Clean',
            style: TextStyle(fontSize: isSmallScreen ? 14 : 16),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 12 : 16,
              vertical: 8,
            ),
          ),
        ),
      ],
    );
  }
}
