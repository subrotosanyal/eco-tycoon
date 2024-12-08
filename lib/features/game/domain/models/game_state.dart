import 'package:freezed_annotation/freezed_annotation.dart';
import 'game_resources.dart';
import 'planet_state.dart';
import 'tree_position.dart';
import 'resources.dart';

part 'game_state.freezed.dart';

@freezed
class GameState with _$GameState {
  const factory GameState({
    @Default(false) bool isPlaying,
    @Default(false) bool gameOver,
    @Default(false) bool victory,
    @Default(0) int elapsedTime,
    required PlanetState planetState,
    required GameResources resources,
    required List<TreePosition> treePositions,
  }) = _GameState;

  factory GameState.initial() => const GameState(
        planetState: PlanetState(),
        resources: GameResources(
          water: WaterResource(amount: 50),
          energy: EnergyResource(amount: 50),
          soil: SoilResource(amount: 30),
        ),
        treePositions: [],
      );
}
