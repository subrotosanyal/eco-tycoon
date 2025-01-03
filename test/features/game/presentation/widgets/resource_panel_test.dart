import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eco_tycoon/features/game/presentation/widgets/resource_panel.dart';
import 'package:eco_tycoon/features/game/domain/models/game_resources.dart';
import 'package:eco_tycoon/features/game/domain/models/game_state.dart';
import 'package:eco_tycoon/features/game/domain/providers/game_provider.dart';
import 'package:eco_tycoon/features/game/domain/models/resources.dart';

void main() {
  group('ResourcePanel Widget Tests', () {
    testWidgets('Displays all resource indicators', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: ResourcePanel(),
            ),
          ),
        ),
      );

      // Verify all resource icons are present
      expect(find.byIcon(Icons.water_drop), findsOneWidget); // Water
      expect(find.byIcon(Icons.bolt), findsOneWidget); // Energy
      expect(find.byIcon(Icons.landscape), findsOneWidget); // Soil
    });

    testWidgets('Shows correct resource values', (WidgetTester tester) async {
      const testResources = GameResources(
        water: WaterResource(amount: 50),
        energy: EnergyResource(amount: 75),
        soil: SoilResource(amount: 100),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            gameNotifierProvider.overrideWith((ref) => GameNotifier()
              ..state = GameState.initial().copyWith(resources: testResources)),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: ResourcePanel(),
            ),
          ),
        ),
      );

      // Verify resource values are displayed correctly
      expect(find.text('50'), findsOneWidget); // Water
      expect(find.text('75'), findsOneWidget); // Energy
      expect(find.text('100'), findsOneWidget); // Soil
    });

    testWidgets('Resource indicators are evenly spaced', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: ResourcePanel(),
            ),
          ),
        ),
      );

      // Find the container that holds the resource indicators
      final container = find.byType(Container);
      expect(container, findsOneWidget);

      // Find the Row inside the Container
      final row = find.descendant(
        of: container,
        matching: find.byType(Row),
      ).first;

      // Verify Row uses spaceEvenly alignment
      final rowWidget = tester.widget<Row>(row);
      expect(rowWidget.mainAxisAlignment, MainAxisAlignment.spaceEvenly);
    });

    testWidgets('Updates when resources change', (WidgetTester tester) async {
      final gameNotifier = GameNotifier()
        ..state = GameState.initial().copyWith(
          resources: const GameResources(
            water: WaterResource(amount: 100),
            energy: EnergyResource(amount: 100),
            soil: SoilResource(amount: 100),
          ),
        );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            gameNotifierProvider.overrideWith((ref) => gameNotifier),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: ResourcePanel(),
            ),
          ),
        ),
      );

      // Initial values
      expect(find.text('100'), findsNWidgets(3));

      // Update resources
      gameNotifier.state = gameNotifier.state.copyWith(
        resources: const GameResources(
          water: WaterResource(amount: 50),
          energy: EnergyResource(amount: 50),
          soil: SoilResource(amount: 50),
        ),
      );
      await tester.pumpAndSettle();

      // Verify updated values
      expect(find.text('50'), findsNWidgets(3));
    });
  });
}
