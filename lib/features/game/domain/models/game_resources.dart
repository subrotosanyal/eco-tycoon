import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_resources.freezed.dart';

@freezed
class GameResources with _$GameResources {
  const GameResources._(); // Private constructor for methods

  const factory GameResources({
    @Default(0) int water,
    @Default(0) int energy,
    @Default(0) int soil,
  }) = _GameResources;

  bool canAfford({
    int water = 0,
    int energy = 0,
    int soil = 0,
  }) {
    return this.water >= water && this.energy >= energy && this.soil >= soil;
  }

  GameResources spend({
    int water = 0,
    int energy = 0,
    int soil = 0,
  }) {
    if (!canAfford(
      water: water,
      energy: energy,
      soil: soil,
    )) {
      throw Exception('Not enough resources');
    }

    return copyWith(
      water: this.water - water,
      energy: this.energy - energy,
      soil: this.soil - soil,
    );
  }

  GameResources regenerate({
    int water = 0,
    int energy = 0,
    int soil = 0,
  }) {
    return copyWith(
      water: (this.water + water).clamp(0, 100),
      energy: (this.energy + energy).clamp(0, 100),
      soil: (this.soil + soil).clamp(0, 100),
    );
  }

  bool canPlantTree() {
    return canAfford(
      water: 10,
      soil: 5,
    );
  }

  GameResources spendForTree() {
    return spend(
      water: 10,
      soil: 5,
    );
  }

  bool canCleanPollution() {
    return water >= 5 && energy >= 10;
  }

  GameResources spendForCleaning() {
    return spend(
      energy: 20,
    );
  }
}
