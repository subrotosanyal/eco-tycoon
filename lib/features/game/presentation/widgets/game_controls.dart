import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eco_tycoon/features/game/domain/providers/game_provider.dart';
import 'package:eco_tycoon/features/game/domain/commands/game_command_factory.dart';
import 'package:eco_tycoon/features/game/domain/models/tree_position.dart';
import 'dart:math';

class GameControls extends ConsumerWidget {
  const GameControls({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameNotifierProvider);
    final gameNotifier = ref.read(gameNotifierProvider.notifier);
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    final commands = GameCommandFactory.createCommands(gameNotifier, gameState);
    
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: [
        // Pause/Resume button
        IconButton(
          onPressed: () {
            if (gameState.isPlaying) {
              gameNotifier.pauseGame();
            } else {
              gameNotifier.resumeGame();
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
          onPressed: () => gameNotifier.startGame(),
          icon: const Icon(Icons.refresh, size: 20),
          style: IconButton.styleFrom(
            backgroundColor: Colors.grey.shade800,
            padding: const EdgeInsets.all(8),
          ),
        ),
        const SizedBox(width: 8),
        ...commands.map((command) => ElevatedButton.icon(
          onPressed: command.isEnabled ? () {
            if (command.name == 'plant_tree') {
              final position = TreePosition(
                x: -0.5 + Random().nextDouble(),
                y: -0.5 + Random().nextDouble(),
              );
              final plantCommand = GameCommandFactory.createPlantTreeCommand(
                gameNotifier, 
                gameState, 
                position
              );
              plantCommand.execute();
            } else {
              command.execute();
            }
          } : null,
          icon: Icon(command.icon, size: 18),
          label: Text(
            command.label,
            style: TextStyle(fontSize: isSmallScreen ? 14 : 16),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: command.color,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 12 : 16,
              vertical: 8,
            ),
          ),
        )),
      ],
    );
  }
}
