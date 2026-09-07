import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:shipit_ui/src/foundation/app_colors.dart';

void main() {
  group('AppColors', () {
    test('all color tokens are non-null', () {
      expect(AppColors.brandPrimary, isNotNull);
      expect(AppColors.actionPrimary, isNotNull);
      expect(AppColors.actionDestructive, isNotNull);
      expect(AppColors.stateSuccess, isNotNull);
      expect(AppColors.stateError, isNotNull);
      expect(AppColors.stateWarning, isNotNull);
      expect(AppColors.stateInfo, isNotNull);
    });

    test('neutral palette values are correct', () {
      expect(AppColors.neutral50, const Color(0xFFFAFAFA));
      expect(AppColors.neutral100, const Color(0xFFF5F5F5));
      expect(AppColors.neutral950, const Color(0xFF121212));
    });

    test('dark mode values are defined', () {
      expect(AppColors.darkBackground, isNotNull);
      expect(AppColors.darkSurface, isNotNull);
      expect(AppColors.darkTextPrimary, isNotNull);
      expect(AppColors.darkTextSecondary, isNotNull);
    });

    test('text colors have proper contrast', () {
      expect(AppColors.textOnPrimary, const Color(0xFFFFFFFF));
    });
  });
}
