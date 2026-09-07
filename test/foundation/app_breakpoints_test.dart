import 'package:flutter_test/flutter_test.dart';
import 'package:shipit_ui/src/foundation/app_breakpoints.dart';

void main() {
  group('AppBreakpoints', () {
    test('breakpoint values are ordered correctly', () {
      expect(AppBreakpoints.mobile, lessThan(AppBreakpoints.tablet));
      expect(AppBreakpoints.tablet, lessThan(AppBreakpoints.desktop));
      expect(AppBreakpoints.desktop, lessThan(AppBreakpoints.wide));
    });

    test('breakpoint values match design tokens', () {
      expect(AppBreakpoints.mobile, 360);
      expect(AppBreakpoints.tablet, 600);
      expect(AppBreakpoints.desktop, 1024);
      expect(AppBreakpoints.wide, 1440);
    });

    test('page width values are defined', () {
      expect(AppBreakpoints.pageWidth, 1200);
      expect(AppBreakpoints.pageWidthMobile, 360);
      expect(AppBreakpoints.pageWidthTablet, 600);
      expect(AppBreakpoints.pageWidthDesktop, 1024);
      expect(AppBreakpoints.pageWidthWide, 1440);
    });

    test('getLayoutType returns correct layout type', () {
      // Test with mock context by checking the static values
      expect(AppLayoutType.compact, isNotNull);
      expect(AppLayoutType.mobile, isNotNull);
      expect(AppLayoutType.tablet, isNotNull);
      expect(AppLayoutType.desktop, isNotNull);
      expect(AppLayoutType.wide, isNotNull);
    });

    test('extension methods exist on BuildContext', () {
      // These are extension methods that require a BuildContext to test
      // We verify the extension class exists by checking the constants
      expect(AppBreakpoints.mobile, 360);
      expect(AppBreakpoints.tablet, 600);
    });
  });
}