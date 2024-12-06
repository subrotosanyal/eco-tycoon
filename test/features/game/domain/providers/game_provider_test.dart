import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eco_tycoon/features/game/domain/providers/game_provider.dart';
import 'package:eco_tycoon/features/game/domain/models/game_state.dart';
import 'package:eco_tycoon/features/game/domain/models/tree_position.dart';
import 'package:eco_tycoon/features/game/domain/models/game_resources.dart';
import 'package:eco_tycoon/features/game/domain/models/planet_state.dart';

void main() {
  late ProviderContainer container;
  late GameNotifier gameNotifier;

  setUp(() {
    container = ProviderContainer();
    gameNotifier = container.read(gameNotifierProvider.notifier);
  });

  tearDown(() {
    container.dispose();
  });

  group('GameNotifier - Game State Management', () {
    test('initial state should be correct', () {
      final state = container.read(gameNotifierProvider);
      expect(state.isPlaying, false);
      expect(state.gameOver, false);
      expect(state.victory, false);
      expect(state.elapsedTime, 0);
      expect(state.treePositions, isEmpty);
    });

    test('startGame should initialize game correctly', () {
      gameNotifier.startGame();
      final state = container.read(gameNotifierProvider);
      expect(state.isPlaying, true);
      expect(state.gameOver, false);
      expect(state.victory, false);
      expect(state.elapsedTime, 0);
    });

    test('pauseGame should pause the game', () {
      gameNotifier.startGame();
      gameNotifier.pauseGame();
      final state = container.read(gameNotifierProvider);
      expect(state.isPlaying, false);
    });

    test('resumeGame should resume the game', () {
      gameNotifier.startGame();
      gameNotifier.pauseGame();
      gameNotifier.resumeGame();
      final state = container.read(gameNotifierProvider);
      expect(state.isPlaying, true);
    });
  });

  group('GameNotifier - Resource Management', () {
    test('planting tree should consume resources correctly', () {
      // Start with specific resource values
      final initialState = GameState.initial().copyWith(
        isPlaying: true,
        resources: const GameResources(water: 50, energy: 50, soil: 30),
      );
      container = ProviderContainer();
      gameNotifier = container.read(gameNotifierProvider.notifier)
        ..state = initialState;

      gameNotifier.plantTree(const TreePosition(x: 0, y: 0));
      final newState = container.read(gameNotifierProvider);

      expect(newState.resources.water, initialState.resources.water - 10);
      expect(newState.resources.energy, initialState.resources.energy - 5);
      expect(newState.resources.soil, initialState.resources.soil - 5);
    });

    test('should not plant tree when resources are insufficient', () {
      // Set resources to low values
      const lowResources = GameResources(water: 5, energy: 3, soil: 3);
      final initialState = GameState.initial().copyWith(
        isPlaying: true,
        resources: lowResources,
      );
      container = ProviderContainer();
      gameNotifier = container.read(gameNotifierProvider.notifier)
        ..state = initialState;

      gameNotifier.plantTree(const TreePosition(x: 0, y: 0));
      final newState = container.read(gameNotifierProvider);

      // Tree should not be planted, resources should remain the same
      expect(newState.resources, equals(lowResources));
      expect(newState.treePositions, isEmpty);
    });

    test('cleaning pollution should consume resources correctly', () {
      container = ProviderContainer();
      gameNotifier = container.read(gameNotifierProvider.notifier);
      gameNotifier.startGame();

      // Get initial resources
      final initialResources = container.read(gameNotifierProvider).resources;

      // Clean pollution
      gameNotifier.cleanPollution();
      final state = container.read(gameNotifierProvider);

      expect(state.resources.water, equals(initialResources.water - 5),
          reason: 'Should consume 5 water');
      expect(state.resources.energy, equals(initialResources.energy - 10),
          reason: 'Should consume 10 energy');
      expect(state.planetState.pollution, equals(40),
          reason: 'Should reduce pollution by 10');
    });

    test('should not clean pollution when resources are insufficient', () {
      // Start with low resources
      final initialState = GameState.initial().copyWith(
        isPlaying: true,
        resources: const GameResources(water: 4, energy: 4, soil: 30),
        planetState: const PlanetState(pollution: 50),
      );
      container = ProviderContainer();
      gameNotifier = container.read(gameNotifierProvider.notifier)
        ..state = initialState;

      gameNotifier.cleanPollution();
      final newState = container.read(gameNotifierProvider);

      // Resources and pollution should remain unchanged
      expect(newState.resources.water, equals(4),
          reason: 'Water should not be consumed');
      expect(newState.resources.energy, equals(4),
          reason: 'Energy should not be consumed');
      expect(newState.planetState.pollution, equals(50),
          reason: 'Pollution should not be reduced');
    });
  });

  group('GameNotifier - Game Rules', () {
    test('game should end in victory with enough trees and low pollution', () {
      // Start with a favorable state
      final favorableState = GameState.initial().copyWith(
        isPlaying: true,
        planetState: const PlanetState(pollution: 25),
        resources: const GameResources(water: 1000, energy: 1000, soil: 1000),
      );
      container = ProviderContainer();
      gameNotifier = container.read(gameNotifierProvider.notifier)
        ..state = favorableState;

      // Plant 20 trees at different positions
      for (var i = 0; i < 20; i++) {
        final x = (i % 5) * 0.2 - 0.4; // Spread trees in a grid
        final y = (i ~/ 5) * 0.2 - 0.4;
        gameNotifier.plantTree(TreePosition(x: x, y: y));
      }

      // Trigger game state check
      gameNotifier.cleanPollution();

      final state = container.read(gameNotifierProvider);
      expect(state.gameOver, true,
          reason: 'Game should be over with 20 trees and low pollution');
      expect(state.victory, true,
          reason: 'Should achieve victory with 20 trees and low pollution');
      expect(state.planetState.pollution, lessThan(30));
      expect(state.treePositions.length, greaterThanOrEqualTo(20));
    });

    test('game should end in defeat when pollution reaches 100', () {
      container = ProviderContainer();
      gameNotifier = container.read(gameNotifierProvider.notifier);

      // Start game normally
      gameNotifier.startGame();

      // Update state to have max pollution
      final currentState = container.read(gameNotifierProvider);
      final newState = currentState.copyWith(
        planetState: const PlanetState(pollution: 100),
      );
      gameNotifier.state = newState;

      // Check final state
      final finalState = container.read(gameNotifierProvider);
      expect(finalState.gameOver, true,
          reason: 'Game should be over when pollution reaches 100');
      expect(finalState.victory, false,
          reason: 'Should not achieve victory with max pollution');
      expect(finalState.planetState.pollution, equals(100));
    });

    test('trees should not be planted too close to each other', () {
      gameNotifier.startGame();

      // Plant first tree
      gameNotifier.plantTree(const TreePosition(x: 0, y: 0));
      final initialTreeCount =
          container.read(gameNotifierProvider).treePositions.length;

      // Try to plant second tree very close to first one
      gameNotifier.plantTree(const TreePosition(x: 0.1, y: 0.1));
      final newTreeCount =
          container.read(gameNotifierProvider).treePositions.length;

      expect(newTreeCount, equals(initialTreeCount),
          reason: 'Should not plant tree too close to existing tree');
    });

    test('trees should not be planted outside planet boundary', () {
      gameNotifier.startGame();

      // Try to plant tree outside the 90% radius boundary
      gameNotifier.plantTree(const TreePosition(x: 0.95, y: 0));
      final state = container.read(gameNotifierProvider);

      expect(state.treePositions, isEmpty,
          reason: 'Should not plant tree outside planet boundary');
    });
  });

  group('GameNotifier - Score and Level Calculation', () {
    test('score should increase with more trees and decrease with pollution',
        () {
      container = ProviderContainer();
      gameNotifier = container.read(gameNotifierProvider.notifier);

      // Start with a clean state but paused
      final initialState = GameState.initial().copyWith(
        isPlaying: false, // Start paused
        planetState:
            const PlanetState(pollution: 50), // Start with some pollution
        resources: const GameResources(
            water: 100, energy: 100, soil: 100), // Ensure enough resources
      );
      gameNotifier.state = initialState;

      // Plant 5 trees
      for (var i = 0; i < 5; i++) {
        gameNotifier.state = gameNotifier.state.copyWith(isPlaying: true);
        gameNotifier.plantTree(TreePosition(x: i * 0.2, y: 0));
        gameNotifier.state = gameNotifier.state.copyWith(isPlaying: false);
      }
      var state = container.read(gameNotifierProvider);
      var expectedScore = (5 * 100) - (state.planetState.pollution * 2);
      expect(state.planetState.score, equals(expectedScore),
          reason: 'Score should be (trees * 100) - (pollution * 2)');

      // Clean pollution and check score increase
      gameNotifier.state = gameNotifier.state.copyWith(isPlaying: true);
      final pollutionBefore = state.planetState.pollution;
      final scoreBefore = state.planetState.score;
      gameNotifier.cleanPollution();
      gameNotifier.state = gameNotifier.state.copyWith(isPlaying: false);
      state = container.read(gameNotifierProvider);
      expect(state.planetState.score, greaterThan(scoreBefore),
          reason: 'Score should increase when pollution is reduced');
      expect(state.planetState.pollution, lessThan(pollutionBefore),
          reason: 'Pollution should decrease after cleaning');
    });

    test('planet level should change based on trees and pollution', () {
      container = ProviderContainer();
      gameNotifier = container.read(gameNotifierProvider.notifier);

      // Start with a clean state but paused
      final initialState = GameState.initial().copyWith(
        isPlaying: true, // Start playing
        planetState: const PlanetState(pollution: 0),
        resources: const GameResources(
            water: 500, energy: 500, soil: 500), // Ensure enough resources
      );
      gameNotifier.state = initialState;

      // Initially should be barren
      var state = container.read(gameNotifierProvider);
      expect(state.planetState.level, equals(PlanetLevel.barren),
          reason: 'Planet should start as barren');
      expect(state.treePositions.length, equals(0),
          reason: 'Should start with no trees');

      // Plant 10 trees - should become developing
      // Plant trees in a grid pattern to ensure proper spacing
      for (var i = 0; i < 10; i++) {
        final x = (i % 5) * 0.3 - 0.6; // 5 trees per row, spaced 0.3 apart
        final y = (i ~/ 5) * 0.3 - 0.3; // 2 rows, spaced 0.3 apart
        gameNotifier.plantTree(TreePosition(x: x, y: y));
      }

      state = container.read(gameNotifierProvider);
      expect(state.treePositions.length, equals(10),
          reason: 'Should have 10 trees planted');
      expect(state.planetState.level, equals(PlanetLevel.developing),
          reason: 'Planet should be developing with 10 trees');

      // Plant 5 more trees - should become growing
      // Plant in a new row below the existing trees
      for (var i = 0; i < 5; i++) {
        final x = i * 0.3 - 0.6;
        const y = 0.3; // New row above existing trees
        gameNotifier.plantTree(TreePosition(x: x, y: y));
      }

      state = container.read(gameNotifierProvider);
      expect(state.treePositions.length, equals(15),
          reason: 'Should have 15 trees planted');
      expect(state.planetState.level, equals(PlanetLevel.growing),
          reason: 'Planet should be growing with 15 trees');

      // Plant 5 more trees - should become thriving
      // Plant in a new row above the existing trees
      for (var i = 0; i < 5; i++) {
        final x = i * 0.3 - 0.6;
        const y = -0.6; // New row below existing trees
        gameNotifier.plantTree(TreePosition(x: x, y: y));
      }

      state = container.read(gameNotifierProvider);
      expect(state.treePositions.length, equals(20),
          reason: 'Should have 20 trees planted');
      expect(state.planetState.level, equals(PlanetLevel.thriving),
          reason: 'Planet should be thriving with 20 trees');
    });
  });
}
