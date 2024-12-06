import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/tree_position.dart';
import '../../domain/providers/game_provider.dart';
import '../painters/planet_painter.dart';
import '../providers/ripple_provider.dart';
import './ripple_animation.dart';

class PlanetView extends ConsumerWidget {
  const PlanetView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameNotifierProvider);
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;

    // Calculate planet size based on screen width
    final planetSize = isSmallScreen
        ? screenSize.width * 0.7 // 70% of screen width on mobile
        : screenSize.width * 0.4; // 40% of screen width on desktop

    return Center(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: planetSize,
            maxHeight: planetSize,
          ),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque, // Ensure gesture area is limited
            onTapDown: !gameState.isPlaying || gameState.gameOver
                ? null
                : (details) {
                    final RenderBox box =
                        context.findRenderObject() as RenderBox;

                    final localPosition =
                        box.globalToLocal(details.globalPosition);
                    final center =
                        Offset(box.size.width / 2, box.size.height / 2);
                    final radius =
                        math.min(box.size.width, box.size.height) / 2;

                    // Check if tap is within planet's circular boundary
                    final dx = localPosition.dx - center.dx;
                    final dy = localPosition.dy - center.dy;
                    final distance = math.sqrt(dx * dx + dy * dy);

                    // Only plant tree if tap is within planet boundary (90% of radius to ensure visibility)
                    if (distance <= radius * 0.9) {
                      // Calculate relative position from center (-1 to 1)
                      final position = TreePosition(
                        x: dx / radius,
                        y: dy / radius,
                      );

                      ref
                          .read(gameNotifierProvider.notifier)
                          .plantTree(position);
                      ref
                          .read(rippleStateProvider.notifier)
                          .showRipple(localPosition);
                    }
                  },
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Planet surface with trees
                CustomPaint(
                  painter: PlanetPainter(
                    trees: gameState.treePositions,
                    pollution: gameState.planetState.pollution,
                    planetState: gameState.planetState.level,
                  ),
                ),
                // Pollution overlay
                if (gameState.planetState.pollution > 0)
                  Positioned.fill(
                    child: CustomPaint(
                      painter: PollutionPainter(
                        pollution: gameState.planetState.pollution / 100,
                      ),
                    ),
                  ),
                // Ripple effect
                if (ref.watch(rippleStateProvider) != null)
                  Positioned(
                    left: ref.watch(rippleStateProvider)?.position.dx ?? 0 - 50,
                    top: ref.watch(rippleStateProvider)?.position.dy ?? 0 - 50,
                    child: RippleAnimation(
                      onComplete: () =>
                          ref.read(rippleStateProvider.notifier).hideRipple(),
                    ),
                  ),
                // Game over overlay
                if (gameState.gameOver)
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PollutionPainter extends CustomPainter {
  final double pollution;

  PollutionPainter({required this.pollution});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(pollution * 0.7)
      ..style = PaintingStyle.fill;

    // Draw pollution clouds
    final radius = size.width / 2;
    final center = Offset(size.width / 2, size.height / 2);

    for (var i = 0; i < 8; i++) {
      final angle = i * (math.pi * 2 / 8);
      final x = center.dx + radius * 0.8 * pollution * math.cos(angle);
      final y = center.dy + radius * 0.8 * pollution * math.sin(angle);

      canvas.drawCircle(
        Offset(x, y),
        radius * 0.3 * pollution,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(PollutionPainter oldDelegate) =>
      pollution != oldDelegate.pollution;
}
