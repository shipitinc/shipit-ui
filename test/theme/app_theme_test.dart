import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shipit_ui/src/theme/app_theme.dart';
import 'package:shipit_ui/src/foundation/app_colors.dart';
import 'package:shipit_ui/src/theme/app_palette.dart';

void main() {
  group('AppTheme', () {
    test('light theme is created', () {
      final theme = shipitLightTheme();
      expect(theme, isNotNull);
      expect(theme.useMaterial3, true);
      expect(theme.brightness, Brightness.light);
    });

    test('dark theme is created', () {
      final theme = shipitDarkTheme();
      expect(theme, isNotNull);
      expect(theme.useMaterial3, true);
      expect(theme.brightness, Brightness.dark);
    });

    test('light theme has correct color scheme', () {
      final theme = shipitLightTheme();
      expect(theme.colorScheme.primary, AppColors.actionPrimary);
      expect(theme.colorScheme.onPrimary, AppColors.textOnPrimary);
      expect(theme.colorScheme.error, AppColors.stateError);
    });

    test('dark theme has dark color scheme', () {
      final theme = shipitDarkTheme();
      expect(theme.colorScheme.brightness, Brightness.dark);
    });

    test('light theme has text theme', () {
      final theme = shipitLightTheme();
      expect(theme.textTheme.bodyLarge, isNotNull);
      expect(theme.textTheme.titleMedium, isNotNull);
    });

    test('dark theme has text theme', () {
      final theme = shipitDarkTheme();
      expect(theme.textTheme.bodyLarge, isNotNull);
      expect(theme.textTheme.titleMedium, isNotNull);
    });
  });

  group('Dark theme (issue #10)', () {
    final theme = shipitDarkTheme();

    test('surfaces are dark and foregrounds are light', () {
      for (final surface in [
        theme.scaffoldBackgroundColor,
        theme.colorScheme.surface,
        theme.cardTheme.color,
        theme.appBarTheme.backgroundColor,
        theme.inputDecorationTheme.fillColor,
        theme.dialogTheme.backgroundColor,
      ]) {
        expect(surface!.computeLuminance(), lessThan(0.05), reason: '$surface');
      }
      for (final fg in [
        theme.colorScheme.onSurface,
        theme.textTheme.bodyLarge!.color,
        theme.textTheme.headlineMedium!.color,
        theme.appBarTheme.foregroundColor,
      ]) {
        expect(fg!.computeLuminance(), greaterThan(0.6), reason: '$fg');
      }
    });

    test('body text on scaffold meets WCAG AA contrast', () {
      double contrast(Color a, Color b) {
        final la = a.computeLuminance() + 0.05;
        final lb = b.computeLuminance() + 0.05;
        return la > lb ? la / lb : lb / la;
      }

      expect(
        contrast(
          theme.textTheme.bodyMedium!.color!,
          theme.scaffoldBackgroundColor,
        ),
        greaterThan(4.5),
      );
      expect(
        contrast(theme.textTheme.bodyMedium!.color!, theme.colorScheme.surface),
        greaterThan(4.5),
      );
      expect(
        contrast(theme.colorScheme.error, theme.colorScheme.surface),
        greaterThan(4.5),
      );
    });

    test('uses the dark semantic tokens', () {
      expect(theme.scaffoldBackgroundColor, AppColorsDark.bgBaseColor);
      expect(theme.colorScheme.surface, AppColorsDark.bgSurfaceColor);
      expect(theme.colorScheme.onSurface, AppColorsDark.fgPrimaryColor);
      expect(theme.colorScheme.outline, AppColorsDark.borderDefaultColor);
      expect(theme.colorScheme.error, AppColorsDark.stateErrorFgColor);
      expect(theme.extension<AppPalette>(), same(AppPalette.dark));
      expect(
        shipitLightTheme().extension<AppPalette>(),
        same(AppPalette.light),
      );
    });

    testWidgets('Scaffold + Text renders light-on-dark in ThemeMode.dark', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: shipitLightTheme(),
          darkTheme: shipitDarkTheme(),
          themeMode: ThemeMode.dark,
          home: const Scaffold(body: Text('Visible')),
        ),
      );
      final context = tester.element(find.text('Visible'));
      final scaffoldColor = Theme.of(context).scaffoldBackgroundColor;
      final textColor = DefaultTextStyle.of(context).style.color!;
      expect(scaffoldColor.computeLuminance(), lessThan(0.05));
      expect(textColor.computeLuminance(), greaterThan(0.6));
      expect(AppPalette.of(context), same(AppPalette.dark));
    });

    test('light and dark palettes cover the same token set', () {
      expect(AppPalette.light.brightness, Brightness.light);
      expect(AppPalette.dark.brightness, Brightness.dark);
      expect(
        AppPalette.light.fgPrimary.computeLuminance(),
        lessThan(AppPalette.dark.fgPrimary.computeLuminance()),
      );
      expect(
        AppPalette.light.bgBase.computeLuminance(),
        greaterThan(AppPalette.dark.bgBase.computeLuminance()),
      );
    });
  });
}
