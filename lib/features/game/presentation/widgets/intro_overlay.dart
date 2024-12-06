import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/providers/game_provider.dart';

class IntroOverlay extends ConsumerWidget {
  const IntroOverlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameNotifierProvider);
    final theme = Theme.of(context);

    // Don't show intro if game is in progress or finished
    if (gameState.isPlaying || gameState.gameOver) {
      return const SizedBox.shrink();
    }

    return Container(
      color: Colors.black87,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '🌍 Eco Tycoon',
              style: theme.textTheme.displayMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            _buildInstructionsCard(context),
            const SizedBox(height: 16),
            _buildResourcesCard(context),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => ref.read(gameNotifierProvider.notifier).startGame(),
              icon: const Icon(Icons.play_arrow),
              label: const Text('Start Game'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructionsCard(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Rules:',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              '1. Manage your resources wisely:\n'
              '   • Water (💧) - Used for planting trees\n'
              '   • Energy (⚡) - Used for cleaning pollution\n'
              '   • Soil (🌱) - Required for tree growth\n'
              '   • Research (📚) - Unlock upgrades\n\n'
              '2. Complete challenges to earn points\n'
              '   • Failed challenges will cost you points\n'
              '   • Keep track of time limits\n\n'
              '3. Watch out for:\n'
              '   • High pollution (>80%) severely reduces resource generation\n'
              '   • Trees can die when pollution is high\n'
              '   • You lose if pollution reaches 100%\n'
              '   • You also lose if you run out of trees and resources\n\n'
              '4. Victory condition:\n'
              '   • Reach and maintain Advanced planet level\n'
              '   • Survive for 3 minutes',
              style: theme.textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResourcesCard(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Resources:',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              '• Water (💧)\n'
              '• Energy (⚡)\n'
              '• Soil (🌱)\n'
              '• Research (📚)',
              style: theme.textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
