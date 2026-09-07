import 'package:flutter_test/flutter_test.dart';
import 'package:shipit_ui/src/foundation/app_motion.dart';

void main() {
  group('AppMotion', () {
    test('durations are ordered correctly', () {
      expect(AppMotion.instant, lessThan(AppMotion.fast));
      expect(AppMotion.fast, lessThan(AppMotion.normal));
      expect(AppMotion.normal, lessThan(AppMotion.slow));
      expect(AppMotion.slow, lessThan(AppMotion.slower));
    });

    test('duration values match design tokens', () {
      expect(AppMotion.instant, Duration.zero);
      expect(AppMotion.fast, const Duration(milliseconds: 150));
      expect(AppMotion.normal, const Duration(milliseconds: 250));
      expect(AppMotion.slow, const Duration(milliseconds: 400));
      expect(AppMotion.slower, const Duration(milliseconds: 600));
    });

    test('curves are defined', () {
      expect(AppMotion.curveStandard, isNotNull);
      expect(AppMotion.curveDecelerate, isNotNull);
      expect(AppMotion.curveAccelerate, isNotNull);
      expect(AppMotion.curveSharp, isNotNull);
    });

    test('animation pairs are defined', () {
      expect(AppMotion.buttonAnimation, isNotNull);
      expect(AppMotion.dialogAnimation, isNotNull);
      expect(AppMotion.pageAnimation, isNotNull);
    });

    test('button animation duration is 100ms', () {
      expect(AppMotion.buttonPress, const Duration(milliseconds: 100));
    });

    test('page transition duration is 300ms', () {
      expect(AppMotion.pageTransition, const Duration(milliseconds: 300));
    });
  });
}
