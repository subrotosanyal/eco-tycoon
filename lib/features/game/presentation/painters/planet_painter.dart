import 'package:flutter/material.dart';
import '../../domain/models/planet_state.dart';
import '../../domain/models/tree_position.dart';

class PlanetPainter extends CustomPainter {
  final List<TreePosition> trees;
  final int pollution;
  final PlanetLevel planetState;

  PlanetPainter({
    required this.trees,
    required this.pollution,
    required this.planetState,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width < size.height ? size.width / 2 : size.height / 2;

    // Draw planet
    final planetPaint = Paint()
      ..color = _getPlanetColor()
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, planetPaint);

    // Draw pollution overlay
    if (pollution > 0) {
      final pollutionPaint = Paint()
        ..color = Colors.black.withOpacity(pollution / 200)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(center, radius, pollutionPaint);
    }

    // Draw trees
    final treePaint = Paint()
      ..color = const Color(0xFF2E7D32)
      ..style = PaintingStyle.fill
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    for (final tree in trees) {
      // Convert from -1..1 to actual pixel coordinates
      final treeX = center.dx + (tree.x * radius * 0.9); // Use 90% of radius for consistent spacing
      final treeY = center.dy + (tree.y * radius * 0.9);
      _drawTree(canvas, Offset(treeX, treeY), treePaint);
    }
  }

  void _drawTree(Canvas canvas, Offset position, Paint paint) {
    const treeSize = 16.0;
    
    // Draw trunk
    final trunkPaint = Paint()
      ..color = Colors.brown.shade700
      ..style = PaintingStyle.fill;
    
    canvas.drawRect(
      Rect.fromCenter(
        center: position.translate(0, treeSize / 3),
        width: treeSize / 4,
        height: treeSize / 2,
      ),
      trunkPaint,
    );

    // Draw triangular top with gradient
    final topPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.green.shade300,
          Colors.green.shade700,
        ],
      ).createShader(Rect.fromCircle(center: position, radius: treeSize));

    final path = Path()
      ..moveTo(position.dx - treeSize / 2, position.dy + treeSize / 4)
      ..lineTo(position.dx + treeSize / 2, position.dy + treeSize / 4)
      ..lineTo(position.dx, position.dy - treeSize / 2)
      ..close();
    canvas.drawPath(path, topPaint);
  }

  Color _getPlanetColor() {
    return switch (planetState) {
      PlanetLevel.dying => Colors.red.shade200,
      PlanetLevel.polluted => Colors.orange.shade200,
      PlanetLevel.barren => Colors.brown.shade100,
      PlanetLevel.developing => Colors.brown.shade200,
      PlanetLevel.growing => Colors.lightGreen.shade100,
      PlanetLevel.thriving => Colors.green.shade100,
    };
  }

  @override
  bool shouldRepaint(PlanetPainter oldDelegate) {
    return trees != oldDelegate.trees ||
        pollution != oldDelegate.pollution ||
        planetState != oldDelegate.planetState;
  }
}
