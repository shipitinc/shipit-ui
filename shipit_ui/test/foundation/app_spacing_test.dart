import 'package:flutter_test/flutter_test.dart';
import 'package:shipit_ui/src/foundation/app_spacing.dart';

void main() {
  group('AppSpacing', () {
    test('all spacing tokens are ordered correctly', () {
      expect(AppSpacing.spacing2xs, lessThan(AppSpacing.spacingXs));
      expect(AppSpacing.spacingXs, lessThan(AppSpacing.spacingSm));
      expect(AppSpacing.spacingSm, lessThan(AppSpacing.spacingMd));
      expect(AppSpacing.spacingMd, lessThan(AppSpacing.spacingLg));
      expect(AppSpacing.spacingLg, lessThan(AppSpacing.spacingXl));
      expect(AppSpacing.spacingXl, lessThan(AppSpacing.spacingXxl));
    });

    test('spacing values match design tokens', () {
      expect(AppSpacing.spacing2xs, 2.0);
      expect(AppSpacing.spacingXs, 4.0);
      expect(AppSpacing.spacingSm, 8.0);
      expect(AppSpacing.spacingMd, 16.0);
      expect(AppSpacing.spacingLg, 24.0);
      expect(AppSpacing.spacingXl, 32.0);
    });

    test('padding getters return correct values', () {
      expect(AppSpacing.paddingXs, isNotNull);
      expect(AppSpacing.paddingMd, isNotNull);
      expect(AppSpacing.paddingLg, isNotNull);
    });

    test('padding horizontal getters', () {
      expect(AppSpacing.paddingHorizontalMd, isNotNull);
      expect(AppSpacing.paddingHorizontalLg, isNotNull);
    });
  });
}
