import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eco_tycoon/features/game/presentation/widgets/game_controls.dart';
import 'package:eco_tycoon/features/game/domain/providers/game_provider.dart';
import 'package:eco_tycoon/features/game/domain/models/game_state.dart';
import 'package:eco_tycoon/features/game/domain/models/game_resources.dart';
import 'package:eco_tycoon/features/game/domain/models/planet_state.dart';

void main() {
  group('GameControls Widget Tests', () {
    testWidgets('Renders all control buttons', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: GameControls(),
            ),
          ),
        ),
      );

      // Verify basic controls are present
      expect(find.byIcon(Icons.play_arrow), findsOneWidget);
      expect(find.byIcon(Icons.refresh), findsOneWidget);
    });

    testWidgets('Play/Pause button toggles correctly',
        (WidgetTester tester) async {
      final gameNotifier = GameNotifier();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            gameNotifierProvider.overrideWith((ref) => gameNotifier),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: GameControls(),
            ),
          ),
        ),
      );

      // Initially shows play button
      expect(find.byIcon(Icons.play_arrow), findsOneWidget);
      expect(find.byIcon(Icons.pause), findsNothing);

      // Tap play button
      await tester.tap(find.byIcon(Icons.play_arrow));
      await tester.pumpAndSettle();

      // Should now show pause button
      expect(find.byIcon(Icons.pause), findsOneWidget);
      expect(find.byIcon(Icons.play_arrow), findsNothing);
    });

    testWidgets('Reset button triggers game restart',
        (WidgetTester tester) async {
      final gameNotifier = GameNotifier()
        ..state = GameState.initial().copyWith(isPlaying: true);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            gameNotifierProvider.overrideWith((ref) => gameNotifier),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: GameControls(),
            ),
          ),
        ),
      );

      // Tap reset button
      await tester.tap(find.byIcon(Icons.refresh));
      await tester.pumpAndSettle();

      // Verify game is restarted
      expect(gameNotifier.state.isPlaying,
          true); // startGame() sets isPlaying to true
      expect(gameNotifier.state.elapsedTime, 0);
    });

    testWidgets('Command buttons are present and styled correctly',
        (WidgetTester tester) async {
      final gameState = GameState.initial().copyWith(
        isPlaying: true,
        resources: const GameResources(
          water: 20, // Enough for both planting (10) and cleaning (5)
          energy: 20, // Enough for cleaning (10)
          soil: 10, // Enough for planting (5)
        ),
        planetState: const PlanetState(
          pollution: 50,
          trees: 0,
          score: 0,
          level: PlanetLevel.barren,
        ),
        treePositions: const [],
      );

      final gameNotifier = GameNotifier()..state = gameState;

      // Create test widget
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: Material(
            child: MediaQuery(
              data: const MediaQueryData(size: Size(800, 600)),
              child: Scaffold(
                body: Center(
                  child: ProviderScope(
                    overrides: [
                      gameNotifierProvider.overrideWith((ref) => gameNotifier),
                    ],
                    child: const GameControls(),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Find all text widgets
      final plantTreeText = find.text('Plant Tree');
      final cleanText = find.text('Clean');
      expect(plantTreeText, findsOneWidget);
      expect(cleanText, findsOneWidget);

      // Find the buttons directly from text widgets
      final plantTreeButton = find
          .ancestor(
            of: plantTreeText,
            matching: find.byWidgetPredicate(
              (widget) => widget.toString().contains('_ElevatedButtonWithIcon'),
            ),
          )
          .last; // Get the outermost button widget
      final cleanButton = find
          .ancestor(
            of: cleanText,
            matching: find.byWidgetPredicate(
              (widget) => widget.toString().contains('_ElevatedButtonWithIcon'),
            ),
          )
          .last; // Get the outermost button widget

      // Verify icons are present within the buttons
      final plantTreeIcon = find.descendant(
        of: find.byWidget(tester.widget(plantTreeButton)),
        matching: find.byIcon(Icons.park),
      );
      final cleanIcon = find.descendant(
        of: find.byWidget(tester.widget(cleanButton)),
        matching: find.byIcon(Icons.cleaning_services),
      );
      expect(plantTreeIcon, findsOneWidget);
      expect(cleanIcon, findsOneWidget);

      // Get the button widgets and verify they are enabled
      final plantTreeWidget = tester.widget(plantTreeButton);
      final cleanWidget = tester.widget(cleanButton);
      expect(plantTreeWidget.toString().contains('onPressed: null'), isFalse);
      expect(cleanWidget.toString().contains('onPressed: null'), isFalse);

      // Verify button colors by finding Material widgets
      final plantTreeMaterial = tester.widget<Material>(
        find
            .descendant(
              of: plantTreeButton,
              matching: find.byType(Material),
            )
            .first,
      );
      final cleanMaterial = tester.widget<Material>(
        find
            .descendant(
              of: cleanButton,
              matching: find.byType(Material),
            )
            .first,
      );
      expect(plantTreeMaterial.color, Colors.green);
      expect(cleanMaterial.color, Colors.blue);
    });
  });
}
