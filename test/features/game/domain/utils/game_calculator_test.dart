import 'package:eco_tycoon/features/game/domain/models/game_resources.dart';
import 'package:eco_tycoon/features/game/domain/models/planet_state.dart';
import 'package:eco_tycoon/features/game/domain/models/resources.dart';
import 'package:eco_tycoon/features/game/domain/utils/game_calculator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GameCalculator', () {
    test('calculateScore should return correct score', () {
      // Test basic score calculation
      expect(GameCalculator.calculateScore(10, 20), equals(960));
      expect(GameCalculator.calculateScore(5, 10), equals(480));

      // Test minimum score is 0
      expect(GameCalculator.calculateScore(0, 100), equals(0));
      expect(GameCalculator.calculateScore(0, 200), equals(0)); // Extreme case
      expect(
          GameCalculator.calculateScore(-10, 20), equals(0)); // Negative trees
      expect(GameCalculator.calculateScore(10, -20),
          equals(1040)); // Negative pollution treated as 0
    });

    test('calculatePlanetLevel should return correct level', () {
      // Test pollution-based levels
      expect(GameCalculator.calculatePlanetLevel(100, 90),
          equals(PlanetLevel.dying));
      expect(GameCalculator.calculatePlanetLevel(100, 70),
          equals(PlanetLevel.polluted));

      // Test tree-based levels
      expect(GameCalculator.calculatePlanetLevel(20, 20),
          equals(PlanetLevel.thriving));
      expect(GameCalculator.calculatePlanetLevel(15, 20),
          equals(PlanetLevel.growing));
      expect(GameCalculator.calculatePlanetLevel(10, 20),
          equals(PlanetLevel.developing));
      expect(GameCalculator.calculatePlanetLevel(5, 20),
          equals(PlanetLevel.barren));
    });

    test('calculatePollutionChange should return correct value', () {
      // Test pollution increase with no trees
      expect(GameCalculator.calculatePollutionChange(50, 0), equals(52));

      // Test pollution decrease with many trees
      expect(GameCalculator.calculatePollutionChange(50, 10), equals(47));

      // Test pollution limits
      expect(GameCalculator.calculatePollutionChange(100, 0), equals(100));
      expect(GameCalculator.calculatePollutionChange(0, 100), equals(0));
    });

    test('updateResources should regenerate resources correctly', () {
      const resources = GameResources(
        water: WaterResource(amount: 50),
        energy: EnergyResource(amount: 60),
        soil: SoilResource(amount: 70),
      );

      final updated = GameCalculator.updateResources(resources, 10);

      // Regeneration rate = 1 + (10 * 0.1) = 2
      expect(updated.water.amount, equals(52));
      expect(updated.energy.amount, equals(62));
      expect(updated.soil.amount, equals(72));
    });

    test('calculateTreePlantingCost should return correct cost', () {
      const resources = GameResources(
        water: WaterResource(amount: 100),
        energy: EnergyResource(amount: 100),
        soil: SoilResource(amount: 100),
      );

      final cost = GameCalculator.calculateTreePlantingCost(resources);

      expect(cost.water.amount, equals(90)); // 100 - 10
      expect(cost.energy.amount, equals(95)); // 100 - 5
      expect(cost.soil.amount, equals(95)); // 100 - 5
    });

    test('calculatePollutionCleaningCost should return correct cost', () {
      const resources = GameResources(
        water: WaterResource(amount: 100),
        energy: EnergyResource(amount: 100),
        soil: SoilResource(amount: 100),
      );

      final cost = GameCalculator.calculatePollutionCleaningCost(resources);

      expect(cost.water.amount, equals(95)); // 100 - 5
      expect(cost.energy.amount, equals(90)); // 100 - 10
      expect(cost.soil.amount, equals(100)); // Unchanged
    });

    test('calculatePollutionReduction should return correct value', () {
      expect(GameCalculator.calculatePollutionReduction(50), equals(40));
      expect(GameCalculator.calculatePollutionReduction(5), equals(0));
    });

    test('checkGameState should correctly identify victory and defeat', () {
      final result = GameCalculator.checkGameState(
        isPlaying: true,
        currentGameOver: false,
        treeCount: 10,
        pollution: 20,
      );
      expect(result['gameOver'], false);
      expect(result['victory'], false);

      final victoryResult = GameCalculator.checkGameState(
        isPlaying: true,
        currentGameOver: false,
        treeCount: 20,
        pollution: 10,
      );
      expect(victoryResult['gameOver'], true);
      expect(victoryResult['victory'], true);

      final defeatResult = GameCalculator.checkGameState(
        isPlaying: true,
        currentGameOver: false,
        treeCount: 5,
        pollution: 100,
      );
      expect(defeatResult['gameOver'], true);
      expect(defeatResult['victory'], false);
    });
  });
}
