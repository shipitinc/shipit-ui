/// Semantic color tokens for the shipit_ui design system.
///
/// Values are derived from approved Penpot design tokens.
/// See docs/penpot-mapping.md for the mapping convention.
library;

import 'dart:ui';

class AppColors {
  AppColors._();

  // MARK: - Primitive Neutral Scale (from Penpot primitives)

  static const int _neutral0 = 0xFFFFFFFF;
  static const int _neutral50 = 0xFFF8FAFC;
  static const int _neutral100 = 0xFFF1F5F9;
  static const int _neutral200 = 0xFFE2E8F0;
  static const int _neutral300 = 0xFFCBD5E1;
  static const int _neutral400 = 0xFF94A3B8;
  static const int _neutral500 = 0xFF64748B;
  static const int _neutral600 = 0xFF475569;
  static const int _neutral700 = 0xFF334155;
  static const int _neutral800 = 0xFF1E293B;
  static const int _neutral900 = 0xFF0F172A;
  static const int _neutral950 = 0xFF020617;

  // MARK: - Primitive Accent Scale

  static const int _accent50 = 0xFFEFF6FF;
  static const int _accent400 = 0xFF60A5FA;
  static const int _accent500 = 0xFF3B82F6;
  static const int _accent600 = 0xFF2563EB;
  static const int _accent700 = 0xFF1D4ED8;
  static const int _accent950 = 0xFF172554;

  // MARK: - Primitive Red Scale

  static const int _red50 = 0xFFFEF2F2;
  static const int _red400 = 0xFFF87171;
  static const int _red600 = 0xFFDC2626;
  static const int _red950 = 0xFF450A0A;

  // MARK: - Primitive Green Scale

  static const int _green50 = 0xFFF0FDF4;
  static const int _green400 = 0xFF4ADE80;
  static const int _green600 = 0xFF16A34A;
  static const int _green950 = 0xFF052E16;

  // MARK: - Primitive Amber Scale

  static const int _amber50 = 0xFFFFFBEB;
  static const int _amber400 = 0xFFFBBF24;
  static const int _amber600 = 0xFFD97706;
  static const int _amber950 = 0xFF451A03;

  // MARK: - Background

  /// token/color/bg/base → #F8FAFC (neutral.50)
  static const int bgBase = _neutral50;

  /// token/color/bg/surface → #FFFFFF (neutral.0)
  static const int bgSurface = _neutral0;

  /// token/color/bg/subtle → #F1F5F9 (neutral.100)
  static const int bgSubtle = _neutral100;

  /// token/color/bg/disabled → #F1F5F9 (neutral.100)
  static const int bgDisabled = _neutral100;

  // MARK: - Foreground

  /// token/color/fg/primary → #0F172A (neutral.900)
  static const int fgPrimary = _neutral900;

  /// token/color/fg/secondary → #475569 (neutral.600)
  static const int fgSecondary = _neutral600;

  /// token/color/fg/muted → #94A3B8 (neutral.400)
  static const int fgMuted = _neutral400;

  /// token/color/fg/inverse → #FFFFFF (neutral.0)
  static const int fgInverse = _neutral0;

  /// token/color/fg/disabled → #94A3B8 (neutral.400)
  static const int fgDisabled = _neutral400;

  // MARK: - Border

  /// token/color/border/default → #CBD5E1 (neutral.300)
  static const int borderDefault = _neutral300;

  /// token/color/border/strong → #94A3B8 (neutral.400)
  static const int borderStrong = _neutral400;

  /// token/color/border/focus → #2563EB (accent.600)
  static const int borderFocus = _accent600;

  /// token/color/border/error → #DC2626 (red.600)
  static const int borderError = _red600;

  // MARK: - Action Primary

  /// token/color/action/primary/bg → #2563EB (accent.600)
  static const int actionPrimaryBg = _accent600;

  /// token/color/action/primary/bgHover → #1D4ED8 (accent.700)
  static const int actionPrimaryBgHover = _accent700;

  /// token/color/action/primary/fg → #FFFFFF (neutral.0)
  static const int actionPrimaryFg = _neutral0;

  // MARK: - Action Secondary

  /// token/color/action/secondary/bg → #FFFFFF (neutral.0)
  static const int actionSecondaryBg = _neutral0;

  /// token/color/action/secondary/border → #CBD5E1 (neutral.300)
  static const int actionSecondaryBorder = _neutral300;

  /// token/color/action/secondary/fg → #0F172A (neutral.900)
  static const int actionSecondaryFg = _neutral900;

