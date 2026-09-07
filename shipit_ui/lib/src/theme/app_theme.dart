import 'package:flutter/material.dart';
import 'package:shipit_ui/src/foundation/app_colors.dart';
import 'package:shipit_ui/src/foundation/app_spacing.dart';
import 'package:shipit_ui/src/foundation/app_radius.dart';
import 'package:shipit_ui/src/foundation/app_typography.dart';

/// Builds a light [ThemeData] for the shipit_ui design system.
///
/// Uses provisional color tokens. Replace with approved Penpot tokens
/// before shipping to production.
ThemeData shipitLightTheme() {
  return ThemeData(
    colorScheme: const ColorScheme.light(
      primary: AppColors.actionPrimary,
      secondary: AppColors.brandSecondary,
      error: AppColors.stateError,
      onSurface: AppColors.textPrimary,
    ),
    useMaterial3: true,
    textTheme: _AppTypographyThemes.lightTextTheme,
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.surface,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: AppTypography.headlineMedium,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: AppColors.divider),
        borderRadius: BorderRadius.circular(AppRadius.radiusMd),
      ),
      color: AppColors.surface,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.actionPrimary,
        foregroundColor: AppColors.textOnPrimary,
        disabledBackgroundColor: AppColors.neutral300,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.spacingMd,
          vertical: AppSpacing.spacingSm,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.radiusMd),
        ),
        textStyle: AppTypography.labelLarge,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.actionPrimary,
        disabledForegroundColor: AppColors.textDisabled,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.spacingMd,
          vertical: AppSpacing.spacingSm,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.radiusMd),
        ),
        side: const BorderSide(color: AppColors.neutral300),
        textStyle: AppTypography.labelLarge,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.neutral50,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.spacingMd,
        vertical: AppSpacing.spacingSm,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.radiusMd),
        borderSide: const BorderSide(color: AppColors.divider),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.radiusMd),
        borderSide: const BorderSide(color: AppColors.divider),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.radiusMd),
        borderSide: const BorderSide(color: AppColors.actionPrimary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.radiusMd),
        borderSide: const BorderSide(color: AppColors.stateError),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.radiusMd),
        borderSide: const BorderSide(color: AppColors.stateError, width: 2),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.radiusMd),
        borderSide: const BorderSide(color: AppColors.neutral200),
      ),
      hintStyle: AppTypography.bodyMedium.copyWith(
        color: AppColors.textSecondary,
      ),
      labelStyle: AppTypography.labelMedium,
      errorStyle: AppTypography.bodySmall.copyWith(color: AppColors.stateError),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.neutral100,
      labelStyle: AppTypography.labelMedium,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.radiusXxl),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.spacingSm,
        vertical: AppSpacing.spacingXs,
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.neutral900,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.radiusMd),
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.actionPrimary,
      strokeWidth: 3,
    ),
  );
}

