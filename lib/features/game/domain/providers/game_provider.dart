import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eco_tycoon/features/game/domain/models/game_state.dart';
import 'package:eco_tycoon/features/game/domain/models/planet_state.dart';
import 'package:eco_tycoon/features/game/domain/models/tree_position.dart';
import 'package:eco_tycoon/features/game/domain/models/game_resources.dart';
import 'package:eco_tycoon/features/game/domain/utils/game_calculator.dart';
import 'package:eco_tycoon/features/game/domain/utils/tree_placement_calculator.dart';
import 'package:eco_tycoon/core/services/logger_service.dart';

final gameNotifierProvider =
    StateNotifierProvider<GameNotifier, GameState>((ref) => GameNotifier());

class GameNotifier extends StateNotifier<GameState> {
  Timer? _gameTimer;

  GameNotifier() : super(GameState.initial());

  void _checkGameState() {
    if (state.gameOver) return; // Don't check if game is already over
    
    final gameState = GameCalculator.checkGameState(
      isPlaying: state.isPlaying,
      currentGameOver: state.gameOver,
      pollution: state.planetState.pollution,
      treeCount: state.treePositions.length,
    );

    if (gameState['gameOver']!) {
      super.state = state.copyWith(
        gameOver: true,
        victory: gameState['victory']!,
        isPlaying: false,
      );
      _gameTimer?.cancel();
    }
  }

  void updateState(GameState newState) {
    super.state = newState;
    _checkGameState();
  }

  void startGame() {
    LoggerService.info('Starting new game');
    _gameTimer?.cancel();
    super.state = GameState.initial().copyWith(isPlaying: true);
    _startGameLoop();
  }

  void pauseGame() {
    if (state.gameOver) return; // Don't allow pausing if game is over
    LoggerService.info('Pausing game');
    _gameTimer?.cancel();
    super.state = state.copyWith(isPlaying: false);
  }

  void resumeGame() {
    if (state.gameOver) return; // Don't allow resuming if game is over
    LoggerService.info('Resuming game');
    super.state = state.copyWith(isPlaying: true);
    _startGameLoop();
  }

  void plantTree(TreePosition position) {
    if (!state.isPlaying || state.gameOver || !state.resources.canPlantTree()) {
      LoggerService.info(
          'Cannot plant tree: isPlaying=${state.isPlaying}, gameOver=${state.gameOver}, canPlantTree=${state.resources.canPlantTree()}');
      return;
    }

    if (!TreePlacementCalculator.isValidTreePosition(position, state.treePositions)) {
      LoggerService.info('Invalid tree position: outside bounds or too close to existing tree');
      return;
    }

    LoggerService.info('Planting tree at position: (${position.x}, ${position.y})');

    // Update tree positions and resources
    final newTreePositions = [...state.treePositions, position];
    final newResources = GameCalculator.calculateTreePlantingCost(state.resources);

    // Calculate new planet state
    final treeCount = newTreePositions.length;
    final currentPollution = state.planetState.pollution;
    final newScore = GameCalculator.calculateScore(treeCount, currentPollution);
    final newLevel = GameCalculator.calculatePlanetLevel(treeCount, currentPollution);

    LoggerService.info('Tree count: $treeCount, Level: $newLevel, Score: $newScore');

    final newPlanetState = state.planetState.copyWith(
      trees: treeCount,
      score: newScore,
      level: newLevel,
    );

    final newState = state.copyWith(
      resources: newResources,
      treePositions: newTreePositions,
      planetState: newPlanetState,
    );

    super.state = newState;
    _checkGameState();

    LoggerService.info('Updated game state: trees=${state.planetState.trees}, level=${state.planetState.level}');
  }

  void cleanPollution() {
    if (!state.isPlaying || state.gameOver || !state.resources.canCleanPollution()) return;

    LoggerService.info('Cleaning pollution');

    final newResources = GameCalculator.calculatePollutionCleaningCost(state.resources);
    final newPollution = GameCalculator.calculatePollutionReduction(state.planetState.pollution);
    final treeCount = state.treePositions.length;
    final newScore = GameCalculator.calculateScore(treeCount, newPollution);
    final newLevel = GameCalculator.calculatePlanetLevel(treeCount, newPollution);

    final newPlanetState = state.planetState.copyWith(
      pollution: newPollution,
      trees: treeCount,
      score: newScore,
      level: newLevel,
    );

    final newState = state.copyWith(
      resources: newResources,
      planetState: newPlanetState,
    );

    super.state = newState;
    _checkGameState();
  }

  void _startGameLoop() {
    _gameTimer = Timer.periodic(const Duration(seconds: 1), _onTick);
  }

  void _onTick(Timer timer) {
    if (!state.isPlaying || state.gameOver) {
      timer.cancel();
      return;
    }

    final newState = state.copyWith(
      elapsedTime: state.elapsedTime + 1,
      planetState: _updatePlanetState(),
      resources: _updateResources(),
    );

    super.state = newState;
    _checkGameState();
  }

  PlanetState _updatePlanetState() {
    final currentState = state.planetState;
    final treeCount = state.treePositions.length;

    final newPollution = GameCalculator.calculatePollutionChange(currentState.pollution, treeCount);

    return currentState.copyWith(
      pollution: newPollution,
      trees: treeCount,
      level: GameCalculator.calculatePlanetLevel(treeCount, newPollution),
      score: GameCalculator.calculateScore(treeCount, newPollution),
    );
  }

  GameResources _updateResources() {
    return GameCalculator.updateResources(state.resources, state.treePositions.length);
  }

  @override
  set state(GameState value) {
    super.state = value;
    _checkGameState();
  }

  @override
  void dispose() {
    _gameTimer?.cancel();
    super.dispose();
  }
}
