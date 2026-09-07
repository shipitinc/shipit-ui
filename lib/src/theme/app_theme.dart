import 'package:flutter/material.dart';
import 'package:shipit_ui/src/foundation/app_colors.dart';
import 'package:shipit_ui/src/foundation/app_spacing.dart';
import 'package:shipit_ui/src/foundation/app_radius.dart';
import 'package:shipit_ui/src/foundation/app_typography.dart';

/// Builds a light [ThemeData] for the shipit_ui design system.
///
/// Uses approved Penpot design tokens.
ThemeData shipitLightTheme() {
  return ThemeData(
    colorScheme: const ColorScheme.light(
      primary: AppColors.actionPrimaryBgColor,
      secondary: AppColors.actionSecondaryFgColor,
      error: AppColors.stateErrorFgColor,
      onSurface: AppColors.fgPrimaryColor,
    ),
    useMaterial3: true,
    textTheme: _AppTypographyThemes.lightTextTheme,
    scaffoldBackgroundColor: AppColors.bgBaseColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.bgSurfaceColor,
      foregroundColor: AppColors.fgPrimaryColor,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: AppTypography.headlineMedium,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: AppColors.borderDefaultColor),
        borderRadius: BorderRadius.circular(AppRadius.radiusMd),
      ),
      color: AppColors.bgSurfaceColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.actionPrimaryBgColor,
        foregroundColor: AppColors.actionPrimaryFgColor,
        disabledBackgroundColor: AppColors.actionDisabledBgColor,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.space4,
          vertical: AppSpacing.space2,
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
        foregroundColor: AppColors.actionPrimaryBgColor,
        disabledForegroundColor: AppColors.fgDisabledColor,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.space4,
          vertical: AppSpacing.space2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.radiusMd),
        ),
        side: const BorderSide(color: AppColors.borderDefaultColor),
        textStyle: AppTypography.labelLarge,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.bgSubtleColor,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space4,
        vertical: AppSpacing.space2,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.radiusMd),
        borderSide: const BorderSide(color: AppColors.borderDefaultColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.radiusMd),
        borderSide: const BorderSide(color: AppColors.borderDefaultColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.radiusMd),
        borderSide: const BorderSide(color: AppColors.actionPrimaryBgColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.radiusMd),
        borderSide: const BorderSide(color: AppColors.stateErrorFgColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.radiusMd),
        borderSide: const BorderSide(color: AppColors.stateErrorFgColor, width: 2),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.radiusMd),
        borderSide: const BorderSide(color: AppColors.actionDisabledBorderColor),
      ),
      hintStyle: AppTypography.bodyMedium.copyWith(
        color: AppColors.fgSecondaryColor,
      ),
      labelStyle: AppTypography.labelMedium,
      errorStyle: AppTypography.bodySmall.copyWith(color: AppColors.stateErrorFgColor),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.bgSubtleColor,
      labelStyle: AppTypography.labelMedium,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.radiusFull),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space2,
        vertical: AppSpacing.space1,
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.fgPrimaryColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.radiusMd),
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.actionPrimaryBgColor,
      strokeWidth: 3,
    ),
  );
}

