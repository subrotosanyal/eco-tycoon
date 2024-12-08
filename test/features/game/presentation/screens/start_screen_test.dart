import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eco_tycoon/features/game/presentation/screens/start_screen.dart';
import 'package:eco_tycoon/features/game/presentation/screens/game_screen.dart';
import 'package:eco_tycoon/features/game/domain/providers/game_provider.dart';

void main() {
  group('StartScreen Widget Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      final gameNotifier = container.read(gameNotifierProvider.notifier);
      gameNotifier.stopGame();
      container.dispose();
    });

    testWidgets('displays all required sections and elements',
        (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1200));

      await tester.pumpWidget(
        ProviderScope(
          parent: container,
          child: const MaterialApp(
            home: StartScreen(),
          ),
        ),
      );

      // Verify title and subtitle
      expect(find.text('Eco Tycoon'), findsOneWidget);
      expect(find.text('Save the Planet!'), findsOneWidget);

      // Verify section headings
      expect(find.text('How to Play:'), findsOneWidget);
      expect(find.text('Victory Conditions:'), findsOneWidget);
      expect(find.text('Resources:'), findsOneWidget);

      // Verify game rules
      expect(find.text('Plant trees to generate resources'), findsOneWidget);
      expect(find.text('Clean pollution to save the planet'), findsOneWidget);
      expect(find.text('Manage your resources wisely'), findsOneWidget);
      expect(find.text('Act quickly - faster completion means higher scores!'),
          findsOneWidget);

      // Verify victory conditions
      expect(find.text('Plant at least 20 trees'), findsOneWidget);
      expect(find.text('Keep pollution below 30%'), findsOneWidget);
      expect(find.text('Bonus points for faster completion'), findsOneWidget);

      // Verify resources
      expect(find.text('Water: Used for planting trees'), findsOneWidget);
      expect(find.text('Energy: Powers pollution cleanup'), findsOneWidget);
      expect(find.text('Soil: Required for tree growth'), findsOneWidget);
    });

    testWidgets('start button initializes game and navigates',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          parent: container,
          child: const MaterialApp(
            home: StartScreen(),
          ),
        ),
      );

      final startButton = find.widgetWithText(ElevatedButton, 'Start Game');
      expect(startButton, findsOneWidget);

      // Get initial state for comparison
      final initialState = container.read(gameNotifierProvider);
      expect(initialState.isPlaying, false);

      await tester.ensureVisible(startButton);
      await tester.tap(startButton);

      // Pump a frame to start the navigation
      await tester.pump();

      final gameState = container.read(gameNotifierProvider);
      expect(gameState.isPlaying, true);
      expect(gameState.gameOver, false);
      expect(gameState.elapsedTime >= 0, true);

      // Pump frames to complete the navigation animation
      await tester.pumpAndSettle();

      expect(find.byType(StartScreen), findsNothing);
      expect(find.byType(GameScreen), findsOneWidget);

      // Clean up game state
      final gameNotifier = container.read(gameNotifierProvider.notifier);
      gameNotifier.stopGame();
    });

    testWidgets('scrolls to show all content', (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 400));

      await tester.pumpWidget(
        ProviderScope(
          parent: container,
          child: const MaterialApp(
            home: StartScreen(),
          ),
        ),
      );

      expect(find.text('Eco Tycoon'), findsOneWidget);

      final scrollable = find.byType(SingleChildScrollView);
      expect(scrollable, findsOneWidget);

      const targetText = 'Soil: Required for tree growth';
      final target = find.text(targetText);

      await tester.drag(scrollable, const Offset(0, -100));
      await tester.pump();

      expect(tester.any(target), true);
    });
  });
}
