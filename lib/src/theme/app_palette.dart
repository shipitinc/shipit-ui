import 'package:flutter/material.dart';
import 'package:shipit_ui/src/foundation/app_colors.dart';

/// Brightness-aware semantic colors for the shipit_ui design system.
///
/// [AppPalette.light] mirrors [AppColors]; [AppPalette.dark] mirrors
/// [AppColorsDark]. Both themes register the palette as a [ThemeExtension],
/// so widgets can read `AppPalette.of(context)` and adapt to dark mode
/// without branching on brightness themselves.
class AppPalette extends ThemeExtension<AppPalette> {
  final Brightness brightness;
  final Color bgBase;
  final Color bgSurface;
  final Color bgSubtle;
  final Color bgDisabled;
  final Color fgPrimary;
  final Color fgSecondary;
  final Color fgMuted;
  final Color fgInverse;
  final Color fgDisabled;
  final Color borderDefault;
  final Color borderStrong;
  final Color borderFocus;
  final Color borderError;
  final Color actionPrimaryBg;
  final Color actionPrimaryBgHover;
  final Color actionPrimaryFg;
  final Color actionSecondaryBg;
  final Color actionSecondaryBorder;
  final Color actionSecondaryFg;
  final Color actionDisabledBg;
  final Color actionDisabledBorder;
  final Color actionDisabledFg;
  final Color stateErrorFg;
  final Color stateErrorBg;
  final Color stateSuccessFg;
  final Color stateSuccessBg;
  final Color stateWarningFg;
  final Color stateWarningBg;
  final Color stateInfoFg;
  final Color stateInfoBg;
  final Color scrim;
  final Color shimmerBase;
  final Color shimmerHighlight;
  final Color navSelectedBg;
  final Color navSelectedFg;
  final Color navUnselectedFg;
  final Color tooltipBg;
  final Color tooltipFg;
  final Color avatarBg;
  final Color avatarFg;
  final Color chipBg;
  final Color chipFg;
  final Color chipBorder;
  final Color chipSelectedBg;
  final Color chipSelectedFg;
  final Color chipSelectedBorder;
  final Color tableHeaderBg;
  final Color tableRowHover;
  final Color tableBorder;

  const AppPalette({
    required this.brightness,
    required this.bgBase,
    required this.bgSurface,
    required this.bgSubtle,
    required this.bgDisabled,
    required this.fgPrimary,
    required this.fgSecondary,
    required this.fgMuted,
    required this.fgInverse,
    required this.fgDisabled,
    required this.borderDefault,
    required this.borderStrong,
    required this.borderFocus,
    required this.borderError,
    required this.actionPrimaryBg,
    required this.actionPrimaryBgHover,
    required this.actionPrimaryFg,
    required this.actionSecondaryBg,
    required this.actionSecondaryBorder,
    required this.actionSecondaryFg,
    required this.actionDisabledBg,
    required this.actionDisabledBorder,
    required this.actionDisabledFg,
    required this.stateErrorFg,
    required this.stateErrorBg,
    required this.stateSuccessFg,
    required this.stateSuccessBg,
    required this.stateWarningFg,
    required this.stateWarningBg,
    required this.stateInfoFg,
    required this.stateInfoBg,
    required this.scrim,
    required this.shimmerBase,
    required this.shimmerHighlight,
    required this.navSelectedBg,
    required this.navSelectedFg,
    required this.navUnselectedFg,
    required this.tooltipBg,
    required this.tooltipFg,
    required this.avatarBg,
    required this.avatarFg,
    required this.chipBg,
    required this.chipFg,
    required this.chipBorder,
    required this.chipSelectedBg,
    required this.chipSelectedFg,
    required this.chipSelectedBorder,
    required this.tableHeaderBg,
    required this.tableRowHover,
    required this.tableBorder,
  });

  static const AppPalette light = AppPalette(
    brightness: Brightness.light,
    bgBase: AppColors.bgBaseColor,
    bgSurface: AppColors.bgSurfaceColor,
    bgSubtle: AppColors.bgSubtleColor,
    bgDisabled: AppColors.bgDisabledColor,
    fgPrimary: AppColors.fgPrimaryColor,
    fgSecondary: AppColors.fgSecondaryColor,
    fgMuted: AppColors.fgMutedColor,
    fgInverse: AppColors.fgInverseColor,
    fgDisabled: AppColors.fgDisabledColor,
    borderDefault: AppColors.borderDefaultColor,
    borderStrong: AppColors.borderStrongColor,
    borderFocus: AppColors.borderFocusColor,
    borderError: AppColors.borderErrorColor,
    actionPrimaryBg: AppColors.actionPrimaryBgColor,
    actionPrimaryBgHover: AppColors.actionPrimaryBgHoverColor,
    actionPrimaryFg: AppColors.actionPrimaryFgColor,
    actionSecondaryBg: AppColors.actionSecondaryBgColor,
    actionSecondaryBorder: AppColors.actionSecondaryBorderColor,
    actionSecondaryFg: AppColors.actionSecondaryFgColor,
    actionDisabledBg: AppColors.actionDisabledBgColor,
    actionDisabledBorder: AppColors.actionDisabledBorderColor,
    actionDisabledFg: AppColors.actionDisabledFgColor,
    stateErrorFg: AppColors.stateErrorFgColor,
    stateErrorBg: AppColors.stateErrorBgColor,
    stateSuccessFg: AppColors.stateSuccessFgColor,
    stateSuccessBg: AppColors.stateSuccessBgColor,
    stateWarningFg: AppColors.stateWarningFgColor,
    stateWarningBg: AppColors.stateWarningBgColor,
    stateInfoFg: AppColors.stateInfoFgColor,
    stateInfoBg: AppColors.stateInfoBgColor,
    scrim: AppColors.scrimColor,
    shimmerBase: AppColors.shimmerBaseColor,
    shimmerHighlight: AppColors.shimmerHighlightColor,
    navSelectedBg: AppColors.navSelectedBgColor,
    navSelectedFg: AppColors.navSelectedFgColor,
    navUnselectedFg: AppColors.navUnselectedFgColor,
    tooltipBg: AppColors.tooltipBgColor,
    tooltipFg: AppColors.tooltipFgColor,
    avatarBg: AppColors.avatarBgColor,
    avatarFg: AppColors.avatarFgColor,
    chipBg: AppColors.chipBgColor,
    chipFg: AppColors.chipFgColor,
    chipBorder: AppColors.chipBorderColor,
    chipSelectedBg: AppColors.chipSelectedBgColor,
    chipSelectedFg: AppColors.chipSelectedFgColor,
    chipSelectedBorder: AppColors.chipSelectedBorderColor,
    tableHeaderBg: AppColors.tableHeaderBgColor,
    tableRowHover: AppColors.tableRowHoverColor,
    tableBorder: AppColors.tableBorderColor,
  );

