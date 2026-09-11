import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shipit_ui/src/theme/app_theme.dart';
import 'package:shipit_ui/src/theme/app_theme_tokens.dart';

double _contrast(Color a, Color b) {
  final la = a.computeLuminance() + 0.05;
  final lb = b.computeLuminance() + 0.05;
  return la > lb ? la / lb : lb / la;
}

void main() {
  group('shipit themes', () {
    test('light theme is built from AppTheme.light', () {
      final theme = shipitLightTheme();
      expect(theme.useMaterial3, true);
      expect(theme.brightness, Brightness.light);
      expect(theme.extension<AppTheme>(), same(AppTheme.light));
      expect(theme.colorScheme.primary, AppTheme.light.color.action.primary.bg);
      expect(theme.colorScheme.error, AppTheme.light.color.state.error.fg);
      expect(theme.scaffoldBackgroundColor, AppTheme.light.color.bg.base);
      expect(
        theme.textTheme.bodyMedium!.color,
        AppTheme.light.text.body.medium.color,
      );
      expect(
        theme.textTheme.bodyMedium!.fontFamily,
        'packages/shipit_ui/Inter',
      );
    });

    test('dark theme uses dark tokens with readable contrast (issue #10)', () {
      final theme = shipitDarkTheme();
      final c = AppTheme.dark.color;
      expect(theme.brightness, Brightness.dark);
      expect(theme.extension<AppTheme>(), same(AppTheme.dark));
      expect(theme.scaffoldBackgroundColor, c.bg.base);
      expect(theme.colorScheme.surface, c.bg.surface);
      expect(theme.colorScheme.onSurface, c.fg.primary);
      expect(theme.colorScheme.outline, c.border.base);
      for (final surface in [
        theme.scaffoldBackgroundColor,
        theme.colorScheme.surface,
        theme.cardTheme.color!,
        theme.appBarTheme.backgroundColor!,
        theme.inputDecorationTheme.fillColor!,
        theme.dialogTheme.backgroundColor!,
      ]) {
        expect(surface.computeLuminance(), lessThan(0.05), reason: '$surface');
      }
      expect(
        _contrast(
          theme.textTheme.bodyMedium!.color!,
          theme.colorScheme.surface,
        ),
        greaterThan(4.5),
      );
      expect(
        _contrast(theme.colorScheme.error, theme.colorScheme.surface),
        greaterThan(4.5),
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
      expect(
        Theme.of(context).scaffoldBackgroundColor.computeLuminance(),
        lessThan(0.05),
      );
      expect(
        DefaultTextStyle.of(context).style.color!.computeLuminance(),
        greaterThan(0.6),
      );
      expect(context.appTheme, same(AppTheme.dark));
      expect(context.color.bg.base, AppTheme.dark.color.bg.base);
    });

    testWidgets('context.* falls back by brightness without shipit theme', (
      tester,
    ) async {
      late BuildContext captured;
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.dark(),
          home: Builder(
            builder: (context) {
              captured = context;
              return const SizedBox();
            },
          ),
        ),
      );
      expect(captured.appTheme, same(AppTheme.dark));
      expect(captured.space.s4, 16);
      expect(captured.radius.all.md, BorderRadius.circular(8));
      expect(captured.font.weight.semibold, FontWeight.w600);
      expect(captured.icon.size.sm, 16);
      expect(captured.layout.maxWidth.form, 440);
    });
  });

  group('AppTheme tokens', () {
    test('token paths mirror Penpot names', () {
      final c = AppTheme.light.color;
      expect(c.bg.base, const Color(0xFFF8FAFC));
      expect(c.border.base, const Color(0xFFCBD5E1));
      expect(c.state.error.fg, const Color(0xFFDC2626));
      expect(c.nav.unselected.fg, const Color(0xFF475569));
      expect(c.table.header.bg, const Color(0xFFF1F5F9));
      expect(c.chip.selected.border, const Color(0xFF2563EB));
      expect(AppTheme.light.space.s4, 16);
      expect(AppTheme.light.radius.md, 8);
      expect(AppTheme.light.font.size.xxl, 24);
      expect(AppTheme.light.motion.duration.shimmer.inMilliseconds, 1200);
      expect(AppTheme.light.elevation.e2.single.blurRadius, 8);
      expect(AppTheme.light.opacity.scrim, 0.4);
      expect(AppTheme.light.breakpoint.desktop, 1024);
      expect(AppTheme.light.icon.size.sm, 16);
      expect(AppTheme.light.layout.maxWidth.form, 440);
    });

    test('text styles resolve bundled Inter and brightness colour', () {
      final light = AppTheme.light.text, dark = AppTheme.dark.text;
      expect(light.body.medium.fontFamily, 'packages/shipit_ui/Inter');
      expect(AppTheme.light.font.resolvedFamily, 'packages/shipit_ui/Inter');
      expect(light.body.medium.color, AppTheme.light.color.fg.primary);
      expect(dark.body.medium.color, AppTheme.dark.color.fg.primary);
      expect(light.body.small.color, AppTheme.light.color.fg.secondary);
      expect(light.label.small.color, AppTheme.light.color.fg.muted);
      expect(light.mono.fontFamily, 'Menlo');
      expect(light.headline.medium.fontSize, 20);
      expect(light.headline.medium.fontWeight, FontWeight.w600);
    });

    test('copyWith replaces a single node and re-derives text', () {
      final rounded = AppTheme.light.copyWith(
        radius: AppTheme.light.radius.copyWith(md: 12),
      );
      expect(rounded.radius.md, 12);
      expect(rounded.radius.sm, 4);
      expect(rounded.color, same(AppTheme.light.color));
      expect(rounded.text, same(AppTheme.light.text));

      final brand = AppTheme.light.copyWith(
        color: AppTheme.light.color.copyWith(
          fg: AppTheme.light.color.fg.copyWith(
            primary: const Color(0xFF123456),
          ),
        ),
      );
      expect(brand.color.fg.primary, const Color(0xFF123456));
      expect(brand.color.bg.base, AppTheme.light.color.bg.base);
      expect(brand.text.body.medium.color, const Color(0xFF123456));

      final themed = shipitLightTheme(tokens: rounded);
      expect(themed.extension<AppTheme>(), same(rounded));
      expect(
        (themed.cardTheme.shape! as RoundedRectangleBorder).borderRadius,
        BorderRadius.circular(12),
      );
    });

    test('layout helpers classify widths', () {
      final b = AppTheme.light.breakpoint;
      expect(b.layoutTypeFor(200), AppLayoutType.compact);
      expect(b.layoutTypeFor(400), AppLayoutType.mobile);
      expect(b.layoutTypeFor(800), AppLayoutType.tablet);
      expect(b.layoutTypeFor(1100), AppLayoutType.desktop);
      expect(b.layoutTypeFor(1600), AppLayoutType.wide);
    });
  });
}
