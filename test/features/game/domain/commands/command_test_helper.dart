import 'package:eco_tycoon/features/game/domain/commands/clean_pollution_command.dart';
import 'package:eco_tycoon/features/game/domain/commands/plant_tree_command.dart';
import 'package:eco_tycoon/features/game/domain/providers/game_provider.dart';
import 'package:eco_tycoon/features/game/domain/models/game_state.dart';
import 'package:eco_tycoon/features/game/domain/models/tree_position.dart';

class CommandTestHelper {
  static Future<void> executeCleanPollution(GameNotifier notifier, GameState state) async {
    final command = CleanPollutionCommand(notifier, state);
    await command.execute();
  }

  static Future<void> executePlantTree(GameNotifier notifier, GameState state, TreePosition position) async {
    final command = PlantTreeCommand(notifier, state, position);
    await command.execute();
  }
}
