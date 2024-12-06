import 'dart:math' as math;
import 'package:eco_tycoon/features/game/domain/models/planet_state.dart';
import 'package:eco_tycoon/features/game/domain/models/game_resources.dart';

class GameCalculator {
  static const int BASE_POLLUTION_INCREASE = 2;
  static const double TREE_POLLUTION_REDUCTION = 0.5;
  static const int TREE_POINTS = 100;
  static const int POLLUTION_PENALTY = 2;
  static const int MAX_POLLUTION = 100;
  static const int MIN_TREES_FOR_VICTORY = 20;
  static const int MAX_POLLUTION_FOR_VICTORY = 30;

  /// Calculates the game score based on number of trees and pollution level
  static int calculateScore(int trees, int pollution) {
    return (trees * TREE_POINTS) - (pollution * POLLUTION_PENALTY);
  }

  /// Determines the planet level based on trees and pollution
  static PlanetLevel calculatePlanetLevel(int trees, int pollution) {
    // Pollution takes precedence over tree count
    if (pollution >= 80) return PlanetLevel.dying;
    if (pollution >= 60) return PlanetLevel.polluted;

    // Tree count determines level if pollution is under control
    if (trees >= PlanetLevel.thriving.scoreMultiplier) {
      return PlanetLevel.thriving;
    }
    if (trees >= PlanetLevel.growing.scoreMultiplier) {
      return PlanetLevel.growing;
    }
    if (trees >= PlanetLevel.developing.scoreMultiplier) {
      return PlanetLevel.developing;
    }
    return PlanetLevel.barren;
  }

  /// Calculates new pollution level based on current state
  static int calculatePollutionChange(int currentPollution, int treeCount) {
    int pollutionChange = BASE_POLLUTION_INCREASE;
    pollutionChange -= (treeCount * TREE_POLLUTION_REDUCTION).round();

    return math.min(
        MAX_POLLUTION, math.max(0, currentPollution + pollutionChange));
  }

  /// Updates resources based on current state and tree count
  static GameResources updateResources(GameResources current, int treeCount) {
    final regenerationRate = 1 + (treeCount * 0.1).round();

    return current.copyWith(
      water: math.min(100, current.water + regenerationRate),
      energy: math.min(100, current.energy + regenerationRate),
      soil: math.min(100, current.soil + regenerationRate),
    );
  }

  /// Calculates resource cost for planting a tree
  static GameResources calculateTreePlantingCost(GameResources current) {
    return current.copyWith(
      water: current.water - 10,
      energy: current.energy - 5,
      soil: current.soil - 5,
    );
  }

  /// Calculates resource cost for cleaning pollution
  static GameResources calculatePollutionCleaningCost(GameResources current) {
    return current.copyWith(
      water: current.water - 5,
      energy: current.energy - 10,
    );
  }

  /// Calculates pollution reduction from cleaning action
  static int calculatePollutionReduction(int currentPollution) {
    return math.max(0, currentPollution - 10);
  }

  /// Checks if the game is over and determines if it's a victory or defeat
  static Map<String, bool> checkGameState({
    required bool isPlaying,
    required bool currentGameOver,
    required int pollution,
    required int treeCount,
  }) {
    // Don't check if game is already over
    if (currentGameOver) {
      return {'gameOver': true, 'victory': false};
    }

    // Check pollution regardless of game state
    if (pollution >= MAX_POLLUTION) {
      return {'gameOver': true, 'victory': false};
    }

    // Only check victory conditions if game is playing
    if (isPlaying &&
        treeCount >= MIN_TREES_FOR_VICTORY &&
        pollution < MAX_POLLUTION_FOR_VICTORY) {
      return {'gameOver': true, 'victory': true};
    }

    return {'gameOver': false, 'victory': false};
  }
}
