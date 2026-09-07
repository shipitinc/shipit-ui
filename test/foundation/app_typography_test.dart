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
