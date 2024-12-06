import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eco_tycoon/features/game/domain/providers/game_provider.dart';

class GameStats extends ConsumerWidget {
  const GameStats({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameNotifierProvider);
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Wrap(
      spacing: isSmallScreen ? 12 : 24,
      runSpacing: 8,
      alignment: WrapAlignment.spaceEvenly,
      children: [
        _buildScoreRow(context, gameState.planetState.score),
        _buildPlanetLevelRow(context, gameState.planetState.level.name),
        _buildPollutionRow(context, gameState.planetState.pollution),
        _buildTreeCountRow(context, gameState.treePositions.length),
        _buildTimeRow(context, Duration(seconds: gameState.elapsedTime)),
      ],
    );
  }

  Widget _buildScoreRow(BuildContext context, int score) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.emoji_events, size: 18, color: Colors.amber),
        const SizedBox(width: 4),
        Text(
          '$score',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }

  Widget _buildPlanetLevelRow(BuildContext context, String level) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.terrain, size: 18, color: Colors.green),
        const SizedBox(width: 4),
        Text(
          level,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 16,
              ),
        ),
      ],
    );
  }

  Widget _buildPollutionRow(BuildContext context, int pollution) {
    final color = pollution > 80
        ? Colors.red
        : pollution > 60
            ? Colors.orange
            : pollution > 40
                ? Colors.yellow
                : Colors.green;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            Icon(Icons.cloud, size: 18, color: color),
            Icon(Icons.warning,
                size: 12, color: pollution > 60 ? color : Colors.transparent),
          ],
        ),
        const SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$pollution%',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 16,
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              pollution > 80
                  ? 'Critical!'
                  : pollution > 60
                      ? 'Dangerous'
                      : pollution > 40
                          ? 'Moderate'
                          : 'Safe',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 10,
                    color: color,
                  ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTreeCountRow(BuildContext context, int treeCount) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.park, size: 18, color: Colors.green.shade700),
        const SizedBox(width: 4),
        Text(
          '$treeCount',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }

  Widget _buildTimeRow(BuildContext context, Duration time) {
    final minutes = time.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = time.inSeconds.remainder(60).toString().padLeft(2, '0');

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.timer, size: 18, color: Colors.blue),
        const SizedBox(width: 4),
        Text(
          '$minutes:$seconds',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 16,
                fontFamily: 'monospace',
              ),
        ),
      ],
    );
  }
}
