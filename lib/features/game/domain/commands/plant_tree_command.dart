import 'package:flutter/material.dart';
import 'package:eco_tycoon/features/game/domain/commands/game_command.dart';
import 'package:eco_tycoon/features/game/domain/models/tree_position.dart';
import 'package:eco_tycoon/features/game/domain/providers/game_provider.dart';
import 'package:eco_tycoon/features/game/domain/models/game_state.dart';
import 'package:eco_tycoon/features/game/domain/utils/game_calculator.dart';
import 'package:eco_tycoon/features/game/domain/utils/tree_placement_calculator.dart';
import 'package:eco_tycoon/core/services/logger_service.dart';

class PlantTreeCommand implements GameCommand {
  final GameNotifier gameNotifier;
  final GameState gameState;
  final TreePosition position;

  PlantTreeCommand(this.gameNotifier, this.gameState, this.position);

  @override
  String get name => 'plant_tree';

  @override
  String get label => 'Plant Tree';

  @override
  IconData get icon => Icons.park;

  @override
  Color get color => Colors.green;

  @override
  bool get isEnabled =>
      gameState.isPlaying && gameState.resources.canPlantTree();

  @override
  Future<void> execute() async {
    if (!isEnabled ||
        !TreePlacementCalculator.isValidTreePosition(
            position, gameState.treePositions)) {
      LoggerService.info(
          'Cannot plant tree: isPlaying=${gameState.isPlaying}, gameOver=${gameState.gameOver}, canPlantTree=${gameState.resources.canPlantTree()}');
      return;
    }

    LoggerService.info(
        'Planting tree at position: (${position.x}, ${position.y})');

    // Update tree positions and resources
    final newTreePositions = [...gameState.treePositions, position];
    final newResources =
        GameCalculator.calculateTreePlantingCost(gameState.resources);

    // Calculate new planet state
    final treeCount = newTreePositions.length;
    final currentPollution = gameState.planetState.pollution;
    final newScore = GameCalculator.calculateScore(treeCount, currentPollution);
    final newLevel =
        GameCalculator.calculatePlanetLevel(treeCount, currentPollution);

    LoggerService.info(
        'Tree count: $treeCount, Level: $newLevel, Score: $newScore');

    final newPlanetState = gameState.planetState.copyWith(
      trees: treeCount,
      score: newScore,
      level: newLevel,
    );

    final newState = gameState.copyWith(
      resources: newResources,
      treePositions: newTreePositions,
      planetState: newPlanetState,
    );

    gameNotifier.updateState(newState);
  }
}
