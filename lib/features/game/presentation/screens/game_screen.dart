import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eco_tycoon/features/game/domain/providers/game_provider.dart';
import 'package:eco_tycoon/features/game/presentation/widgets/game_controls.dart';
import 'package:eco_tycoon/features/game/presentation/widgets/game_over_overlay.dart';
import 'package:eco_tycoon/features/game/presentation/widgets/game_stats.dart';
import 'package:eco_tycoon/features/game/presentation/widgets/resource_panel.dart';
import 'package:eco_tycoon/features/game/presentation/widgets/planet_view.dart';

class GameScreen extends ConsumerWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameNotifierProvider);

    return WillPopScope(
      onWillPop: () async {
        ref.read(gameNotifierProvider.notifier).pauseGame();
        return true;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF1A237E), // Deep blue
                    Color(0xFF000051), // Even deeper blue
                  ],
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    // Top bar with stats and controls
                    Card(
                      margin: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            if (constraints.maxWidth < 600) {
                              return const Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GameStats(),
                                  Divider(height: 16, thickness: 1),
                                  GameControls(),
                                ],
                              );
                            }
                            return const Row(
                              children: [
                                Expanded(child: GameStats()),
                                SizedBox(width: 16),
                                GameControls(),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    // Main game area
                    Expanded(
                      child: Card(
                        margin: const EdgeInsets.fromLTRB(8, 4, 8, 8),
                        child: Column(
                          children: [
                            const Expanded(child: PlanetView()),
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: Colors.grey.shade800,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8),
                                child: ResourcePanel(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (gameState.gameOver) GameOverOverlay(victory: gameState.victory),
          ],
        ),
      ),
    );
  }
}
