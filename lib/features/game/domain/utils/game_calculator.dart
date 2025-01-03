import 'dart:math' as math;
import 'package:eco_tycoon/features/game/domain/models/planet_state.dart';
import 'package:eco_tycoon/features/game/domain/models/game_resources.dart';
import 'package:eco_tycoon/features/game/domain/models/resources.dart';

class GameCalculator {
  static const int BASE_POLLUTION_INCREASE = 2;
  static const double TREE_POLLUTION_REDUCTION = 0.5;
  static const int TREE_POINTS = 100;
  static const int POLLUTION_PENALTY = 2;
  static const int MAX_POLLUTION = 100;
  static const int MIN_TREES_FOR_VICTORY = 20;
  static const int MAX_POLLUTION_FOR_VICTORY = 30;
  static const int TIME_PENALTY_FACTOR = 5; // Points deducted per minute
  static const double TIME_RANDOMNESS_FACTOR = 0.1; // 10% random variation

  /// Calculates the game score based on number of trees, pollution level, and elapsed time
  static int calculateScore(int trees, int pollution, [int elapsedTimeInSeconds = 0]) {
    // Base score calculation
    final baseScore = math.max(0, (trees * TREE_POINTS) - (pollution * POLLUTION_PENALTY));
    
    if (elapsedTimeInSeconds == 0) {
      return baseScore; // For backward compatibility with tests
    }

    // Time penalty (reduces score over time)
    final minutesElapsed = elapsedTimeInSeconds / 60;
    final timePenalty = (minutesElapsed * TIME_PENALTY_FACTOR).round();
    
    // Random factor based on time (±10% variation)
    final random = math.Random();
    final randomFactor = 1.0 + (random.nextDouble() * 2 - 1) * TIME_RANDOMNESS_FACTOR;
    
    // Calculate final score with time penalty and random factor
    final timeAdjustedScore = (baseScore * math.max(0.1, 1.0 - timePenalty / 100));
    final finalScore = (timeAdjustedScore * randomFactor).round();
    
    return math.max(0, finalScore); // Ensure score doesn't go negative
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
      water: WaterResource(amount: math.min(100, current.water.amount + regenerationRate)),
      energy: EnergyResource(amount: math.min(100, current.energy.amount + regenerationRate)),
      soil: SoilResource(amount: math.min(100, current.soil.amount + regenerationRate)),
    );
  }

  /// Calculates resource cost for planting a tree
  static GameResources calculateTreePlantingCost(GameResources current) {
    return current.copyWith(
      water: WaterResource(amount: current.water.amount - 10),
      energy: EnergyResource(amount: current.energy.amount - 5),
      soil: SoilResource(amount: current.soil.amount - 5),
    );
  }

  /// Calculates resource cost for cleaning pollution
  static GameResources calculatePollutionCleaningCost(GameResources current) {
    return current.copyWith(
      water: WaterResource(amount: current.water.amount - 5),
      energy: EnergyResource(amount: current.energy.amount - 10),
      soil: current.soil,
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
    if (!isPlaying || currentGameOver) {
      return {'gameOver': false, 'victory': false};
    }

    // Victory conditions
    if (treeCount >= MIN_TREES_FOR_VICTORY && pollution <= MAX_POLLUTION_FOR_VICTORY) {
      return {'gameOver': true, 'victory': true};
    }

    // Defeat conditions
    if (pollution >= MAX_POLLUTION) {
      return {'gameOver': true, 'victory': false};
    }

    return {'gameOver': false, 'victory': false};
  }
}