/// Builds a dark-ready [ThemeData] for the shipit_ui design system.
///
/// Uses provisional dark color tokens. A full dark visual system
/// should be designed and approved before finalizing these values.
ThemeData shipitDarkTheme() {
  return ThemeData(
    colorScheme: const ColorScheme.dark(
      primary: AppColors.actionPrimary,
      onPrimary: AppColors.textOnPrimary,
      secondary: AppColors.brandSecondary,
      onError: AppColors.textOnPrimary,
      error: AppColors.stateError,
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkTextPrimary,
    ),
    useMaterial3: true,
    brightness: Brightness.dark,
    textTheme: _AppTypographyThemes.darkTextTheme,
    scaffoldBackgroundColor: AppColors.darkBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkSurface,
      foregroundColor: AppColors.darkTextPrimary,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: AppTypography.headlineMedium.copyWith(
        color: AppColors.darkTextPrimary,
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: AppColors.darkDivider),
        borderRadius: BorderRadius.circular(AppRadius.radiusMd),
      ),
      color: AppColors.darkSurface,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.actionPrimary,
        foregroundColor: AppColors.textOnPrimary,
        disabledBackgroundColor: AppColors.neutral800,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.spacingMd,
          vertical: AppSpacing.spacingSm,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.radiusMd),
        ),
        textStyle: AppTypography.labelLarge,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.actionPrimary,
        disabledForegroundColor: AppColors.neutral600,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.spacingMd,
          vertical: AppSpacing.spacingSm,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.radiusMd),
        ),
        side: const BorderSide(color: AppColors.neutral700),
        textStyle: AppTypography.labelLarge,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.neutral950,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.spacingMd,
        vertical: AppSpacing.spacingSm,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.radiusMd),
        borderSide: const BorderSide(color: AppColors.darkDivider),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.radiusMd),
        borderSide: const BorderSide(color: AppColors.darkDivider),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.radiusMd),
        borderSide: const BorderSide(color: AppColors.actionPrimary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.radiusMd),
        borderSide: const BorderSide(color: AppColors.stateError),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.radiusMd),
        borderSide: const BorderSide(color: AppColors.stateError, width: 2),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.radiusMd),
        borderSide: const BorderSide(color: AppColors.neutral800),
      ),
      hintStyle: AppTypography.bodyMedium.copyWith(
        color: AppColors.darkTextSecondary,
      ),
      labelStyle: AppTypography.labelMedium.copyWith(
        color: AppColors.darkTextPrimary,
      ),
      errorStyle: AppTypography.bodySmall.copyWith(color: AppColors.stateError),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.neutral800,
      labelStyle: AppTypography.labelMedium.copyWith(
        color: AppColors.darkTextPrimary,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.radiusXxl),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.spacingSm,
        vertical: AppSpacing.spacingXs,
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.neutral900,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.radiusMd),
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.actionPrimary,
      strokeWidth: 3,
    ),
  );
}

// MARK: - TextTheme helpers

class _AppTypographyThemes {
  static TextTheme get lightTextTheme {
    return const TextTheme(
      displayLarge: AppTypography.displayLarge,
      displayMedium: AppTypography.displayMedium,
      displaySmall: AppTypography.displaySmall,
      headlineLarge: AppTypography.headlineLarge,
      headlineMedium: AppTypography.headlineMedium,
      headlineSmall: AppTypography.headlineSmall,
      titleLarge: AppTypography.titleLarge,
      titleMedium: AppTypography.titleMedium,
      titleSmall: AppTypography.titleSmall,
      bodyLarge: AppTypography.bodyLarge,
      bodyMedium: AppTypography.bodyMedium,
      bodySmall: AppTypography.bodySmall,
      labelLarge: AppTypography.labelLarge,
      labelMedium: AppTypography.labelMedium,
      labelSmall: AppTypography.labelSmall,
    );
  }

  static TextTheme get darkTextTheme {
    return TextTheme(
      displayLarge: AppTypography.displayLarge.copyWith(
        color: AppColors.darkTextPrimary,
      ),
      displayMedium: AppTypography.displayMedium.copyWith(
        color: AppColors.darkTextPrimary,
      ),
      displaySmall: AppTypography.displaySmall.copyWith(
        color: AppColors.darkTextPrimary,
      ),
      headlineLarge: AppTypography.headlineLarge.copyWith(
        color: AppColors.darkTextPrimary,
      ),
      headlineMedium: AppTypography.headlineMedium.copyWith(
        color: AppColors.darkTextPrimary,
      ),
      headlineSmall: AppTypography.headlineSmall.copyWith(
        color: AppColors.darkTextPrimary,
      ),
      titleLarge: AppTypography.titleLarge.copyWith(
        color: AppColors.darkTextPrimary,
      ),
      titleMedium: AppTypography.titleMedium.copyWith(
        color: AppColors.darkTextPrimary,
      ),
      titleSmall: AppTypography.titleSmall.copyWith(
        color: AppColors.darkTextPrimary,
      ),
      bodyLarge: AppTypography.bodyLarge.copyWith(
        color: AppColors.darkTextPrimary,
      ),
      bodyMedium: AppTypography.bodyMedium.copyWith(
        color: AppColors.darkTextPrimary,
      ),
      bodySmall: AppTypography.bodySmall.copyWith(
        color: AppColors.darkTextSecondary,
      ),
      labelLarge: AppTypography.labelLarge.copyWith(
        color: AppColors.darkTextPrimary,
      ),
      labelMedium: AppTypography.labelMedium.copyWith(
        color: AppColors.darkTextPrimary,
      ),
      labelSmall: AppTypography.labelSmall.copyWith(
        color: AppColors.darkTextSecondary,
      ),
    );
  }
}
