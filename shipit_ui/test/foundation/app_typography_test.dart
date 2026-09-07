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

    test('font family is set', () {
      expect(AppTypography.fontFamily, 'Inter');
    });

    test('all styles have color defined', () {
      expect(AppTypography.bodyLarge.color, isNotNull);
      expect(AppTypography.titleMedium.color, isNotNull);
      expect(AppTypography.labelSmall.color, isNotNull);
    });

    test('font sizes decrease through hierarchy levels', () {
      expect(
        AppTypography.displayLarge.fontSize,
        greaterThan(AppTypography.headlineLarge.fontSize!),
      );
      expect(
        AppTypography.headlineLarge.fontSize,
        greaterThan(AppTypography.headlineSmall.fontSize!),
      );
      expect(
        AppTypography.headlineSmall.fontSize,
        greaterThan(AppTypography.titleLarge.fontSize!),
      );
      expect(
        AppTypography.titleLarge.fontSize,
        greaterThan(AppTypography.titleSmall.fontSize!),
      );
      expect(
        AppTypography.bodyLarge.fontSize,
        greaterThan(AppTypography.bodySmall.fontSize!),
      );
      expect(
        AppTypography.labelLarge.fontSize,
        greaterThan(AppTypography.labelSmall.fontSize!),
      );
    });
  });
}
