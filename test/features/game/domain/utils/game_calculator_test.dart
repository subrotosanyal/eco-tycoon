import 'package:flutter_test/flutter_test.dart';
import 'package:eco_tycoon/features/game/domain/models/planet_state.dart';
import 'package:eco_tycoon/features/game/domain/models/game_resources.dart';
import 'package:eco_tycoon/features/game/domain/utils/game_calculator.dart';

void main() {
  group('GameCalculator', () {
    test('calculateScore returns correct score based on trees and pollution',
        () {
      expect(
          GameCalculator.calculateScore(10, 20), 960); // (10 * 100) - (20 * 2)
      expect(GameCalculator.calculateScore(0, 0), 0);
      expect(GameCalculator.calculateScore(5, 50), 400); // (5 * 100) - (50 * 2)
    });

    group('calculatePlanetLevel', () {
      test('returns correct level based on pollution', () {
        expect(
          GameCalculator.calculatePlanetLevel(10, 80),
          PlanetLevel.dying,
        );
        expect(
          GameCalculator.calculatePlanetLevel(10, 60),
          PlanetLevel.polluted,
        );
      });

      test('returns correct level based on trees when pollution is low', () {
        expect(
          GameCalculator.calculatePlanetLevel(20, 30),
          PlanetLevel.thriving,
        );
        expect(
          GameCalculator.calculatePlanetLevel(15, 30),
          PlanetLevel.growing,
        );
        expect(
          GameCalculator.calculatePlanetLevel(10, 30),
          PlanetLevel.developing,
        );
        expect(
          GameCalculator.calculatePlanetLevel(5, 30),
          PlanetLevel.barren,
        );
      });
    });

    test('calculatePollutionChange handles tree reduction correctly', () {
      expect(
        GameCalculator.calculatePollutionChange(50, 4),
        50, // Base increase of 2, reduction of 2 from trees
      );
      expect(
        GameCalculator.calculatePollutionChange(50, 8),
        48, // Base increase of 2, reduction of 4 from trees
      );
      expect(
        GameCalculator.calculatePollutionChange(98, 0),
        100, // Should not exceed MAX_POLLUTION
      );
      expect(
        GameCalculator.calculatePollutionChange(2, 20),
        0, // Should not go below 0
      );
    });

    group('resource calculations', () {
      const initialResources = GameResources(
        water: 50,
        energy: 50,
        soil: 50,
      );

      test('updateResources regenerates resources based on tree count', () {
        final updated = GameCalculator.updateResources(initialResources, 5);
        expect(updated.water, 52);
        expect(updated.energy, 52);
        expect(updated.soil, 52);

        // Test max cap
        const maxResources = GameResources(
          water: 99,
          energy: 99,
          soil: 99,
        );
        final maxUpdated = GameCalculator.updateResources(maxResources, 20);
        expect(maxUpdated.water, 100);
        expect(maxUpdated.energy, 100);
        expect(maxUpdated.soil, 100);
      });

      test('calculateTreePlantingCost deducts correct resources', () {
        final afterPlanting =
            GameCalculator.calculateTreePlantingCost(initialResources);
        expect(afterPlanting.water, 40);
        expect(afterPlanting.energy, 45);
        expect(afterPlanting.soil, 45);
      });

      test('calculatePollutionCleaningCost deducts correct resources', () {
        final afterCleaning =
            GameCalculator.calculatePollutionCleaningCost(initialResources);
        expect(afterCleaning.water, 45);
        expect(afterCleaning.energy, 40);
        expect(afterCleaning.soil, 50); // Unchanged
      });
    });

    test('calculatePollutionReduction reduces pollution correctly', () {
      expect(GameCalculator.calculatePollutionReduction(50), 40);
      expect(GameCalculator.calculatePollutionReduction(5), 0);
      expect(GameCalculator.calculatePollutionReduction(0), 0);
    });

    group('checkGameState', () {
      test('returns game over with defeat when pollution is too high', () {
        final result = GameCalculator.checkGameState(
          isPlaying: true,
          currentGameOver: false,
          pollution: GameCalculator.MAX_POLLUTION,
          treeCount: 10,
        );
        expect(result['gameOver'], isTrue);
        expect(result['victory'], isFalse);
      });

      test('returns victory when conditions are met', () {
        final result = GameCalculator.checkGameState(
          isPlaying: true,
          currentGameOver: false,
          pollution: GameCalculator.MAX_POLLUTION_FOR_VICTORY - 1,
          treeCount: GameCalculator.MIN_TREES_FOR_VICTORY,
        );
        expect(result['gameOver'], isTrue);
        expect(result['victory'], isTrue);
      });

      test('maintains current game over state', () {
        final result = GameCalculator.checkGameState(
          isPlaying: true,
          currentGameOver: true,
          pollution: 0,
          treeCount: GameCalculator.MIN_TREES_FOR_VICTORY,
        );
        expect(result['gameOver'], isTrue);
        expect(result['victory'], isFalse);
      });

      test('continues game when conditions are not met', () {
        final result = GameCalculator.checkGameState(
          isPlaying: true,
          currentGameOver: false,
          pollution: 50,
          treeCount: 10,
        );
        expect(result['gameOver'], isFalse);
        expect(result['victory'], isFalse);
      });
    });
  });
}