  static const AppPalette dark = AppPalette(
    brightness: Brightness.dark,
    bgBase: AppColorsDark.bgBaseColor,
    bgSurface: AppColorsDark.bgSurfaceColor,
    bgSubtle: AppColorsDark.bgSubtleColor,
    bgDisabled: AppColorsDark.bgDisabledColor,
    fgPrimary: AppColorsDark.fgPrimaryColor,
    fgSecondary: AppColorsDark.fgSecondaryColor,
    fgMuted: AppColorsDark.fgMutedColor,
    fgInverse: AppColorsDark.fgInverseColor,
    fgDisabled: AppColorsDark.fgDisabledColor,
    borderDefault: AppColorsDark.borderDefaultColor,
    borderStrong: AppColorsDark.borderStrongColor,
    borderFocus: AppColorsDark.borderFocusColor,
    borderError: AppColorsDark.borderErrorColor,
    actionPrimaryBg: AppColorsDark.actionPrimaryBgColor,
    actionPrimaryBgHover: AppColorsDark.actionPrimaryBgHoverColor,
    actionPrimaryFg: AppColorsDark.actionPrimaryFgColor,
    actionSecondaryBg: AppColorsDark.actionSecondaryBgColor,
    actionSecondaryBorder: AppColorsDark.actionSecondaryBorderColor,
    actionSecondaryFg: AppColorsDark.actionSecondaryFgColor,
    actionDisabledBg: AppColorsDark.actionDisabledBgColor,
    actionDisabledBorder: AppColorsDark.actionDisabledBorderColor,
    actionDisabledFg: AppColorsDark.actionDisabledFgColor,
    stateErrorFg: AppColorsDark.stateErrorFgColor,
    stateErrorBg: AppColorsDark.stateErrorBgColor,
    stateSuccessFg: AppColorsDark.stateSuccessFgColor,
    stateSuccessBg: AppColorsDark.stateSuccessBgColor,
    stateWarningFg: AppColorsDark.stateWarningFgColor,
    stateWarningBg: AppColorsDark.stateWarningBgColor,
    stateInfoFg: AppColorsDark.stateInfoFgColor,
    stateInfoBg: AppColorsDark.stateInfoBgColor,
    scrim: AppColorsDark.scrimColor,
    shimmerBase: AppColorsDark.shimmerBaseColor,
    shimmerHighlight: AppColorsDark.shimmerHighlightColor,
    navSelectedBg: AppColorsDark.navSelectedBgColor,
    navSelectedFg: AppColorsDark.navSelectedFgColor,
    navUnselectedFg: AppColorsDark.navUnselectedFgColor,
    tooltipBg: AppColorsDark.tooltipBgColor,
    tooltipFg: AppColorsDark.tooltipFgColor,
    avatarBg: AppColorsDark.avatarBgColor,
    avatarFg: AppColorsDark.avatarFgColor,
    chipBg: AppColorsDark.chipBgColor,
    chipFg: AppColorsDark.chipFgColor,
    chipBorder: AppColorsDark.chipBorderColor,
    chipSelectedBg: AppColorsDark.chipSelectedBgColor,
    chipSelectedFg: AppColorsDark.chipSelectedFgColor,
    chipSelectedBorder: AppColorsDark.chipSelectedBorderColor,
    tableHeaderBg: AppColorsDark.tableHeaderBgColor,
    tableRowHover: AppColorsDark.tableRowHoverColor,
    tableBorder: AppColorsDark.tableBorderColor,
  );

  /// The palette registered on the ambient [Theme]; falls back to
  /// [AppPalette.light] / [AppPalette.dark] based on theme brightness when
  /// the app does not use `shipitLightTheme()` / `shipitDarkTheme()`.
  static AppPalette of(BuildContext context) {
    final theme = Theme.of(context);
    return theme.extension<AppPalette>() ??
        (theme.brightness == Brightness.dark ? dark : light);
  }

  @override
  AppPalette copyWith({Brightness? brightness}) => this;

  @override
  AppPalette lerp(ThemeExtension<AppPalette>? other, double t) =>
      t < 0.5 ? this : (other is AppPalette ? other : this);
}
