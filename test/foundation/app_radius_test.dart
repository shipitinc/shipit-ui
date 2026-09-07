import 'package:flutter_test/flutter_test.dart';
import 'package:shipit_ui/src/foundation/app_radius.dart';

void main() {
  group('AppRadius', () {
    test('all radius tokens are ordered correctly', () {
      expect(AppRadius.radiusNone, lessThan(AppRadius.radiusSm));
      expect(AppRadius.radiusSm, lessThan(AppRadius.radiusMd));
      expect(AppRadius.radiusMd, lessThan(AppRadius.radiusLg));
      expect(AppRadius.radiusLg, lessThan(AppRadius.radiusXl));
    });

    test('radius values match design tokens', () {
      expect(AppRadius.radiusNone, 0.0);
      expect(AppRadius.radiusSm, 4.0);
      expect(AppRadius.radiusMd, 8.0);
      expect(AppRadius.radiusLg, 12.0);
      expect(AppRadius.radiusXl, 16.0);
    });

    test('border radius instances are created', () {
      expect(AppRadius.borderRadiusSm, isNotNull);
      expect(AppRadius.borderRadiusMd, isNotNull);
      expect(AppRadius.borderRadiusFull, isNotNull);
    });

    test('radiusFull is a large value', () {
      expect(AppRadius.radiusFull, 999);
    });
  });
}
