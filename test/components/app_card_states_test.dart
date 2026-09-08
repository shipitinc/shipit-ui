import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:shipit_ui/src/components/app_card.dart';

void main() {
  group('AppCard', () {
    testWidgets('card renders with title', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppCard(title: 'Card Title')),
        ),
      );

      expect(find.text('Card Title'), findsOneWidget);
    });

    testWidgets('card renders with subtitle', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppCard(title: 'Title', subtitle: 'Subtitle'),
          ),
        ),
      );

      expect(find.text('Subtitle'), findsOneWidget);
    });

    testWidgets('card renders with child', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppCard(child: Text('Card Content'))),
        ),
      );

      expect(find.text('Card Content'), findsOneWidget);
    });

    testWidgets('card with onTap is tappable', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppCard(title: 'Tappable', onTap: () => tapped = true),
          ),
        ),
      );

      await tester.tap(find.byType(AppCard));
      await tester.pump();

      expect(tapped, isTrue);
    });
  });
}
