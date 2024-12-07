import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eco_tycoon/features/game/domain/models/game_state.dart';
import 'package:eco_tycoon/features/game/domain/models/planet_state.dart';
import 'package:eco_tycoon/features/game/domain/models/game_resources.dart';
import 'package:eco_tycoon/features/game/domain/utils/game_calculator.dart';
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

    final newPollution = GameCalculator.calculatePollutionChange(
        currentState.pollution, treeCount);

    return currentState.copyWith(
      pollution: newPollution,
      trees: treeCount,
      level: GameCalculator.calculatePlanetLevel(treeCount, newPollution),
      score: GameCalculator.calculateScore(treeCount, newPollution),
    );
  }

  GameResources _updateResources() {
    return GameCalculator.updateResources(
        state.resources, state.treePositions.length);
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