  // MARK: - Action Disabled

  /// token/color/action/disabled/bg → #F1F5F9 (neutral.100)
  static const int actionDisabledBg = _neutral100;

  /// token/color/action/disabled/border → #E2E8F0 (neutral.200)
  static const int actionDisabledBorder = _neutral200;

  /// token/color/action/disabled/fg → #94A3B8 (neutral.400)
  static const int actionDisabledFg = _neutral400;

  // MARK: - State Colors

  /// token/color/state/error/fg → #DC2626 (red.600)
  static const int stateErrorFg = _red600;

  /// token/color/state/error/bg → #FEF2F2 (red.50)
  static const int stateErrorBg = _red50;

  /// token/color/state/success/fg → #16A34A (green.600)
  static const int stateSuccessFg = _green600;

  /// token/color/state/success/bg → #F0FDF4 (green.50)
  static const int stateSuccessBg = _green50;

  /// token/color/state/warning/fg → #D97706 (amber.600)
  static const int stateWarningFg = _amber600;

  /// token/color/state/warning/bg → #FFFBEB (amber.50)
  static const int stateWarningBg = _amber50;

  /// token/color/state/info/fg → #2563EB (accent.600)
  static const int stateInfoFg = _accent600;

  /// token/color/state/info/bg → #EFF6FF (accent.50)
  static const int stateInfoBg = _accent50;

  // MARK: - Overlay

  /// token/color/scrim → #020617 (neutral.950)
  static const int scrim = _neutral950;

  // MARK: - Shimmer

  /// token/color/shimmer/base → #E2E8F0 (neutral.200)
  static const int shimmerBase = _neutral200;

  /// token/color/shimmer/highlight → #F8FAFC (neutral.50)
  static const int shimmerHighlight = _neutral50;

  // MARK: - Navigation

  /// token/color/nav/selected/bg → #EFF6FF (accent.50)
  static const int navSelectedBg = _accent50;

  /// token/color/nav/selected/fg → #2563EB (accent.600)
  static const int navSelectedFg = _accent600;

  /// token/color/nav/unselected/fg → #475569 (neutral.600)
  static const int navUnselectedFg = _neutral600;

  // MARK: - Tooltip

  /// token/color/tooltip/bg → #0F172A (neutral.900)
  static const int tooltipBg = _neutral900;

  /// token/color/tooltip/fg → #FFFFFF (neutral.0)
  static const int tooltipFg = _neutral0;

  // MARK: - Avatar

  /// token/color/avatar/bg → #E2E8F0 (neutral.200)
  static const int avatarBg = _neutral200;

  /// token/color/avatar/fg → #334155 (neutral.700)
  static const int avatarFg = _neutral700;

  // MARK: - Chip

  /// token/color/chip/bg → #FFFFFF (neutral.0)
  static const int chipBg = _neutral0;

  /// token/color/chip/fg → #475569 (neutral.600)
  static const int chipFg = _neutral600;

  /// token/color/chip/border → #CBD5E1 (neutral.300)
  static const int chipBorder = _neutral300;

  /// token/color/chip/selected/bg → #EFF6FF (accent.50)
  static const int chipSelectedBg = _accent50;

  /// token/color/chip/selected/fg → #2563EB (accent.600)
  static const int chipSelectedFg = _accent600;

  /// token/color/chip/selected/border → #2563EB (accent.600)
  static const int chipSelectedBorder = _accent600;

  // MARK: - Table

  /// token/color/table/header/bg → #F1F5F9 (neutral.100)
  static const int tableHeaderBg = _neutral100;

  /// token/color/table/row/hover → #F8FAFC (neutral.50)
  static const int tableRowHover = _neutral50;

  /// token/color/table/border → #E2E8F0 (neutral.200)
  static const int tableBorder = _neutral200;

  // MARK: - Convenience Color Getters (Semantic Names)

  static const Color bgBaseColor = Color(bgBase);
  static const Color bgSurfaceColor = Color(bgSurface);
  static const Color bgSubtleColor = Color(bgSubtle);
  static const Color bgDisabledColor = Color(bgDisabled);

  static const Color fgPrimaryColor = Color(fgPrimary);
  static const Color fgSecondaryColor = Color(fgSecondary);
  static const Color fgMutedColor = Color(fgMuted);
  static const Color fgInverseColor = Color(fgInverse);
  static const Color fgDisabledColor = Color(fgDisabled);

