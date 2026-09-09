import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:shipit_ui/src/components/app_button.dart';
import 'package:shipit_ui/src/components/app_text_button.dart';
import 'package:shipit_ui/src/theme/tokens/app_color_tokens.dart';

void main() {
  group('AppTextButton', () {
    testWidgets('renders label', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTextButton(label: 'Forgot password?', onPressed: () {}),
          ),
        ),
      );

      expect(find.text('Forgot password?'), findsOneWidget);
      expect(find.byType(AppTextButton), findsOneWidget);
    });

    testWidgets('uses primary action colour by default', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppTextButton(label: 'Forgot password?')),
        ),
      );

      final text = tester.widget<Text>(find.text('Forgot password?'));
      expect(text.style?.color, AppPrimitiveColors.accent600);
    });

    testWidgets('taps fire onPressed', (tester) async {
      var pressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTextButton(
              label: 'Forgot password?',
              onPressed: () => pressed = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(AppTextButton));
      await tester.pump();

      expect(pressed, isTrue);
    });

    testWidgets('disabled button is not interactive', (tester) async {
      var pressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTextButton(
              label: 'Forgot password?',
              state: AppButtonState.disabled,
              onPressed: () => pressed = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(AppTextButton));
      await tester.pump();

      expect(pressed, isFalse);
      final text = tester.widget<Text>(find.text('Forgot password?'));
      expect(text.style?.color, AppPrimitiveColors.neutral400);
    });

    testWidgets('loading button shows loading state', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTextButton(
              label: 'Forgot password?',
              state: AppButtonState.loading,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('has button semantics', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppTextButton(label: 'Forgot password?')),
        ),
      );

      final semantics = tester.getSemantics(find.byType(AppTextButton));
      final flags = semantics.getSemanticsData().flagsCollection;
      expect(flags.isButton, isTrue);
      expect(semantics.label, 'Forgot password?');
    });

    testWidgets('hugs its label within a 44px tap target', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: AppTextButton(label: 'Forgot password?', onPressed: () {}),
            ),
          ),
        ),
      );

      expect(tester.getSize(find.byType(AppTextButton)).height, 44);
    });

    testWidgets('semanticLabel is applied to exactly one widget', (
      tester,
    ) async {
      const key = Key('forgot');
      var tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                AppTextButton(
                  label: 'Forgot password?',
                  semanticLabel: key,
                  onPressed: () => tapped = true,
                ),
                const AppTextButton(
                  label: 'Plain',
                  semanticLabel: Key('plain'),
                ),
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
