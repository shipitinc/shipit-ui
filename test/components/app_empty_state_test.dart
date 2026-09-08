import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shipit_ui/src/components/app_empty_state.dart';

Widget _wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

void main() {
  group('AppEmptyState', () {
    testWidgets('renders title, message and default icon', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const AppEmptyState(
            title: 'No Items',
            message: 'Create one to get started',
          ),
        ),
      );

      expect(find.text('No Items'), findsOneWidget);
      expect(find.text('Create one to get started'), findsOneWidget);
      expect(find.byIcon(Icons.inbox), findsOneWidget);
    });

    testWidgets('renders custom icon and action', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        _wrap(
          AppEmptyState(
            title: 'No Items',
            icon: Icons.search_off,
            actionLabel: 'Create',
            onAction: () => tapped = true,
          ),
        ),
      );

      expect(find.byIcon(Icons.search_off), findsOneWidget);
      await tester.tap(find.text('Create'));
      expect(tapped, isTrue);
    });

    testWidgets('hides action without label', (tester) async {
      await tester.pumpWidget(
        _wrap(AppEmptyState(title: 'No Items', onAction: () {})),
      );
      expect(find.byType(TextButton), findsNothing);
    });

    testWidgets('exposes combined semantics label', (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        _wrap(
          const AppEmptyState(
            title: 'No Items',
            message: 'Nothing here',
            semanticLabel: Key('empty'),
          ),
        ),
      );
      expect(
        tester.getSemantics(find.byKey(const Key('empty'))),
        isSemantics(label: 'No Items. Nothing here'),
      );
      handle.dispose();
    });
  });
}
