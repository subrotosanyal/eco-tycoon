import 'package:eco_tycoon/features/game/domain/models/tree_position.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eco_tycoon/features/game/presentation/widgets/game_stats.dart';
import 'package:eco_tycoon/features/game/domain/models/game_state.dart';
import 'package:eco_tycoon/features/game/domain/models/planet_state.dart';
import 'package:eco_tycoon/features/game/domain/providers/game_provider.dart';

void main() {
  group('GameStats Widget Tests', () {
    testWidgets('Displays all game statistics', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: GameStats(),
            ),
          ),
        ),
      );

      // Verify all stat icons are present
      expect(find.byIcon(Icons.emoji_events), findsOneWidget); // Score
      expect(find.byIcon(Icons.terrain), findsOneWidget); // Planet Level
      expect(find.byIcon(Icons.cloud), findsOneWidget); // Pollution
      expect(find.byIcon(Icons.park), findsOneWidget); // Tree Count
      expect(find.byIcon(Icons.timer), findsOneWidget); // Time
    });

    testWidgets('Shows correct stat values', (WidgetTester tester) async {
      final gameNotifier = GameNotifier()
        ..state = GameState.initial().copyWith(
          planetState: const PlanetState(
            level: PlanetLevel.thriving,
            score: 1000,
            pollution: 50,
            trees: 5,
          ),
          elapsedTime: 60,
          treePositions: [
            const TreePosition(x: 0, y: 0),
            const TreePosition(x: 0.1, y: 0.1),
            const TreePosition(x: 0.2, y: 0.2),
            const TreePosition(x: 0.3, y: 0.3),
            const TreePosition(x: 0.4, y: 0.4),
          ],
        );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            gameNotifierProvider.overrideWith((ref) => gameNotifier),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: GameStats(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify stat values are displayed correctly
      expect(find.text('1000'), findsOneWidget); // Score
      expect(find.text('Thriving'), findsOneWidget); // Planet Level
      expect(find.text('50%'), findsOneWidget); // Pollution
      expect(find.text('5'), findsOneWidget); // Tree Count
      expect(find.text('01:00'), findsOneWidget); // Time
    });

    testWidgets('Adapts layout based on screen size',
        (WidgetTester tester) async {
      // Test desktop layout
      await tester.binding.setSurfaceSize(const Size(1000, 800));
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            builder: (context, child) {
              return MediaQuery(
                data: const MediaQueryData(size: Size(1000, 800)),
                child: child!,
              );
            },
            home: const Scaffold(
              body: GameStats(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final desktopWrap = tester.widget<Wrap>(find.byType(Wrap));
      expect(desktopWrap.spacing, 24.0);

      // Test mobile layout
      await tester.binding.setSurfaceSize(const Size(400, 800));
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            builder: (context, child) {
              return MediaQuery(
                data: const MediaQueryData(size: Size(400, 800)),
                child: child!,
              );
            },
            home: const Scaffold(
              body: GameStats(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final mobileWrap = tester.widget<Wrap>(find.byType(Wrap));
      expect(mobileWrap.spacing, 12.0);
    });

    testWidgets('Updates when game state changes', (WidgetTester tester) async {
      final gameNotifier = GameNotifier()
        ..state = GameState.initial().copyWith(
          planetState: const PlanetState(
            level: PlanetLevel.thriving,
            score: 1000,
            pollution: 50,
            trees: 5,
          ),
          treePositions: [
            const TreePosition(x: 0, y: 0),
            const TreePosition(x: 0.1, y: 0.1),
            const TreePosition(x: 0.2, y: 0.2),
            const TreePosition(x: 0.3, y: 0.3),
            const TreePosition(x: 0.4, y: 0.4),
          ],
        );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            gameNotifierProvider.overrideWith((ref) => gameNotifier),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: GameStats(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Update game state
      gameNotifier.state = gameNotifier.state.copyWith(
        planetState: const PlanetState(
          level: PlanetLevel.thriving,
          score: 2000,
          pollution: 25,
          trees: 10,
        ),
        treePositions:
            List.generate(10, (i) => TreePosition(x: i * 0.1, y: i * 0.1)),
      );
      await tester.pumpAndSettle();

      // Verify updated values
      expect(find.text('2000'), findsOneWidget);
      expect(find.text('Thriving'), findsOneWidget);
      expect(find.text('25%'), findsOneWidget);
      expect(find.text('10'), findsOneWidget);
    });
  });
}
