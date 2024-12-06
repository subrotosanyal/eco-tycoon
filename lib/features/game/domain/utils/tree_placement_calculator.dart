import 'dart:math' as math;
import 'package:eco_tycoon/features/game/domain/models/tree_position.dart';

class TreePlacementCalculator {
  static const double PLANET_RADIUS = 0.9; // 90% of the total radius
  static const double MIN_TREE_DISTANCE = 0.15; // Minimum distance between trees

  /// Checks if a position is within the planet's bounds
  static bool isWithinPlanetBounds(TreePosition position) {
    final distance = calculateDistanceFromCenter(position);
    return distance <= PLANET_RADIUS;
  }

  /// Calculates the distance of a position from the planet's center
  static double calculateDistanceFromCenter(TreePosition position) {
    return math.sqrt(position.x * position.x + position.y * position.y);
  }

  /// Calculates the distance between two tree positions
  static double calculateDistanceBetweenTrees(TreePosition tree1, TreePosition tree2) {
    final dx = tree1.x - tree2.x;
    final dy = tree1.y - tree2.y;
    return math.sqrt(dx * dx + dy * dy);
  }

  /// Checks if a new tree position is valid (not too close to existing trees)
  static bool isValidTreeSpacing(TreePosition newPosition, List<TreePosition> existingTrees) {
    for (final tree in existingTrees) {
      if (calculateDistanceBetweenTrees(newPosition, tree) < MIN_TREE_DISTANCE) {
        return false;
      }
    }
    return true;
  }

  /// Validates a tree position considering both planet bounds and tree spacing
  static bool isValidTreePosition(TreePosition position, List<TreePosition> existingTrees) {
    return isWithinPlanetBounds(position) && isValidTreeSpacing(position, existingTrees);
  }
}
