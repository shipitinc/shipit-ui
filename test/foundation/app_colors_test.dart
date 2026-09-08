import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:shipit_ui/src/foundation/app_colors.dart';

void main() {
  group('AppColors', () {
    test('all semantic color tokens are non-null', () {
      expect(AppColors.actionPrimaryBgColor, isNotNull);
      expect(AppColors.actionSecondaryFgColor, isNotNull);
      expect(AppColors.actionDestructive, isNotNull);
      expect(AppColors.stateSuccessFgColor, isNotNull);
      expect(AppColors.stateErrorFgColor, isNotNull);
      expect(AppColors.stateWarningFgColor, isNotNull);
      expect(AppColors.stateInfoFgColor, isNotNull);
    });

    test('neutral palette values are correct', () {
      expect(AppColors.neutral50Color, const Color(0xFFF8FAFC));
      expect(AppColors.neutral100Color, const Color(0xFFF1F5F9));
      expect(AppColors.neutral950Color, const Color(0xFF020617));
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
