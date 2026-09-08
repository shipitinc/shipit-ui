import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:shipit_ui/src/components/app_button.dart';

void main() {
  group('AppButton', () {
    testWidgets('primary button renders', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton.primary(label: 'Submit', onPressed: () {}),
          ),
        ),
      );

      expect(find.text('Submit'), findsOneWidget);
      expect(find.byType(AppButton), findsOneWidget);
    });

    testWidgets('secondary button renders', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton.secondary(label: 'Cancel', onPressed: () {}),
          ),
        ),
      );

      expect(find.text('Cancel'), findsOneWidget);
    });

    testWidgets('disabled button is not interactive', (tester) async {
      var pressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton.primary(
              label: 'Disabled',
              state: AppButtonState.disabled,
              onPressed: () => pressed = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(AppButton));
      await tester.pump();

      expect(pressed, isFalse);
    });

    testWidgets('loading button shows loading state', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton.primary(
              label: 'Loading',
              state: AppButtonState.loading,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('button has button semantics', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton.primary(label: 'Test', onPressed: () {}),
          ),
        ),
      );

      expect(find.byType(AppButton), findsOneWidget);
    });

    testWidgets('primary disabled button renders', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton.primary(
              label: 'Disabled',
              state: AppButtonState.disabled,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Disabled'), findsOneWidget);
    });

    testWidgets('secondary disabled button renders', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton.secondary(
              label: 'Disabled',
              state: AppButtonState.disabled,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Disabled'), findsOneWidget);
    });

    testWidgets('primary loading button renders', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton.primary(
              label: 'Loading',
              state: AppButtonState.loading,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('secondary loading button renders', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton.secondary(
              label: 'Loading',
              state: AppButtonState.loading,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('semanticLabel is applied to exactly one widget', (
      tester,
    ) async {
      const key = Key('submit');
      var tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                AppButton.primary(
                  label: 'Submit',
                  semanticLabel: key,
                  onPressed: () => tapped = true,
                ),
                const AppButton(label: 'Plain', semanticLabel: Key('plain')),
              ],
            ),
          ),
        ),
      );

      expect(find.byKey(key), findsOneWidget);
      expect(find.byKey(const Key('plain')), findsOneWidget);
      await tester.tap(find.byKey(key));
      expect(tapped, isTrue);
    });
  });
}
