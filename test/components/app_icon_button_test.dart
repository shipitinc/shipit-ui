import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:shipit_ui/src/components/app_button.dart';
import 'package:shipit_ui/src/components/app_icon_button.dart';
import 'package:shipit_ui/src/theme/tokens/app_color_tokens.dart';

void main() {
  group('AppIconButton', () {
    testWidgets('renders icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppIconButton(
              icon: Icons.visibility,
              tooltip: 'Show password',
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.visibility), findsOneWidget);
      expect(find.byType(AppIconButton), findsOneWidget);
    });

    testWidgets('uses secondary foreground by default', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppIconButton(icon: Icons.visibility, tooltip: 'Show'),
          ),
        ),
      );

      final icon = tester.widget<Icon>(find.byIcon(Icons.visibility));
      expect(icon.color, AppPrimitiveColors.neutral600);
    });

    testWidgets('taps fire onPressed', (tester) async {
      var pressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppIconButton(
              icon: Icons.visibility,
              tooltip: 'Show password',
              onPressed: () => pressed = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(AppIconButton));
      await tester.pump();

      expect(pressed, isTrue);
    });

    testWidgets('disabled button is not interactive', (tester) async {
      var pressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppIconButton(
              icon: Icons.visibility,
              tooltip: 'Show password',
              state: AppButtonState.disabled,
              onPressed: () => pressed = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(AppIconButton));
      await tester.pump();

      expect(pressed, isFalse);
      final icon = tester.widget<Icon>(find.byIcon(Icons.visibility));
      expect(icon.color, AppPrimitiveColors.neutral400);
    });

    testWidgets('loading button shows loading state', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppIconButton(
              icon: Icons.visibility,
              tooltip: 'Show password',
              state: AppButtonState.loading,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('exposes tooltip to Material Tooltip and semantics', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppIconButton(
              icon: Icons.visibility,
              tooltip: 'Show password',
              onPressed: () {},
            ),
          ),
        ),
      );

      final tooltip = tester.widget<Tooltip>(find.byType(Tooltip));
      expect(tooltip.message, 'Show password');

      final handle = tester.ensureSemantics();
      expect(find.bySemanticsLabel('Show password'), findsOneWidget);
      handle.dispose();
    });

    testWidgets('sizes to the 44px tap target', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: AppIconButton(
                icon: Icons.visibility,
                tooltip: 'Show password',
                onPressed: () {},
              ),
            ),
          ),
        ),
      );

      final size = tester.getSize(find.byType(AppIconButton));
      expect(size.width, 44);
      expect(size.height, 44);
    });

    testWidgets('semanticLabel is applied to exactly one widget', (
      tester,
    ) async {
      const key = Key('toggle-visibility');
      var tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                AppIconButton(
                  icon: Icons.visibility,
                  tooltip: 'Show password',
                  semanticLabel: key,
                  onPressed: () => tapped = true,
                ),
                const AppIconButton(
                  icon: Icons.settings,
                  tooltip: 'Settings',
                  semanticLabel: Key('settings'),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byKey(key), findsOneWidget);
      expect(find.byKey(const Key('settings')), findsOneWidget);
      await tester.tap(find.byKey(key));
      expect(tapped, isTrue);
    });

    testWidgets('renders without a tooltip', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppIconButton(icon: Icons.edit, onPressed: () {}),
          ),
        ),
      );

      expect(find.byIcon(Icons.edit), findsOneWidget);
      expect(find.byType(Tooltip), findsNothing);
    });
  });
}
