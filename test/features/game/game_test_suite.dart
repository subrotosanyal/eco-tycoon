import 'package:flutter_test/flutter_test.dart';

// Import all test files
import 'domain/providers/game_provider_test.dart' as game_provider_test;
import 'domain/utils/game_calculator_test.dart' as game_calculator_test;
import 'domain/utils/tree_placement_calculator_test.dart' as tree_placement_calculator_test;

void main() {
  group('Game Test Suite', () {
    group('Domain Layer Tests', () {
      // Run provider tests
      group('Provider Tests', () {
        game_provider_test.main();
      });

      // Run utility tests
      group('Utility Tests', () {
        group('Game Calculator Tests', () {
          game_calculator_test.main();
        });

        group('Tree Placement Calculator Tests', () {
          tree_placement_calculator_test.main();
        });
      });
    });
  });
}
