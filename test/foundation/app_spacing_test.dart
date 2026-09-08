import 'package:flutter_test/flutter_test.dart';
import 'package:shipit_ui/src/foundation/app_spacing.dart';

void main() {
  group('AppSpacing', () {
    test('all spacing tokens are ordered correctly', () {
      expect(AppSpacing.space1, lessThan(AppSpacing.space2));
      expect(AppSpacing.space2, lessThan(AppSpacing.space3));
      expect(AppSpacing.space3, lessThan(AppSpacing.space4));
      expect(AppSpacing.space4, lessThan(AppSpacing.space5));
      expect(AppSpacing.space5, lessThan(AppSpacing.space6));
      expect(AppSpacing.space6, lessThan(AppSpacing.space8));
      expect(AppSpacing.space8, lessThan(AppSpacing.space10));
      expect(AppSpacing.space10, lessThan(AppSpacing.space12));
      expect(AppSpacing.space12, lessThan(AppSpacing.space16));
    });

    test('spacing values match design tokens', () {
      expect(AppSpacing.space0, 0);
      expect(AppSpacing.space1, 4.0);
      expect(AppSpacing.space2, 8.0);
      expect(AppSpacing.space3, 12.0);
      expect(AppSpacing.space4, 16.0);
      expect(AppSpacing.space5, 20.0);
      expect(AppSpacing.space6, 24.0);
      expect(AppSpacing.space8, 32.0);
      expect(AppSpacing.space10, 40.0);
      expect(AppSpacing.space12, 48.0);
      expect(AppSpacing.space16, 64.0);
    });

    test('padding getters return correct values', () {
      expect(AppSpacing.padding1, isNotNull);
      expect(AppSpacing.padding4, isNotNull);
      expect(AppSpacing.padding6, isNotNull);
    });

    test('padding horizontal getters', () {
      expect(AppSpacing.paddingHorizontal4, isNotNull);
      expect(AppSpacing.paddingHorizontal6, isNotNull);
      expect(AppSpacing.paddingHorizontal8, isNotNull);
    });
  });
}
