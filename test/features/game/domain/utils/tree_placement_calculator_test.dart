import 'package:flutter_test/flutter_test.dart';
import 'package:eco_tycoon/features/game/domain/models/tree_position.dart';
import 'package:eco_tycoon/features/game/domain/utils/tree_placement_calculator.dart';

void main() {
  group('TreePlacementCalculator', () {
    test('isWithinPlanetBounds returns true for valid positions', () {
      expect(
        TreePlacementCalculator.isWithinPlanetBounds(
          const TreePosition(x: 0.5, y: 0.5),
        ),
        isTrue,
      );
      expect(
        TreePlacementCalculator.isWithinPlanetBounds(
          const TreePosition(x: 0.0, y: 0.0),
        ),
        isTrue,
      );
      expect(
        TreePlacementCalculator.isWithinPlanetBounds(
          const TreePosition(x: 0.9, y: 0.0),
        ),
        isTrue,
      );
    });

    test('isWithinPlanetBounds returns false for positions outside bounds', () {
      expect(
        TreePlacementCalculator.isWithinPlanetBounds(
          const TreePosition(x: 1.0, y: 1.0),
        ),
        isFalse,
      );
      expect(
        TreePlacementCalculator.isWithinPlanetBounds(
          const TreePosition(x: 0.7, y: 0.7),
        ),
        isFalse, // sqrt(0.7^2 + 0.7^2) > 0.9
      );
    });

    test('calculateDistanceFromCenter returns correct distances', () {
      expect(
        TreePlacementCalculator.calculateDistanceFromCenter(
          const TreePosition(x: 0.0, y: 0.0),
        ),
        0.0,
      );
      expect(
        TreePlacementCalculator.calculateDistanceFromCenter(
          const TreePosition(x: 1.0, y: 0.0),
        ),
        1.0,
      );
      expect(
        TreePlacementCalculator.calculateDistanceFromCenter(
          const TreePosition(x: 0.3, y: 0.4),
        ),
        closeTo(0.5, 0.001),
      );
    });

    test('calculateDistanceBetweenTrees returns correct distances', () {
      const tree1 = TreePosition(x: 0.0, y: 0.0);
      const tree2 = TreePosition(x: 0.3, y: 0.4);

      expect(
        TreePlacementCalculator.calculateDistanceBetweenTrees(tree1, tree2),
        closeTo(0.5, 0.001),
      );
      expect(
        TreePlacementCalculator.calculateDistanceBetweenTrees(tree1, tree1),
        0.0,
      );
    });

    test('isValidTreeSpacing validates minimum distance between trees', () {
      final existingTrees = [
        const TreePosition(x: 0.0, y: 0.0),
        const TreePosition(x: 0.5, y: 0.5),
      ];

      // Too close to first tree
      expect(
        TreePlacementCalculator.isValidTreeSpacing(
          const TreePosition(x: 0.1, y: 0.1),
          existingTrees,
        ),
        isFalse,
      );

      // Valid distance from both trees
      expect(
        TreePlacementCalculator.isValidTreeSpacing(
          const TreePosition(x: 0.3, y: 0.0),
          existingTrees,
        ),
        isTrue,
      );
    });

    test('isValidTreePosition combines bounds and spacing checks', () {
      final existingTrees = [const TreePosition(x: 0.0, y: 0.0)];

      // Valid position
      expect(
        TreePlacementCalculator.isValidTreePosition(
          const TreePosition(x: 0.5, y: 0.5),
          existingTrees,
        ),
        isTrue,
      );

      // Invalid - outside bounds
      expect(
        TreePlacementCalculator.isValidTreePosition(
          const TreePosition(x: 1.0, y: 1.0),
          existingTrees,
        ),
        isFalse,
      );

      // Invalid - too close to existing tree
      expect(
        TreePlacementCalculator.isValidTreePosition(
          const TreePosition(x: 0.1, y: 0.1),
          existingTrees,
        ),
        isFalse,
      );
    });
  });
}
