import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shipit_ui/src/theme/app_theme.dart';
import 'package:shipit_ui/src/theme/app_theme_tokens.dart';

void main() {
  final light = AppTheme.light, dark = AppTheme.dark;

  group('color tokens', () {
    test('light values match Penpot shipit/color', () {
      final c = light.color;
      expect(c.bg.base, const Color(0xFFF8FAFC));
      expect(c.bg.surface, const Color(0xFFFFFFFF));
      expect(c.fg.primary, const Color(0xFF0F172A));
      expect(c.fg.secondary, const Color(0xFF475569));
      expect(c.border.base, const Color(0xFFCBD5E1));
      expect(c.action.primary.bg, const Color(0xFF2563EB));
      expect(c.action.primary.bgHover, const Color(0xFF1D4ED8));
      expect(c.state.error.fg, const Color(0xFFDC2626));
      expect(c.state.error.bg, const Color(0xFFFEF2F2));
      expect(c.scrim, const Color(0xFF020617));
      expect(c.shimmer.base, const Color(0xFFE2E8F0));
      expect(c.tooltip.bg, const Color(0xFF0F172A));
      expect(c.avatar.bg, const Color(0xFFE2E8F0));
      expect(c.chip.selected.fg, const Color(0xFF2563EB));
      expect(c.table.border, const Color(0xFFE2E8F0));
    });

    test('dark values match Penpot shipit/color-dark', () {
      final c = dark.color;
      expect(c.brightness, Brightness.dark);
      expect(c.bg.base, const Color(0xFF020617));
      expect(c.bg.surface, const Color(0xFF0F172A));
      expect(c.fg.primary, const Color(0xFFF8FAFC));
      expect(c.border.base, const Color(0xFF334155));
      expect(c.state.error.fg, const Color(0xFFF87171));
      expect(c.state.error.bg, const Color(0xFF450A0A));
      expect(c.tooltip.bg, const Color(0xFFF1F5F9));
      expect(c.nav.selected.fg, const Color(0xFF60A5FA));
    });

    test('every light token has a dark counterpart with adequate contrast', () {
      double lum(Color c) => c.computeLuminance();
      expect(lum(dark.color.bg.base), lessThan(lum(light.color.bg.base)));
      expect(
        lum(dark.color.fg.primary),
        greaterThan(lum(light.color.fg.primary)),
      );
      for (final pair in [
        dark.color.state.error,
        dark.color.state.success,
        dark.color.state.warning,
        dark.color.state.info,
      ]) {
        expect(lum(pair.fg), greaterThan(lum(pair.bg)));
      }
    });
  });

  group('non-color tokens', () {
    test('spacing scale is 4px based and ordered', () {
      final s = light.space;
      final values = [
        s.s0,
        s.s1,
        s.s2,
        s.s3,
        s.s4,
        s.s5,
        s.s6,
        s.s8,
        s.s10,
        s.s12,
        s.s16,
      ];
      expect(values, [0, 4, 8, 12, 16, 20, 24, 32, 40, 48, 64]);
      for (final v in values) {
        expect(v % 4, 0);
      }
    });

    test('radius scale and BorderRadius view agree', () {
      final r = light.radius;
      expect([r.none, r.sm, r.md, r.lg, r.xl, r.full], [0, 4, 8, 12, 16, 999]);
      expect(r.all.md, BorderRadius.circular(8));
      expect(r.all.full, BorderRadius.circular(999));
    });

    test('motion durations are ordered', () {
      final d = light.motion.duration;
      expect(d.instant, Duration.zero);
      expect(d.fast < d.normal, isTrue);
      expect(d.normal < d.slow, isTrue);
      expect(d.slow < d.slower, isTrue);
      expect(d.shimmer.inMilliseconds, 1200);
      expect(light.motion.curve.standard, Curves.easeInOut);
    });

    test('elevation shadows grow with level', () {
      final e = light.elevation;
      expect(e.e0, isEmpty);
      expect(e.e1.single.blurRadius, lessThan(e.e2.single.blurRadius));
      expect(e.e2.single.blurRadius, lessThan(e.e3.single.blurRadius));
    });

    test('breakpoints are ordered and classify widths', () {
      final b = light.breakpoint;
      expect(
        b.mobile < b.tablet && b.tablet < b.desktop && b.desktop < b.wide,
        isTrue,
      );
      expect(
        [b.mobile, b.tablet, b.desktop, b.wide, b.pageWidth],
        [360, 600, 1024, 1440, 1200],
      );
      expect(b.layoutTypeFor(1023), AppLayoutType.tablet);
      expect(b.layoutTypeFor(1024), AppLayoutType.desktop);
    });

    test('font sizes follow the type ramp', () {
      final t = light.text;
      expect(t.display.large.fontSize, 36);
      expect(t.display.medium.fontSize, 30);
      expect(t.display.small.fontSize, 24);
      expect(t.headline.large.fontSize, 24);
      expect(t.headline.medium.fontSize, 20);
      expect(t.headline.small.fontSize, 18);
      expect(t.title.large.fontSize, 18);
      expect(t.title.medium.fontSize, 16);
      expect(t.title.small.fontSize, 14);
      expect(t.body.large.fontSize, 18);
      expect(t.body.medium.fontSize, 16);
      expect(t.body.small.fontSize, 14);
      expect(t.label.large.fontSize, 14);
      expect(t.label.medium.fontSize, 12);
      expect(t.label.small.fontSize, 12);
      expect(light.opacity.scrim, 0.4);
    });

    test('font weight tokens cover the emphasis scale', () {
      final w = light.font.weight;
      expect(w.regular, FontWeight.w400);
      expect(w.medium, FontWeight.w500);
      expect(w.semibold, FontWeight.w600);
      expect(w.bold, FontWeight.w700);
    });

    test('icon sizes are a 4px based scale starting at 16', () {
      final i = light.icon.size;
      expect([i.sm, i.md, i.lg, i.xl], [16, 20, 24, 28]);
      for (final size in [i.sm, i.md, i.lg, i.xl]) {
        expect(size % 4, 0);
      }
    });

    test('layout max-width tokens constrain centered forms', () {
      final l = light.layout;
      expect(l.maxWidth.form, 440);
    });
  });

  group('fonts', () {
    testWidgets('bundles Inter TTFs and resolves them via context.text', (
      tester,
    ) async {
      const assets = [
        'assets/fonts/Inter-Regular.ttf',
        'assets/fonts/Inter-Medium.ttf',
        'assets/fonts/Inter-SemiBold.ttf',
        'assets/fonts/Inter-Bold.ttf',
      ];
      final loader = FontLoader(light.font.resolvedFamily);
      for (final asset in assets) {
        final data = await rootBundle.load('packages/shipit_ui/$asset');
        expect(data.lengthInBytes, greaterThan(100000), reason: asset);
        loader.addFont(rootBundle.load('packages/shipit_ui/$asset'));
      }
      await loader.load();
      await tester.pumpWidget(
        MaterialApp(
          theme: shipitLightTheme(),
          home: Scaffold(
            body: Builder(
              builder: (context) =>
                  Text('Inter', style: context.text.body.medium),
            ),
          ),
        ),
      );
      final width = tester.getSize(find.text('Inter')).width;
      expect(width, isNot(closeTo(5 * 16, 0.5)), reason: 'fell back to Ahem');
      expect(light.font.resolvedFamily, 'packages/shipit_ui/Inter');
      final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
      for (final asset in assets) {
        expect(
          manifest.listAssets(),
          anyOf(contains(asset), contains('packages/shipit_ui/$asset')),
        );
      }
    });
  });
}