  static const Color borderDefaultColor = Color(borderDefault);
  static const Color borderStrongColor = Color(borderStrong);
  static const Color borderFocusColor = Color(borderFocus);
  static const Color borderErrorColor = Color(borderError);

  static const Color actionPrimaryBgColor = Color(actionPrimaryBg);
  static const Color actionPrimaryBgHoverColor = Color(actionPrimaryBgHover);
  static const Color actionPrimaryFgColor = Color(actionPrimaryFg);

  static const Color actionSecondaryBgColor = Color(actionSecondaryBg);
  static const Color actionSecondaryBorderColor = Color(actionSecondaryBorder);
  static const Color actionSecondaryFgColor = Color(actionSecondaryFg);

  static const Color actionDisabledBgColor = Color(actionDisabledBg);
  static const Color actionDisabledBorderColor = Color(actionDisabledBorder);
  static const Color actionDisabledFgColor = Color(actionDisabledFg);

  static const Color stateErrorFgColor = Color(stateErrorFg);
  static const Color stateErrorBgColor = Color(stateErrorBg);
  static const Color stateSuccessFgColor = Color(stateSuccessFg);
  static const Color stateSuccessBgColor = Color(stateSuccessBg);
  static const Color stateWarningFgColor = Color(stateWarningFg);
  static const Color stateWarningBgColor = Color(stateWarningBg);
  static const Color stateInfoFgColor = Color(stateInfoFg);
  static const Color stateInfoBgColor = Color(stateInfoBg);

  static const Color scrimColor = Color(scrim);
  static const Color shimmerBaseColor = Color(shimmerBase);
  static const Color shimmerHighlightColor = Color(shimmerHighlight);

  static const Color navSelectedBgColor = Color(navSelectedBg);
  static const Color navSelectedFgColor = Color(navSelectedFg);
  static const Color navUnselectedFgColor = Color(navUnselectedFg);

  static const Color tooltipBgColor = Color(tooltipBg);
  static const Color tooltipFgColor = Color(tooltipFg);

  static const Color avatarBgColor = Color(avatarBg);
  static const Color avatarFgColor = Color(avatarFg);

  static const Color chipBgColor = Color(chipBg);
  static const Color chipFgColor = Color(chipFg);
  static const Color chipBorderColor = Color(chipBorder);
  static const Color chipSelectedBgColor = Color(chipSelectedBg);
  static const Color chipSelectedFgColor = Color(chipSelectedFg);
  static const Color chipSelectedBorderColor = Color(chipSelectedBorder);

  static const Color tableHeaderBgColor = Color(tableHeaderBg);
  static const Color tableRowHoverColor = Color(tableRowHover);
  static const Color tableBorderColor = Color(tableBorder);

  // MARK: - Neutral Scale Getters (for backward compatibility)

  static const Color neutral0Color = Color(_neutral0);
  static const Color neutral50Color = Color(_neutral50);
  static const Color neutral100Color = Color(_neutral100);
  static const Color neutral200Color = Color(_neutral200);
  static const Color neutral300Color = Color(_neutral300);
  static const Color neutral400Color = Color(_neutral400);
  static const Color neutral500Color = Color(_neutral500);
  static const Color neutral600Color = Color(_neutral600);
  static const Color neutral700Color = Color(_neutral700);
  static const Color neutral800Color = Color(_neutral800);
  static const Color neutral900Color = Color(_neutral900);
  static const Color neutral950Color = Color(_neutral950);

  // MARK: - Legacy Aliases (deprecated, for backward compatibility)

  /// @deprecated Use bgSurfaceColor instead
  static const Color background = bgSurfaceColor;

  /// @deprecated Use bgSurfaceColor instead
  static const Color surface = bgSurfaceColor;

  /// @deprecated Use bgSubtleColor instead
  static const Color surfaceDark = bgSubtleColor;

  /// @deprecated Use borderDefaultColor instead
  static const Color divider = borderDefaultColor;

  /// @deprecated Use stateSuccessFgColor instead
  static const Color stateSuccess = stateSuccessFgColor;

  /// @deprecated Use stateErrorFgColor instead
  static const Color stateError = stateErrorFgColor;

  /// @deprecated Use stateWarningFgColor instead
  static const Color stateWarning = stateWarningFgColor;

  /// @deprecated Use stateInfoFgColor instead
  static const Color stateInfo = stateInfoFgColor;

  /// @deprecated Use fgPrimaryColor instead
  static const Color textPrimary = fgPrimaryColor;

