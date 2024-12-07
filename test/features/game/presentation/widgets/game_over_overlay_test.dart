import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eco_tycoon/features/game/presentation/widgets/game_over_overlay.dart';
import 'package:eco_tycoon/features/game/domain/models/game_state.dart';
import 'package:eco_tycoon/features/game/domain/models/planet_state.dart';
import 'package:eco_tycoon/features/game/domain/providers/game_provider.dart';

void main() {
  group('GameOverOverlay Widget Tests', () {
    testWidgets('Hidden when game is not over', (WidgetTester tester) async {
      final gameState = GameState.initial().copyWith(gameOver: false);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            gameNotifierProvider.overrideWith((ref) => GameNotifier()..state = gameState),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: GameOverOverlay(victory: false),
            ),
          ),
        ),
      );

      // Verify overlay is not visible
      expect(find.byType(Card), findsNothing);
      expect(find.text('Game Over'), findsNothing);
    });

    testWidgets('Shows victory message on win', (WidgetTester tester) async {
      final gameState = GameState.initial().copyWith(
        gameOver: true,
        planetState: const PlanetState(
          level: PlanetLevel.thriving,
          score: 1000,
          pollution: 0,
          trees: 10,
        ),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            gameNotifierProvider.overrideWith((ref) => GameNotifier()..state = gameState),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: GameOverOverlay(victory: true),
            ),
          ),
        ),
      );

      // Verify victory content
      expect(find.text('Victory!'), findsOneWidget);
      expect(find.text('You have successfully restored the planet!'), findsOneWidget);
      expect(find.text('Final Score: 1000'), findsOneWidget);
    });

    testWidgets('Shows defeat message on loss', (WidgetTester tester) async {
      final gameState = GameState.initial().copyWith(
        gameOver: true,
        planetState: const PlanetState(
          level: PlanetLevel.dying,
          score: 500,
          pollution: 100,
          trees: 0,
        ),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            gameNotifierProvider.overrideWith((ref) => GameNotifier()..state = gameState),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: GameOverOverlay(victory: false),
            ),
          ),
        ),
      );

      // Verify defeat content
      expect(find.text('Game Over'), findsOneWidget);
      expect(find.text('The planet could not be saved...'), findsOneWidget);
      expect(find.text('Final Score: 500'), findsOneWidget);
    });

    testWidgets('Back to Start button navigates correctly',
        (WidgetTester tester) async {
      final gameState = GameState.initial().copyWith(
        gameOver: true,
        planetState: const PlanetState(
          level: PlanetLevel.dying,
          score: 500,
          pollution: 100,
          trees: 0,
        ),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            gameNotifierProvider.overrideWith((ref) => GameNotifier()..state = gameState),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: GameOverOverlay(victory: false),
            ),
          ),
        ),
      );

      // Find and tap restart button
      final restartButton = find.widgetWithText(ElevatedButton, 'Back to Start');
      expect(restartButton, findsOneWidget);
    });

    testWidgets('Overlay has semi-transparent background', (WidgetTester tester) async {
      final gameState = GameState.initial().copyWith(gameOver: true);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            gameNotifierProvider.overrideWith((ref) => GameNotifier()..state = gameState),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: GameOverOverlay(victory: false),
            ),
          ),
        ),
      );

      // Find container with semi-transparent background
      final container = tester.widget<Container>(find.byType(Container));
      final color = container.color as Color;
      expect(color.alpha, (0.8 * 255).round());
      expect(color.red, 0);
      expect(color.green, 0);
      expect(color.blue, 0);
    });
  });
}
