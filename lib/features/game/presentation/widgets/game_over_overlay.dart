import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/providers/game_provider.dart';
import '../screens/start_screen.dart';

class GameOverOverlay extends ConsumerWidget {
  final bool victory;
  
  const GameOverOverlay({super.key, required this.victory});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameNotifierProvider);
    
    if (!gameState.gameOver) return const SizedBox.shrink();

    return Container(
      color: Colors.black.withOpacity(0.8),
      child: Center(
        child: Card(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  victory ? 'Victory!' : 'Game Over',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  victory 
                      ? 'You have successfully restored the planet!'
                      : 'The planet could not be saved...',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Final Score: ${gameState.planetState.score}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Trees Planted: ${gameState.planetState.trees}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Pollution Level: ${gameState.planetState.pollution}%',
                  style: TextStyle(
                    color: gameState.planetState.pollution > 80
                        ? Colors.red
                        : gameState.planetState.pollution > 60
                            ? Colors.orange
                            : Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    ref.read(gameNotifierProvider.notifier).startGame();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const StartScreen(),
                      ),
                    );
                  },
                  child: const Text('Back to Start'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
