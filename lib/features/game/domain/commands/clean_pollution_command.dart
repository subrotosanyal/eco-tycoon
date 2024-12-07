import 'package:flutter/material.dart';
import 'package:eco_tycoon/features/game/domain/commands/game_command.dart';
import 'package:eco_tycoon/features/game/domain/providers/game_provider.dart';
import 'package:eco_tycoon/features/game/domain/models/game_state.dart';
import 'package:eco_tycoon/features/game/domain/utils/game_calculator.dart';
import 'package:eco_tycoon/core/services/logger_service.dart';

class CleanPollutionCommand implements GameCommand {
  final GameNotifier gameNotifier;
  final GameState gameState;

  CleanPollutionCommand(this.gameNotifier, this.gameState);

  @override
  String get name => 'clean_pollution';

  @override
  String get label => 'Clean';

  @override
  IconData get icon => Icons.cleaning_services;

  @override
  Color get color => Colors.blue;

  @override
  bool get isEnabled => 
    gameState.isPlaying && gameState.resources.canCleanPollution();

  @override
  Future<void> execute() async {
    if (!isEnabled) return;

    LoggerService.info('Cleaning pollution');

    final newResources = GameCalculator.calculatePollutionCleaningCost(gameState.resources);
    final newPollution = GameCalculator.calculatePollutionReduction(gameState.planetState.pollution);
    final treeCount = gameState.treePositions.length;
    final newScore = GameCalculator.calculateScore(treeCount, newPollution);
    final newLevel = GameCalculator.calculatePlanetLevel(treeCount, newPollution);

    final newPlanetState = gameState.planetState.copyWith(
      pollution: newPollution,
      trees: treeCount,
      score: newScore,
      level: newLevel,
    );

    final newState = gameState.copyWith(
      resources: newResources,
      planetState: newPlanetState,
    );

    gameNotifier.updateState(newState);
  }
}