  /// @deprecated Use fgSecondaryColor instead
  static const Color textSecondary = fgSecondaryColor;

  /// @deprecated Use fgDisabledColor instead
  static const Color textDisabled = fgDisabledColor;

  /// @deprecated Use fgInverseColor instead
  static const Color textOnPrimary = fgInverseColor;

  /// @deprecated Use bgSurfaceColor instead
  static const Color darkBackground = bgSurfaceColor;

  /// @deprecated Use bgSubtleColor instead
  static const Color darkSurface = bgSubtleColor;

  /// @deprecated Use fgInverseColor instead
  static const Color darkTextPrimary = fgInverseColor;

  /// @deprecated Use fgMutedColor instead
  static const Color darkTextSecondary = fgMutedColor;

  /// @deprecated Use borderStrongColor instead
  static const Color darkDivider = borderStrongColor;

  /// @deprecated Use actionPrimaryBgColor instead
  static const Color brandPrimary = actionPrimaryBgColor;

  /// @deprecated Use actionSecondaryFgColor instead
  static const Color brandSecondary = actionSecondaryFgColor;

  /// @deprecated Use actionPrimaryBgColor instead
  static const Color actionPrimary = actionPrimaryBgColor;

  /// @deprecated Use actionSecondaryFgColor instead
  static const Color actionSecondary = actionSecondaryFgColor;

  /// @deprecated Use stateErrorFgColor instead
  static const Color actionDestructive = stateErrorFgColor;
}

/// Dark-mode semantic color tokens for the shipit_ui design system.
///
/// Every token in [AppColors] has a counterpart here with the same name,
/// resolved against the dark end of the same primitive scales
/// (Penpot token set `shipit/color-dark`). Consumed by `shipitDarkTheme()`
/// via [AppPalette]; components read colors through the palette so they
/// adapt automatically.
class AppColorsDark {
  AppColorsDark._();

  // MARK: - Background

  /// token/color/bg/base → #020617 (neutral.950)
  static const Color bgBaseColor = Color(AppColors._neutral950);

  /// token/color/bg/surface → #0F172A (neutral.900)
  static const Color bgSurfaceColor = Color(AppColors._neutral900);

  /// token/color/bg/subtle → #1E293B (neutral.800)
  static const Color bgSubtleColor = Color(AppColors._neutral800);

  /// token/color/bg/disabled → #1E293B (neutral.800)
  static const Color bgDisabledColor = Color(AppColors._neutral800);

  // MARK: - Foreground

  /// token/color/fg/primary → #F8FAFC (neutral.50)
  static const Color fgPrimaryColor = Color(AppColors._neutral50);

  /// token/color/fg/secondary → #CBD5E1 (neutral.300)
  static const Color fgSecondaryColor = Color(AppColors._neutral300);

  /// token/color/fg/muted → #64748B (neutral.500)
  static const Color fgMutedColor = Color(AppColors._neutral500);

  /// token/color/fg/inverse → #0F172A (neutral.900)
  static const Color fgInverseColor = Color(AppColors._neutral900);

  /// token/color/fg/disabled → #475569 (neutral.600)
  static const Color fgDisabledColor = Color(AppColors._neutral600);

  // MARK: - Border

  /// token/color/border/default → #334155 (neutral.700)
  static const Color borderDefaultColor = Color(AppColors._neutral700);

  /// token/color/border/strong → #475569 (neutral.600)
  static const Color borderStrongColor = Color(AppColors._neutral600);

  /// token/color/border/focus → #60A5FA (accent.400)
  static const Color borderFocusColor = Color(AppColors._accent400);

  /// token/color/border/error → #F87171 (red.400)
  static const Color borderErrorColor = Color(AppColors._red400);

  // MARK: - Action

  /// token/color/action/primary/bg → #2563EB (accent.600)
  static const Color actionPrimaryBgColor = Color(AppColors._accent600);

  /// token/color/action/primary/bgHover → #3B82F6 (accent.500)
  static const Color actionPrimaryBgHoverColor = Color(AppColors._accent500);

  /// token/color/action/primary/fg → #FFFFFF (neutral.0)
  static const Color actionPrimaryFgColor = Color(AppColors._neutral0);

  /// token/color/action/secondary/bg → #0F172A (neutral.900)
  static const Color actionSecondaryBgColor = Color(AppColors._neutral900);

  /// token/color/action/secondary/border → #334155 (neutral.700)
  static const Color actionSecondaryBorderColor = Color(AppColors._neutral700);

