import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eco_tycoon/features/game/presentation/widgets/planet_view.dart';

void main() {
  group('PlanetView Widget Tests', () {
    testWidgets('PlanetView maintains correct layout on different screen sizes',
        (WidgetTester tester) async {
      const desktopSize = Size(800, 600);
      const mobileSize = Size(400, 800);

      // Test desktop layout
      await tester.binding.setSurfaceSize(desktopSize);
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            builder: (context, child) {
              return MediaQuery(
                data: const MediaQueryData(size: desktopSize),
                child: child!,
              );
            },
            home: const Scaffold(
              body: PlanetView(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Find the container that holds the planet
      final planetContainer = find
          .descendant(
            of: find.byType(PlanetView),
            matching: find.byType(Container),
          )
          .evaluate()
          .first
          .widget as Container;

      // Verify planet size is 40% of screen width on desktop
      final desktopConstraints = planetContainer.constraints as BoxConstraints;
      expect(desktopConstraints.maxWidth, desktopSize.width * 0.4);

      // Test mobile layout
      await tester.binding.setSurfaceSize(mobileSize);
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            builder: (context, child) {
              return MediaQuery(
                data: const MediaQueryData(size: mobileSize),
                child: child!,
              );
            },
            home: const Scaffold(
              body: PlanetView(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Find the container again after resize
      final mobilePlanetContainer = find
          .descendant(
            of: find.byType(PlanetView),
            matching: find.byType(Container),
          )
          .evaluate()
          .first
          .widget as Container;

      // Verify planet size is 70% of screen width on mobile
      final mobileConstraints =
          mobilePlanetContainer.constraints as BoxConstraints;
      expect(mobileConstraints.maxWidth, mobileSize.width * 0.7);
    });

    testWidgets('PlanetView maintains aspect ratio',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: PlanetView(),
            ),
          ),
        ),
      );

      final aspectRatio =
          find.byType(AspectRatio).evaluate().first.widget as AspectRatio;
      expect(aspectRatio.aspectRatio, 1.0);
    });

    testWidgets('PlanetView centers content', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: PlanetView(),
            ),
          ),
        ),
      );

      final center = find.byType(Center);
      expect(center, findsOneWidget);
    });

    testWidgets('Game controls maintain position after planting trees',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: PlanetView(),
            ),
          ),
        ),
      );

      // Record initial layout of the planet container
      final planetContainer = find.descendant(
        of: find.byType(PlanetView),
        matching: find.byType(Container),
      );
      final initialRect = tester.getRect(planetContainer);

      // Simulate planting a tree
      await tester.tapAt(Offset(
        tester.getCenter(find.byType(PlanetView)).dx,
        tester.getCenter(find.byType(PlanetView)).dy,
      ));
      await tester.pumpAndSettle();

      // Verify layout hasn't changed
      final finalRect = tester.getRect(planetContainer);
      expect(initialRect, finalRect);
    });
  });
}