/// Builds a dark-ready [ThemeData] for the shipit_ui design system.
///
/// Uses approved Penpot design tokens with dark adaptations.
ThemeData shipitDarkTheme() {
  return ThemeData(
    colorScheme: const ColorScheme.dark(
      primary: AppColors.actionPrimaryBgColor,
      onPrimary: AppColors.actionPrimaryFgColor,
      secondary: AppColors.actionSecondaryFgColor,
      onError: AppColors.actionPrimaryFgColor,
      error: AppColors.stateErrorFgColor,
      surface: AppColors.bgSubtleColor,
      onSurface: AppColors.fgInverseColor,
    ),
    useMaterial3: true,
    brightness: Brightness.dark,
    textTheme: _AppTypographyThemes.darkTextTheme,
    scaffoldBackgroundColor: AppColors.bgBaseColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.bgSubtleColor,
      foregroundColor: AppColors.fgInverseColor,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: AppTypography.headlineMedium.copyWith(
        color: AppColors.fgInverseColor,
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: AppColors.borderStrongColor),
        borderRadius: BorderRadius.circular(AppRadius.radiusMd),
      ),
      color: AppColors.bgSubtleColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.actionPrimaryBgColor,
        foregroundColor: AppColors.actionPrimaryFgColor,
        disabledBackgroundColor: AppColors.actionDisabledBgColor,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.space4,
          vertical: AppSpacing.space2,
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
        foregroundColor: AppColors.actionPrimaryBgColor,
        disabledForegroundColor: AppColors.fgDisabledColor,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.space4,
          vertical: AppSpacing.space2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.radiusMd),
        ),
        side: const BorderSide(color: AppColors.borderStrongColor),
        textStyle: AppTypography.labelLarge,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.bgSubtleColor,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space4,
        vertical: AppSpacing.space2,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.radiusMd),
        borderSide: const BorderSide(color: AppColors.borderStrongColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.radiusMd),
        borderSide: const BorderSide(color: AppColors.borderStrongColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.radiusMd),
        borderSide: const BorderSide(color: AppColors.actionPrimaryBgColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.radiusMd),
        borderSide: const BorderSide(color: AppColors.stateErrorFgColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.radiusMd),
        borderSide: const BorderSide(color: AppColors.stateErrorFgColor, width: 2),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.radiusMd),
        borderSide: const BorderSide(color: AppColors.actionDisabledBorderColor),
      ),
      hintStyle: AppTypography.bodyMedium.copyWith(
        color: AppColors.fgMutedColor,
      ),
      labelStyle: AppTypography.labelMedium.copyWith(
        color: AppColors.fgInverseColor,
      ),
      errorStyle: AppTypography.bodySmall.copyWith(color: AppColors.stateErrorFgColor),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.bgSubtleColor,
      labelStyle: AppTypography.labelMedium.copyWith(
        color: AppColors.fgInverseColor,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.radiusFull),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space2,
        vertical: AppSpacing.space1,
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.fgPrimaryColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.radiusMd),
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.actionPrimaryBgColor,
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
        color: AppColors.fgInverseColor,
      ),
      displayMedium: AppTypography.displayMedium.copyWith(
        color: AppColors.fgInverseColor,
      ),
      displaySmall: AppTypography.displaySmall.copyWith(
        color: AppColors.fgInverseColor,
      ),
      headlineLarge: AppTypography.headlineLarge.copyWith(
        color: AppColors.fgInverseColor,
      ),
      headlineMedium: AppTypography.headlineMedium.copyWith(
        color: AppColors.fgInverseColor,
      ),
      headlineSmall: AppTypography.headlineSmall.copyWith(
        color: AppColors.fgInverseColor,
      ),
      titleLarge: AppTypography.titleLarge.copyWith(
        color: AppColors.fgInverseColor,
      ),
      titleMedium: AppTypography.titleMedium.copyWith(
        color: AppColors.fgInverseColor,
      ),
      titleSmall: AppTypography.titleSmall.copyWith(
        color: AppColors.fgInverseColor,
      ),
      bodyLarge: AppTypography.bodyLarge.copyWith(
        color: AppColors.fgInverseColor,
      ),
      bodyMedium: AppTypography.bodyMedium.copyWith(
        color: AppColors.fgInverseColor,
      ),
      bodySmall: AppTypography.bodySmall.copyWith(
        color: AppColors.fgMutedColor,
      ),
      labelLarge: AppTypography.labelLarge.copyWith(
        color: AppColors.fgInverseColor,
      ),
      labelMedium: AppTypography.labelMedium.copyWith(
        color: AppColors.fgInverseColor,
      ),
      labelSmall: AppTypography.labelSmall.copyWith(
        color: AppColors.fgMutedColor,
      ),
    );
  }
}