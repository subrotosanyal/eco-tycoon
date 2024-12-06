import 'package:freezed_annotation/freezed_annotation.dart';

part 'planet_state.freezed.dart';

@freezed
class PlanetState with _$PlanetState {
  const factory PlanetState({
    @Default(0) int score,
    @Default(50) int pollution,  // Start with medium pollution
    @Default(0) int trees,
    @Default(PlanetLevel.barren) PlanetLevel level,
  }) = _PlanetState;
}

enum PlanetLevel {
  dying(0),
  polluted(2),
  barren(5),
  developing(10),
  growing(15),
  thriving(20);

  final int scoreMultiplier;
  const PlanetLevel(this.scoreMultiplier);

  bool get isDying => this == PlanetLevel.dying;
  bool get isPolluted => this == PlanetLevel.polluted;
  bool get isBarren => this == PlanetLevel.barren;
  bool get isDeveloping => this == PlanetLevel.developing;
  bool get isGrowing => this == PlanetLevel.growing;
  bool get isThriving => this == PlanetLevel.thriving;

  String get name => switch (this) {
    PlanetLevel.dying => 'Dying',
    PlanetLevel.polluted => 'Polluted',
    PlanetLevel.barren => 'Barren',
    PlanetLevel.developing => 'Developing',
    PlanetLevel.growing => 'Growing',
    PlanetLevel.thriving => 'Thriving',
  };
}
