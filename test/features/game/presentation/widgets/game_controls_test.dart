import 'package:eco_tycoon/features/game/domain/providers/game_provider.dart';
import 'package:eco_tycoon/features/game/domain/commands/game_command.dart';
import 'package:eco_tycoon/features/game/domain/commands/game_command_factory.dart';
import 'package:eco_tycoon/features/game/presentation/widgets/game_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGameCommand extends Mock implements GameCommand {
  final bool _isEnabled;

  MockGameCommand(this._isEnabled);

  @override
  String get name => 'mock_command';

  @override
  String get label => 'Mock';

  @override
  IconData get icon => Icons.abc;

  @override
  Color get color => Colors.grey;

  @override
  bool get isEnabled => _isEnabled;
}

void main() {
  group('GameControls', () {
    late ProviderContainer container;
    late List<GameCommand> mockCommands;

    setUp(() {
      mockCommands = [
        MockGameCommand(true),
        MockGameCommand(true),
      ];

      final notifier = GameNotifier();
      container = ProviderContainer(
        overrides: [
          gameNotifierProvider.overrideWith((ref) => notifier),
        ],
      );

      GameCommandFactory.setCreateCommandsImpl((_, __) => mockCommands);
    });

    tearDown(() {
      // Stop any running game loops
      final notifier = container.read(gameNotifierProvider.notifier);
      notifier.pauseGame();
      
      GameCommandFactory.resetCreateCommandsImpl();
      container.dispose();
    });

    testWidgets('renders play and reset buttons', (WidgetTester tester) async {
      // Set up commands to be disabled
      mockCommands = [
        MockGameCommand(false),
        MockGameCommand(false),
      ];
      
      GameCommandFactory.setCreateCommandsImpl((_, __) => mockCommands);

      // Set up game state without starting game loop
      final notifier = container.read(gameNotifierProvider.notifier);
      notifier.state = notifier.state.copyWith(isPlaying: true);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(
            home: Material(
              child: Scaffold(
                body: GameControls(),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify basic controls
      expect(find.byType(IconButton), findsNWidgets(2), reason: 'Should find 2 IconButtons');
      expect(find.byIcon(Icons.pause), findsOneWidget, reason: 'Should find pause icon');
      expect(find.byIcon(Icons.refresh), findsOneWidget, reason: 'Should find refresh icon');

      // Verify command buttons are present but disabled
      expect(
        find.byWidgetPredicate(
          (widget) => widget.runtimeType.toString() == '_ElevatedButtonWithIcon',
        ),
        findsNWidgets(2),
        reason: 'Should find 2 ElevatedButton.icon widgets',
      );
      
      final elevatedButtons = tester.widgetList<ElevatedButton>(
        find.byWidgetPredicate(
          (widget) => widget.runtimeType.toString() == '_ElevatedButtonWithIcon',
        ),
      );
      
      for (final button in elevatedButtons) {
        expect(button.onPressed, isNull, reason: 'Button should be disabled');
      }
    });

    testWidgets('enables command buttons when resources are sufficient',
        (WidgetTester tester) async {
      // Set up commands to be enabled
      mockCommands = [
        MockGameCommand(true),
        MockGameCommand(true),
      ];
      
      GameCommandFactory.setCreateCommandsImpl((_, __) => mockCommands);

      // Set up initial state with sufficient resources
      final notifier = container.read(gameNotifierProvider.notifier);
      notifier.state = notifier.state.copyWith(isPlaying: true);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(
            home: Material(
              child: Scaffold(
                body: GameControls(),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify basic controls
      expect(find.byType(IconButton), findsNWidgets(2), reason: 'Should find 2 IconButtons');
      expect(find.byIcon(Icons.pause), findsOneWidget, reason: 'Should find pause icon');
      expect(find.byIcon(Icons.refresh), findsOneWidget, reason: 'Should find refresh icon');

      // Verify command buttons are present and enabled
      expect(
        find.byWidgetPredicate(
          (widget) => widget.runtimeType.toString() == '_ElevatedButtonWithIcon',
        ),
        findsNWidgets(2),
        reason: 'Should find 2 ElevatedButton.icon widgets',
      );
      
      final elevatedButtons = tester.widgetList<ElevatedButton>(
        find.byWidgetPredicate(
          (widget) => widget.runtimeType.toString() == '_ElevatedButtonWithIcon',
        ),
      );
      
      for (final button in elevatedButtons) {
        expect(button.onPressed, isNotNull, reason: 'Button should be enabled');
      }
    });

    testWidgets('disables command buttons when resources are insufficient',
        (WidgetTester tester) async {
      // Set up commands to be disabled
      mockCommands = [
        MockGameCommand(false),
        MockGameCommand(false),
      ];
      
      GameCommandFactory.setCreateCommandsImpl((_, __) => mockCommands);

      // Set up game state
      final notifier = container.read(gameNotifierProvider.notifier);
      notifier.state = notifier.state.copyWith(isPlaying: true);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(
            home: Material(
              child: Scaffold(
                body: GameControls(),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify basic controls
      expect(find.byType(IconButton), findsNWidgets(2), reason: 'Should find 2 IconButtons');
      expect(find.byIcon(Icons.pause), findsOneWidget, reason: 'Should find pause icon');
      expect(find.byIcon(Icons.refresh), findsOneWidget, reason: 'Should find refresh icon');

      // Verify command buttons are present but disabled
      expect(
        find.byWidgetPredicate(
          (widget) => widget.runtimeType.toString() == '_ElevatedButtonWithIcon',
        ),
        findsNWidgets(2),
        reason: 'Should find 2 ElevatedButton.icon widgets',
      );
      
      final elevatedButtons = tester.widgetList<ElevatedButton>(
        find.byWidgetPredicate(
          (widget) => widget.runtimeType.toString() == '_ElevatedButtonWithIcon',
        ),
      );
      
      for (final button in elevatedButtons) {
        expect(button.onPressed, isNull, reason: 'Button should be disabled');
      }
    });
  });
}
