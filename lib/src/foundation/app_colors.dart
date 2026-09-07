// Provisional semantic color tokens.
// Values are placeholders until Penpot design tokens are adopted.
// See docs/penpot-mapping.md for the mapping convention.

import 'package:flutter/painting.dart';

/// Semantic color tokens for the shipit_ui design system.
///
/// All values are provisional and must be replaced with approved
/// Penpot tokens before shipping to production.
class AppColors {
  AppColors._();

  // MARK: - Brand (Provisional)

  /// Primary brand color. Replace with Penpot token token/color/brand/primary.
  static const Color brandPrimary = Color(0xFF1565C0);

  /// Secondary brand color. Replace with Penpot token token/color/brand/secondary.
  static const Color brandSecondary = Color(0xFF5C6BC0);

  // MARK: - Action

  /// Primary action color (e.g., CTA buttons).
  static const Color actionPrimary = Color(0xFF1565C0);

  /// Secondary action color.
  static const Color actionSecondary = Color(0xFF757575);

  /// Destructive action color (e.g., delete, danger).
  static const Color actionDestructive = Color(0xFFB71C1C);

  // MARK: - Neutral

  static const Color neutral50 = Color(0xFFFAFAFA);
  static const Color neutral100 = Color(0xFFF5F5F5);
  static const Color neutral200 = Color(0xFFEEEEEE);
  static const Color neutral300 = Color(0xFFE0E0E0);
  static const Color neutral400 = Color(0xFFBDBDBD);
  static const Color neutral500 = Color(0xFF9E9E9E);
  static const Color neutral600 = Color(0xFF757575);
  static const Color neutral700 = Color(0xFF616161);
  static const Color neutral800 = Color(0xFF424242);
  static const Color neutral900 = Color(0xFF212121);
  static const Color neutral950 = Color(0xFF121212);

  // MARK: - Semantic

  /// Background color for the app surface.
  static const Color background = Color(0xFFFFFFFF);

  /// Background color for elevated surfaces (cards, sheets).
  static const Color surface = Color(0xFFFFFFFF);

  /// Background for dark surfaces.
  static const Color surfaceDark = Color(0xFF121212);

  /// Divider line color.
  static const Color divider = Color(0xFFE0E0E0);

  // MARK: - State

  /// Success state color.
  static const Color stateSuccess = Color(0xFF2E7D32);

  /// Error state color.
  static const Color stateError = Color(0xFFB71C1C);

  /// Warning state color.
  static const Color stateWarning = Color(0xFFF57F17);

  /// Info state color.
  static const Color stateInfo = Color(0xFF1565C0);

  // MARK: - Text

  /// Primary text color (high contrast).
  static const Color textPrimary = Color(0xFF212121);

  /// Secondary text color (medium contrast).
  static const Color textSecondary = Color(0xFF757575);

  /// Disabled text color.
  static const Color textDisabled = Color(0xFFBDBDBD);

  /// Text on primary/brand backgrounds.
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // MARK: - Dark mode provisional values

  /// Provisional dark mode background.
  static const Color darkBackground = Color(0xFF121212);

  /// Provisional dark mode surface.
  static const Color darkSurface = Color(0xFF1E1E1E);

  /// Provisional dark mode text primary.
  static const Color darkTextPrimary = Color(0xFFE0E0E0);

  /// Provisional dark mode text secondary.
  static const Color darkTextSecondary = Color(0xFFA0A0A0);

  /// Provisional dark mode divider.
  static const Color darkDivider = Color(0xFF333333);
}
