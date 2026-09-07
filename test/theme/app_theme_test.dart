import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shipit_ui/src/theme/app_theme.dart';
import 'package:shipit_ui/src/foundation/app_colors.dart';

void main() {
  group('AppTheme', () {
    test('light theme is created', () {
      final theme = shipitLightTheme();
      expect(theme, isNotNull);
      expect(theme.useMaterial3, true);
      expect(theme.brightness, Brightness.light);
    });

    test('dark theme is created', () {
      final theme = shipitDarkTheme();
      expect(theme, isNotNull);
      expect(theme.useMaterial3, true);
      expect(theme.brightness, Brightness.dark);
    });

    test('light theme has correct color scheme', () {
      final theme = shipitLightTheme();
      expect(theme.colorScheme.primary, AppColors.actionPrimary);
      expect(theme.colorScheme.onPrimary, AppColors.textOnPrimary);
      expect(theme.colorScheme.error, AppColors.stateError);
    });

    test('dark theme has dark color scheme', () {
      final theme = shipitDarkTheme();
      expect(theme.colorScheme.brightness, Brightness.dark);
    });

    test('light theme has text theme', () {
      final theme = shipitLightTheme();
      expect(theme.textTheme.bodyLarge, isNotNull);
      expect(theme.textTheme.titleMedium, isNotNull);
    });

    test('dark theme has text theme', () {
      final theme = shipitDarkTheme();
      expect(theme.textTheme.bodyLarge, isNotNull);
      expect(theme.textTheme.titleMedium, isNotNull);
    });
  });
}
