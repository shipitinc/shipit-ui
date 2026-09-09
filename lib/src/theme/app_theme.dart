import 'package:flutter/material.dart';
import 'package:shipit_ui/src/foundation/app_radius.dart';
import 'package:shipit_ui/src/foundation/app_spacing.dart';
import 'package:shipit_ui/src/foundation/app_typography.dart';
import 'package:shipit_ui/src/theme/app_palette.dart';

/// Builds a light [ThemeData] for the shipit_ui design system.
///
/// Uses approved Penpot design tokens (`shipit/color`).
ThemeData shipitLightTheme() => _buildTheme(AppPalette.light);

/// Builds a dark [ThemeData] for the shipit_ui design system.
///
/// Uses approved Penpot design tokens (`shipit/color-dark`): dark surfaces
/// from the neutral 950/900/800 primitives, light foregrounds, and
/// dark-adapted state, border and action tokens.
ThemeData shipitDarkTheme() => _buildTheme(AppPalette.dark);

ThemeData _buildTheme(AppPalette p) {
  final bool isDark = p.brightness == Brightness.dark;
  final TextTheme textTheme = _textTheme(p);
  final RoundedRectangleBorder buttonShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(AppRadius.radiusMd),
  );
  OutlineInputBorder border(Color color, {double width = 1}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.radiusMd),
        borderSide: BorderSide(color: color, width: width),
      );

  return ThemeData(
    useMaterial3: true,
    brightness: p.brightness,
    extensions: <ThemeExtension<dynamic>>[p],
    colorScheme: ColorScheme(
      brightness: p.brightness,
      primary: p.actionPrimaryBg,
      onPrimary: p.actionPrimaryFg,
      primaryContainer: p.stateInfoBg,
      onPrimaryContainer: p.stateInfoFg,
      secondary: p.actionSecondaryFg,
      onSecondary: p.actionSecondaryBg,
      secondaryContainer: p.bgSubtle,
      onSecondaryContainer: p.fgPrimary,
      tertiary: p.stateSuccessFg,
      onTertiary: p.actionPrimaryFg,
      tertiaryContainer: p.stateSuccessBg,
      onTertiaryContainer: p.stateSuccessFg,
      error: p.stateErrorFg,
      onError: isDark ? p.fgInverse : p.actionPrimaryFg,
      errorContainer: p.stateErrorBg,
      onErrorContainer: p.stateErrorFg,
      surface: p.bgSurface,
      onSurface: p.fgPrimary,
      surfaceDim: p.bgBase,
      surfaceBright: p.bgSurface,
      surfaceContainerLowest: isDark ? p.bgBase : p.bgSurface,
      surfaceContainerLow: isDark ? p.bgSurface : p.bgBase,
      surfaceContainer: p.bgSubtle,
      surfaceContainerHigh: p.bgSubtle,
      surfaceContainerHighest: isDark ? p.borderDefault : p.bgSubtle,
      onSurfaceVariant: p.fgSecondary,
      outline: p.borderDefault,
      outlineVariant: isDark ? p.bgSubtle : p.borderDefault,
      shadow: p.scrim,
      scrim: p.scrim,
      inverseSurface: p.fgPrimary,
      onInverseSurface: p.bgSurface,
      inversePrimary: p.navSelectedFg,
    ),
    textTheme: textTheme,
    scaffoldBackgroundColor: p.bgBase,
    canvasColor: p.bgSurface,
    cardColor: p.bgSurface,
    dialogTheme: DialogThemeData(
      backgroundColor: p.bgSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.radiusXl),
      ),
    ),
    dividerColor: p.borderDefault,
    dividerTheme: DividerThemeData(color: p.borderDefault, thickness: 1),
    iconTheme: IconThemeData(color: p.fgSecondary),
    appBarTheme: AppBarTheme(
      backgroundColor: p.bgSurface,
      foregroundColor: p.fgPrimary,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: AppTypography.headlineMedium.copyWith(color: p.fgPrimary),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: p.borderDefault),
        borderRadius: BorderRadius.circular(AppRadius.radiusMd),
      ),
      color: p.bgSurface,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: p.actionPrimaryBg,
        foregroundColor: p.actionPrimaryFg,
        disabledBackgroundColor: p.actionDisabledBg,
        disabledForegroundColor: p.actionDisabledFg,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.space4,
          vertical: AppSpacing.space2,
        ),
        shape: buttonShape,
        textStyle: AppTypography.labelLarge,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: p.actionSecondaryFg,
        backgroundColor: p.actionSecondaryBg,
        disabledForegroundColor: p.actionDisabledFg,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.space4,
          vertical: AppSpacing.space2,
        ),
        shape: buttonShape,
        side: BorderSide(color: p.actionSecondaryBorder),
        textStyle: AppTypography.labelLarge,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: p.actionPrimaryBg,
        textStyle: AppTypography.labelLarge,
        shape: buttonShape,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: p.bgSurface,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space4,
        vertical: AppSpacing.space2,
      ),
      border: border(p.borderDefault),
      enabledBorder: border(p.borderDefault),
      focusedBorder: border(p.borderFocus, width: 2),
      errorBorder: border(p.borderError),
      focusedErrorBorder: border(p.borderError, width: 2),
      disabledBorder: border(p.actionDisabledBorder),
      hintStyle: AppTypography.bodyMedium.copyWith(color: p.fgMuted),
      labelStyle: AppTypography.labelMedium.copyWith(color: p.fgSecondary),
      errorStyle: AppTypography.bodySmall.copyWith(color: p.stateErrorFg),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: p.chipBg,
      selectedColor: p.chipSelectedBg,
      side: BorderSide(color: p.chipBorder),
      labelStyle: AppTypography.labelMedium.copyWith(color: p.chipFg),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.radiusFull),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space2,
        vertical: AppSpacing.space1,
      ),
    ),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: p.tooltipBg,
        borderRadius: AppRadius.borderRadiusMd,
      ),
      textStyle: AppTypography.labelMedium.copyWith(color: p.tooltipFg),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: p.tooltipBg,
      contentTextStyle: AppTypography.bodyMedium.copyWith(color: p.tooltipFg),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.radiusMd),
      ),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: p.actionPrimaryBg,
      strokeWidth: 3,
    ),
    listTileTheme: ListTileThemeData(
      tileColor: p.bgSurface,
      textColor: p.fgPrimary,
      iconColor: p.fgSecondary,
    ),
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: p.bgSurface,
      indicatorColor: p.navSelectedBg,
      selectedIconTheme: IconThemeData(color: p.navSelectedFg),
      unselectedIconTheme: IconThemeData(color: p.navUnselectedFg),
      selectedLabelTextStyle: AppTypography.labelLarge.copyWith(
        color: p.navSelectedFg,
      ),
      unselectedLabelTextStyle: AppTypography.labelLarge.copyWith(
        color: p.navUnselectedFg,
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: p.bgSurface,
      headerForegroundColor: p.fgPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.radiusXl),
      ),
    ),
  );
}

