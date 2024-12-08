import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eco_tycoon/features/game/domain/providers/game_provider.dart';
import 'package:eco_tycoon/features/game/domain/models/game_resources.dart';
import 'package:eco_tycoon/features/game/domain/models/game_state.dart';
import 'package:eco_tycoon/features/game/domain/models/planet_state.dart';
import 'package:eco_tycoon/features/game/domain/models/resources.dart';
import 'package:eco_tycoon/features/game/domain/models/tree_position.dart';
import '../commands/command_test_helper.dart';

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
      expect(state.resources.water.amount, 50);
      expect(state.resources.energy.amount, 50);
      expect(state.resources.soil.amount, 30);
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
    test('planting tree should consume resources correctly', () async {
      // Start with specific resource values
      final initialState = GameState.initial().copyWith(
        isPlaying: true,
        resources: const GameResources(
          water: WaterResource(amount: 50),
          energy: EnergyResource(amount: 50),
          soil: SoilResource(amount: 30),
        ),
      );
      container = ProviderContainer();
      gameNotifier = container.read(gameNotifierProvider.notifier)
        ..state = initialState;

      const position = TreePosition(x: 0, y: 0);
      await CommandTestHelper.executePlantTree(
          gameNotifier, initialState, position);
      final newState = container.read(gameNotifierProvider);

      expect(newState.resources.water.amount, initialState.resources.water.amount - 10);
      expect(newState.resources.energy.amount, initialState.resources.energy.amount - 5);
      expect(newState.resources.soil.amount, initialState.resources.soil.amount - 5);
    });

    test('should not plant tree when resources are insufficient', () async {
      // Set resources to low values
      const lowResources = GameResources(
        water: WaterResource(amount: 5),
        energy: EnergyResource(amount: 3),
        soil: SoilResource(amount: 3),
      );
      final initialState = GameState.initial().copyWith(
        isPlaying: true,
        resources: lowResources,
      );
      container = ProviderContainer();
      gameNotifier = container.read(gameNotifierProvider.notifier)
        ..state = initialState;

      const position = TreePosition(x: 0, y: 0);
      await CommandTestHelper.executePlantTree(
          gameNotifier, initialState, position);
      final newState = container.read(gameNotifierProvider);

      // Tree should not be planted, resources should remain the same
      expect(newState.resources, equals(lowResources));
      expect(newState.treePositions, isEmpty);
    });

    test('cleaning pollution should consume resources correctly', () async {
      container = ProviderContainer();
      gameNotifier = container.read(gameNotifierProvider.notifier);
      gameNotifier.startGame();

      // Get initial resources
      final initialState = container.read(gameNotifierProvider);
      final initialResources = initialState.resources;

      // Clean pollution
      await CommandTestHelper.executeCleanPollution(gameNotifier, initialState);
      final state = container.read(gameNotifierProvider);

      expect(state.resources.water.amount, equals(initialResources.water.amount - 5),
          reason: 'Should consume 5 water');
      expect(state.resources.energy.amount, equals(initialResources.energy.amount - 10),
          reason: 'Should consume 10 energy');
      expect(state.planetState.pollution, equals(40),
          reason: 'Should reduce pollution by 10');
    });

    test('should not clean pollution when resources are insufficient',
        () async {
      // Start with low resources
      final initialState = GameState.initial().copyWith(
        isPlaying: true,
        resources: const GameResources(
          water: WaterResource(amount: 4),
          energy: EnergyResource(amount: 4),
          soil: SoilResource(amount: 30),
        ),
        planetState: const PlanetState(pollution: 50),
      );
      container = ProviderContainer();
      gameNotifier = container.read(gameNotifierProvider.notifier)
        ..state = initialState;

      await CommandTestHelper.executeCleanPollution(gameNotifier, initialState);
      final newState = container.read(gameNotifierProvider);

      // Resources and pollution should remain unchanged
      expect(newState.resources.water.amount, equals(4),
          reason: 'Water should not be consumed');
      expect(newState.resources.energy.amount, equals(4),
          reason: 'Energy should not be consumed');
      expect(newState.planetState.pollution, equals(50),
          reason: 'Pollution should not be reduced');
    });
  });

  group('GameNotifier - Game Rules', () {
    test('game should end in victory with enough trees and low pollution',
        () async {
      // Start with a favorable state
      final favorableState = GameState.initial().copyWith(
        isPlaying: true,
        planetState: const PlanetState(pollution: 25),
        resources: const GameResources(
          water: WaterResource(amount: 1000),
          energy: EnergyResource(amount: 1000),
          soil: SoilResource(amount: 1000),
        ),
      );
      container = ProviderContainer();
      gameNotifier = container.read(gameNotifierProvider.notifier)
        ..state = favorableState;

      // Plant 20 trees at different positions
      for (var i = 0; i < 20; i++) {
        final x = (i % 5) * 0.2 - 0.4; // Spread trees in a grid
        final y = (i ~/ 5) * 0.2 - 0.4;
        final state = container.read(gameNotifierProvider);
        await CommandTestHelper.executePlantTree(
            gameNotifier, state, TreePosition(x: x, y: y));
      }

      // Trigger game state check
      final state = container.read(gameNotifierProvider);
      await CommandTestHelper.executeCleanPollution(gameNotifier, state);

      final finalState = container.read(gameNotifierProvider);
      expect(finalState.gameOver, true,
          reason: 'Game should be over with 20 trees and low pollution');
      expect(finalState.victory, true,
          reason: 'Should achieve victory with 20 trees and low pollution');
      expect(finalState.planetState.pollution, lessThan(30));
      expect(finalState.treePositions.length, greaterThanOrEqualTo(20));
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

    test('trees should not be planted too close to each other', () async {
      gameNotifier.startGame();

      // Plant first tree
      var state = container.read(gameNotifierProvider);
      await CommandTestHelper.executePlantTree(
          gameNotifier, state, const TreePosition(x: 0, y: 0));
      final initialTreeCount =
          container.read(gameNotifierProvider).treePositions.length;

      // Try to plant second tree very close to first one
      state = container.read(gameNotifierProvider);
      await CommandTestHelper.executePlantTree(
          gameNotifier, state, const TreePosition(x: 0.1, y: 0.1));
      final newTreeCount =
          container.read(gameNotifierProvider).treePositions.length;

      expect(newTreeCount, equals(initialTreeCount),
          reason: 'Should not plant tree too close to existing tree');
    });

    test('trees should not be planted outside planet boundary', () async {
      gameNotifier.startGame();

      // Try to plant tree outside the 90% radius boundary
      var state = container.read(gameNotifierProvider);
      await CommandTestHelper.executePlantTree(
          gameNotifier, state, const TreePosition(x: 0.95, y: 0));
      final finalState = container.read(gameNotifierProvider);

      expect(finalState.treePositions, isEmpty,
          reason: 'Should not plant tree outside planet boundary');
    });
  });

  group('GameNotifier - Score and Level Calculation', () {
    test('score should increase with more trees and decrease with pollution',
        () async {
      container = ProviderContainer();
      gameNotifier = container.read(gameNotifierProvider.notifier);

      // Start with a clean state but paused
      final initialState = GameState.initial().copyWith(
        isPlaying: false, // Start paused
        planetState:
            const PlanetState(pollution: 50), // Start with some pollution
        resources: const GameResources(
            water: WaterResource(amount: 100),
            energy: EnergyResource(amount: 100),
            soil: SoilResource(amount: 100)), // Ensure enough resources
      );
      gameNotifier.state = initialState;

      // Plant 5 trees
      for (var i = 0; i < 5; i++) {
        gameNotifier.state = gameNotifier.state.copyWith(isPlaying: true);
        var state = container.read(gameNotifierProvider);
        await CommandTestHelper.executePlantTree(
            gameNotifier, state, TreePosition(x: i * 0.2, y: 0));
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

      // Get current state before cleaning
      state = container.read(gameNotifierProvider);
      await CommandTestHelper.executeCleanPollution(gameNotifier, state);

      // Get final state after cleaning
      final finalState = container.read(gameNotifierProvider);
      expect(finalState.planetState.score, greaterThan(scoreBefore),
          reason: 'Score should increase when pollution is reduced');
      expect(finalState.planetState.pollution, lessThan(pollutionBefore),
          reason: 'Pollution should decrease after cleaning');
    });

    test('planet level should change based on trees and pollution', () async {
      container = ProviderContainer();
      gameNotifier = container.read(gameNotifierProvider.notifier);

      // Start with a clean state but paused
      final initialState = GameState.initial().copyWith(
        isPlaying: true, // Start playing
        planetState: const PlanetState(pollution: 0),
        resources: const GameResources(
            water: WaterResource(amount: 500),
            energy: EnergyResource(amount: 500),
            soil: SoilResource(amount: 500)), // Ensure enough resources
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
        state = container.read(gameNotifierProvider);
        await CommandTestHelper.executePlantTree(
            gameNotifier, state, TreePosition(x: x, y: y));
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
        state = container.read(gameNotifierProvider);
        await CommandTestHelper.executePlantTree(
            gameNotifier, state, TreePosition(x: x, y: y));
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
        state = container.read(gameNotifierProvider);
        await CommandTestHelper.executePlantTree(
            gameNotifier, state, TreePosition(x: x, y: y));
      }

      state = container.read(gameNotifierProvider);
      expect(state.treePositions.length, equals(20),
          reason: 'Should have 20 trees planted');
      expect(state.planetState.level, equals(PlanetLevel.thriving),
          reason: 'Planet should be thriving with 20 trees');
    });
  });
}
