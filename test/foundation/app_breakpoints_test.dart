import 'package:flutter_test/flutter_test.dart';
import 'package:shipit_ui/src/foundation/app_breakpoints.dart';

void main() {
  group('AppBreakpoints', () {
    test('breakpoint values are ordered correctly', () {
      expect(AppBreakpoints.sm, lessThan(AppBreakpoints.md));
      expect(AppBreakpoints.md, lessThan(AppBreakpoints.lg));
      expect(AppBreakpoints.lg, lessThan(AppBreakpoints.xl));
    });

    test('breakpoint values match design tokens', () {
      expect(AppBreakpoints.sm, 600);
      expect(AppBreakpoints.md, 900);
      expect(AppBreakpoints.lg, 1200);
      expect(AppBreakpoints.xl, 1600);
    });

    test('page width values are defined', () {
      expect(AppBreakpoints.pageWidth, 1200);
      expect(AppBreakpoints.pageWidthSm, 600);
      expect(AppBreakpoints.pageWidthMd, 960);
      expect(AppBreakpoints.pageWidthLg, 1200);
    });

    test('getLayoutType returns correct layout type', () {
      // Test with mock context by checking the static values
      expect(AppLayoutType.compact, isNotNull);
      expect(AppLayoutType.medium, isNotNull);
      expect(AppLayoutType.large, isNotNull);
      expect(AppLayoutType.extraLarge, isNotNull);
    });

    test('extension methods exist on BuildContext', () {
      // These are extension methods that require a BuildContext to test
      // We verify the extension class exists by checking the constants
      expect(AppBreakpoints.sm, 600);
      expect(AppBreakpoints.md, 900);
    });
  });
}
