import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:shipit_ui/src/components/app_card.dart';
import 'package:shipit_ui/src/components/app_shimmer.dart';
import 'package:shipit_ui/src/components/app_state_view.dart';

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

  group('AppStateView', () {
    testWidgets('loading state renders with message', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppStateView.loading(
              title: 'Loading',
              message: 'Loading data...',
            ),
          ),
        ),
      );

      expect(find.byType(AppShimmer), findsOneWidget);
      expect(find.text('Loading data...'), findsOneWidget);
    });

    testWidgets('empty state renders with title', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: AppStateView.empty(title: 'No Items')),
        ),
      );

      expect(find.text('No Items'), findsOneWidget);
    });

    testWidgets('empty state renders with message', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppStateView.empty(
              title: 'No Items',
              message: 'Create one to get started',
            ),
          ),
        ),
      );

      expect(find.text('Create one to get started'), findsOneWidget);
    });

    testWidgets('empty state renders with action', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppStateView.empty(
              title: 'No Items',
              actionLabel: 'Create',
              onAction: () {},
            ),
          ),
        ),
      );

      expect(find.text('Create'), findsOneWidget);
    });

    testWidgets('error state renders with title', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppStateView.error(title: 'Something Went Wrong'),
          ),
        ),
      );

      expect(find.text('Something Went Wrong'), findsOneWidget);
    });

    testWidgets('error state renders with message', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppStateView.error(title: 'Error', message: 'Failed to load'),
          ),
        ),
      );

      expect(find.text('Failed to load'), findsOneWidget);
    });

    testWidgets('error state renders with retry action', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppStateView.error(title: 'Error', onRetry: () {}),
          ),
        ),
      );

      expect(find.text('Retry'), findsOneWidget);
    });
  });
}
