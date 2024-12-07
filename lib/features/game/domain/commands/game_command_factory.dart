import 'package:eco_tycoon/features/game/domain/commands/game_command.dart';
import 'package:eco_tycoon/features/game/domain/commands/plant_tree_command.dart';
import 'package:eco_tycoon/features/game/domain/commands/clean_pollution_command.dart';
import 'package:eco_tycoon/features/game/domain/providers/game_provider.dart';
import 'package:eco_tycoon/features/game/domain/models/game_state.dart';
import 'package:eco_tycoon/features/game/domain/models/tree_position.dart';

class GameCommandFactory {
  static List<GameCommand> createCommands(
      GameNotifier notifier, GameState state) {
    return [
      // Pass a dummy position for the plant tree command in the list
      // The actual position will be set when executing the command
      createPlantTreeCommand(notifier, state, const TreePosition(x: 0, y: 0)),
      CleanPollutionCommand(notifier, state),
    ];
  }

  static PlantTreeCommand createPlantTreeCommand(
      GameNotifier notifier, GameState state, TreePosition position) {
    return PlantTreeCommand(notifier, state, position);
  }
}
