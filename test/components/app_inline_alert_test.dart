import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shipit_ui/src/components/app_inline_alert.dart';
import 'package:shipit_ui/src/theme/app_theme_tokens.dart';

Widget _wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

BoxDecoration _decoration(WidgetTester tester) =>
    tester
            .widget<Container>(
              find
                  .descendant(
                    of: find.byType(AppInlineAlert),
                    matching: find.byType(Container),
                  )
                  .first,
            )
            .decoration!
        as BoxDecoration;

void main() {
  group('AppInlineAlert', () {
    testWidgets('renders title and message', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const AppInlineAlert.error(
            title: 'Could not load members',
            message: 'Check your connection.',
          ),
        ),
      );

      expect(find.text('Could not load members'), findsOneWidget);
      expect(find.text('Check your connection.'), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });

    testWidgets('applies severity colors and icons', (tester) async {
      final state = AppTheme.light.color.state;
      final cases = {
        AppInlineAlertSeverity.error: (
          state.error.bg,
          state.error.fg,
          Icons.error_outline,
        ),
        AppInlineAlertSeverity.warning: (
          state.warning.bg,
          state.warning.fg,
          Icons.warning_amber_rounded,
        ),
        AppInlineAlertSeverity.info: (
          state.info.bg,
          state.info.fg,
          Icons.info_outline,
        ),
        AppInlineAlertSeverity.success: (
          state.success.bg,
          state.success.fg,
          Icons.check_circle_outline,
        ),
      };
      for (final entry in cases.entries) {
        await tester.pumpWidget(
          _wrap(AppInlineAlert(severity: entry.key, title: 'Title')),
        );
        final decoration = _decoration(tester);
        expect(decoration.color, entry.value.$1);
        expect(decoration.border!.top.color, entry.value.$2);
        expect(find.byIcon(entry.value.$3), findsOneWidget);
      }
    });

    testWidgets('dismiss control only shown with onDismiss', (tester) async {
      await tester.pumpWidget(_wrap(const AppInlineAlert.info(title: 'Hi')));
      expect(find.byKey(AppInlineAlert.dismissKey), findsNothing);

      var dismissed = false;
      await tester.pumpWidget(
        _wrap(
          AppInlineAlert.info(title: 'Hi', onDismiss: () => dismissed = true),
        ),
      );
      await tester.tap(find.byKey(AppInlineAlert.dismissKey));
      expect(dismissed, isTrue);
    });

    testWidgets('action fires onAction', (tester) async {
      var retried = false;
      await tester.pumpWidget(
        _wrap(
          AppInlineAlert.error(
            title: 'Failed',
            actionLabel: 'Retry',
            onAction: () => retried = true,
          ),
        ),
      );

      await tester.tap(find.byKey(AppInlineAlert.actionKey));
      expect(retried, isTrue);
      expect(find.text('Retry'), findsOneWidget);
    });

    testWidgets('exposes live-region semantics', (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        _wrap(
          const AppInlineAlert.error(
            title: 'Failed',
            message: 'Try again',
            semanticLabel: Key('alert'),
          ),
        ),
      );
      expect(
        tester.getSemantics(find.byKey(const Key('alert'))),
        isSemantics(label: 'error. Failed. Try again', isLiveRegion: true),
      );
      handle.dispose();
    });
  });
}
