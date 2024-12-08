import 'package:freezed_annotation/freezed_annotation.dart';
import 'resources.dart';

part 'game_resources.freezed.dart';

@freezed
class GameResources with _$GameResources {
  const GameResources._(); // Private constructor for methods

  const factory GameResources({
    @Default(WaterResource()) WaterResource water,
    @Default(EnergyResource()) EnergyResource energy,
    @Default(SoilResource()) SoilResource soil,
  }) = _GameResources;

  bool canAfford({
    int water = 0,
    int energy = 0,
    int soil = 0,
  }) {
    return this.water.canSpend(water) && 
           this.energy.canSpend(energy) && 
           this.soil.canSpend(soil);
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
      water: this.water.spend(water),
      energy: this.energy.spend(energy),
      soil: this.soil.spend(soil),
    );
  }

  GameResources regenerate({
    int water = 0,
    int energy = 0,
    int soil = 0,
  }) {
    return copyWith(
      water: this.water.regenerate(water),
      energy: this.energy.regenerate(energy),
      soil: this.soil.regenerate(soil),
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
    return water.amount >= 5 && energy.amount >= 10;
  }

  GameResources spendForCleaning() {
    return spend(
      energy: 20,
    );
  }
}