TextTheme _textTheme(AppPalette p) {
  TextStyle c(TextStyle s, Color color) => s.copyWith(color: color);
  return TextTheme(
    displayLarge: c(AppTypography.displayLarge, p.fgPrimary),
    displayMedium: c(AppTypography.displayMedium, p.fgPrimary),
    displaySmall: c(AppTypography.displaySmall, p.fgPrimary),
    headlineLarge: c(AppTypography.headlineLarge, p.fgPrimary),
    headlineMedium: c(AppTypography.headlineMedium, p.fgPrimary),
    headlineSmall: c(AppTypography.headlineSmall, p.fgPrimary),
    titleLarge: c(AppTypography.titleLarge, p.fgPrimary),
    titleMedium: c(AppTypography.titleMedium, p.fgPrimary),
    titleSmall: c(AppTypography.titleSmall, p.fgPrimary),
    bodyLarge: c(AppTypography.bodyLarge, p.fgPrimary),
    bodyMedium: c(AppTypography.bodyMedium, p.fgPrimary),
    bodySmall: c(AppTypography.bodySmall, p.fgSecondary),
    labelLarge: c(AppTypography.labelLarge, p.fgPrimary),
    labelMedium: c(AppTypography.labelMedium, p.fgPrimary),
    labelSmall: c(AppTypography.labelSmall, p.fgMuted),
  );
}