  /// token/color/action/secondary/fg → #F8FAFC (neutral.50)
  static const Color actionSecondaryFgColor = Color(AppColors._neutral50);

  /// token/color/action/disabled/bg → #1E293B (neutral.800)
  static const Color actionDisabledBgColor = Color(AppColors._neutral800);

  /// token/color/action/disabled/border → #334155 (neutral.700)
  static const Color actionDisabledBorderColor = Color(AppColors._neutral700);

  /// token/color/action/disabled/fg → #475569 (neutral.600)
  static const Color actionDisabledFgColor = Color(AppColors._neutral600);

  // MARK: - State

  /// token/color/state/error/fg → #F87171 (red.400)
  static const Color stateErrorFgColor = Color(AppColors._red400);

  /// token/color/state/error/bg → #450A0A (red.950)
  static const Color stateErrorBgColor = Color(AppColors._red950);

  /// token/color/state/success/fg → #4ADE80 (green.400)
  static const Color stateSuccessFgColor = Color(AppColors._green400);

  /// token/color/state/success/bg → #052E16 (green.950)
  static const Color stateSuccessBgColor = Color(AppColors._green950);

  /// token/color/state/warning/fg → #FBBF24 (amber.400)
  static const Color stateWarningFgColor = Color(AppColors._amber400);

  /// token/color/state/warning/bg → #451A03 (amber.950)
  static const Color stateWarningBgColor = Color(AppColors._amber950);

  /// token/color/state/info/fg → #60A5FA (accent.400)
  static const Color stateInfoFgColor = Color(AppColors._accent400);

  /// token/color/state/info/bg → #172554 (accent.950)
  static const Color stateInfoBgColor = Color(AppColors._accent950);

  // MARK: - Overlay / Shimmer

  /// token/color/scrim → #020617 (neutral.950)
  static const Color scrimColor = Color(AppColors._neutral950);

  /// token/color/shimmer/base → #1E293B (neutral.800)
  static const Color shimmerBaseColor = Color(AppColors._neutral800);

  /// token/color/shimmer/highlight → #334155 (neutral.700)
  static const Color shimmerHighlightColor = Color(AppColors._neutral700);

  // MARK: - Navigation / Tooltip / Avatar / Chip / Table

  /// token/color/nav/selected/bg → #172554 (accent.950)
  static const Color navSelectedBgColor = Color(AppColors._accent950);

  /// token/color/nav/selected/fg → #60A5FA (accent.400)
  static const Color navSelectedFgColor = Color(AppColors._accent400);

  /// token/color/nav/unselected/fg → #CBD5E1 (neutral.300)
  static const Color navUnselectedFgColor = Color(AppColors._neutral300);

  /// token/color/tooltip/bg → #F1F5F9 (neutral.100)
  static const Color tooltipBgColor = Color(AppColors._neutral100);

  /// token/color/tooltip/fg → #0F172A (neutral.900)
  static const Color tooltipFgColor = Color(AppColors._neutral900);

  /// token/color/avatar/bg → #334155 (neutral.700)
  static const Color avatarBgColor = Color(AppColors._neutral700);

  /// token/color/avatar/fg → #F1F5F9 (neutral.100)
  static const Color avatarFgColor = Color(AppColors._neutral100);

  /// token/color/chip/bg → #0F172A (neutral.900)
  static const Color chipBgColor = Color(AppColors._neutral900);

  /// token/color/chip/fg → #CBD5E1 (neutral.300)
  static const Color chipFgColor = Color(AppColors._neutral300);

  /// token/color/chip/border → #334155 (neutral.700)
  static const Color chipBorderColor = Color(AppColors._neutral700);

  /// token/color/chip/selected/bg → #172554 (accent.950)
  static const Color chipSelectedBgColor = Color(AppColors._accent950);

  /// token/color/chip/selected/fg → #60A5FA (accent.400)
  static const Color chipSelectedFgColor = Color(AppColors._accent400);

  /// token/color/chip/selected/border → #60A5FA (accent.400)
  static const Color chipSelectedBorderColor = Color(AppColors._accent400);

  /// token/color/table/header/bg → #1E293B (neutral.800)
  static const Color tableHeaderBgColor = Color(AppColors._neutral800);

  /// token/color/table/row/hover → #1E293B (neutral.800)
  static const Color tableRowHoverColor = Color(AppColors._neutral800);

  /// token/color/table/border → #334155 (neutral.700)
  static const Color tableBorderColor = Color(AppColors._neutral700);
}
