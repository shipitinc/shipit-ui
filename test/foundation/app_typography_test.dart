import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shipit_ui/src/foundation/app_typography.dart';

void main() {
  group('AppTypography', () {
    test('all text styles are defined', () {
      expect(AppTypography.displayLarge, isNotNull);
      expect(AppTypography.headlineLarge, isNotNull);
      expect(AppTypography.titleLarge, isNotNull);
      expect(AppTypography.bodyLarge, isNotNull);
      expect(AppTypography.labelLarge, isNotNull);
      expect(AppTypography.monoMedium, isNotNull);
    });

    test('font family is set and resolved through the package', () {
      expect(AppTypography.fontFamily, 'Inter');
      expect(AppTypography.resolvedFontFamily, 'packages/shipit_ui/Inter');
      for (final style in [
        AppTypography.displayLarge,
        AppTypography.headlineMedium,
        AppTypography.bodyMedium,
        AppTypography.labelSmall,
      ]) {
        expect(style.fontFamily, AppTypography.resolvedFontFamily);
      }
      expect(AppTypography.monoMedium.fontFamily, 'Menlo');
    });

    testWidgets('bundles Inter TTFs for every weight used', (tester) async {
      const assets = {
        400: 'assets/fonts/Inter-Regular.ttf',
        500: 'assets/fonts/Inter-Medium.ttf',
        600: 'assets/fonts/Inter-SemiBold.ttf',
        700: 'assets/fonts/Inter-Bold.ttf',
      };
      for (final asset in assets.values) {
        final data = await rootBundle.load('packages/shipit_ui/$asset');
        expect(data.lengthInBytes, greaterThan(100000), reason: asset);
      }
      final loader = FontLoader(AppTypography.resolvedFontFamily);
      for (final asset in assets.values) {
        loader.addFont(rootBundle.load('packages/shipit_ui/$asset'));
      }
      await loader.load();
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: Text('Inter', style: AppTypography.bodyMedium)),
        ),
      );
      final width = tester.getSize(find.text('Inter')).width;
      expect(width, isNot(closeTo(5 * 16, 0.5)), reason: 'fell back to Ahem');

      final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
      final keys = manifest.listAssets();
      for (final asset in assets.values) {
        expect(
          keys,
          anyOf(contains(asset), contains('packages/shipit_ui/$asset')),
        );
      }
    });

    test('all styles have color defined', () {
      expect(AppTypography.bodyLarge.color, isNotNull);
      expect(AppTypography.titleMedium.color, isNotNull);
      expect(AppTypography.labelSmall.color, isNotNull);
    });

    test('font sizes follow design token hierarchy', () {
      expect(AppTypography.displayLarge.fontSize, 36);
      expect(AppTypography.displayMedium.fontSize, 30);
      expect(AppTypography.displaySmall.fontSize, 24);
      expect(AppTypography.headlineLarge.fontSize, 24);
      expect(AppTypography.headlineMedium.fontSize, 20);
      expect(AppTypography.headlineSmall.fontSize, 18);
      expect(AppTypography.titleLarge.fontSize, 18);
      expect(AppTypography.titleMedium.fontSize, 16);
      expect(AppTypography.titleSmall.fontSize, 14);
      expect(AppTypography.bodyLarge.fontSize, 18);
      expect(AppTypography.bodyMedium.fontSize, 16);
      expect(AppTypography.bodySmall.fontSize, 14);
      expect(AppTypography.labelLarge.fontSize, 14);
      expect(AppTypography.labelMedium.fontSize, 12);
      expect(AppTypography.labelSmall.fontSize, 12);
    });
  });
}
