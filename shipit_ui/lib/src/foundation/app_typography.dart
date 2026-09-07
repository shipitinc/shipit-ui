// Provisional typography tokens.
// Values are placeholders until Penpot design tokens are adopted.

import 'package:flutter/painting.dart';
import 'app_colors.dart';

/// Semantic typography tokens for the shipit_ui design system.
///
/// All values are provisional and must be replaced with approved
/// Penpot tokens before shipping to production.
class AppTypography {
  AppTypography._();

  // MARK: - Font Family

  /// Default font family for the application.
  static const String fontFamily = 'Inter';

  // MARK: - Display

  /// Extra large display text (48sp).
  static const TextStyle displayLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 48,
    fontWeight: FontWeight.w300,
    height: 1.15,
    letterSpacing: -0.25,
    color: AppColors.textPrimary,
  );

  /// Large display text (36sp).
  static const TextStyle displayMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 36,
    fontWeight: FontWeight.w400,
    height: 1.2,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  /// Small display text (28sp).
  static const TextStyle displaySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w500,
    height: 1.25,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  // MARK: - Headline

  static const TextStyle headlineLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w500,
    height: 1.3,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w500,
    height: 1.35,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.4,
    letterSpacing: 0.1,
    color: AppColors.textPrimary,
  );

  // MARK: - Title

  static const TextStyle titleLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.4,
    letterSpacing: 0.15,
    color: AppColors.textPrimary,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.43,
    letterSpacing: 0.1,
    color: AppColors.textPrimary,
  );

  static const TextStyle titleSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w600,
    height: 1.46,
    letterSpacing: 0.1,
    color: AppColors.textPrimary,
  );

  // MARK: - Body

  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0.5,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.43,
    letterSpacing: 0.25,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.33,
    letterSpacing: 0.4,
    color: AppColors.textSecondary,
  );

  // MARK: - Label

  static const TextStyle labelLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.43,
    letterSpacing: 0.1,
    color: AppColors.textPrimary,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.33,
    letterSpacing: 0.4,
    color: AppColors.textPrimary,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    height: 1.36,
    letterSpacing: 0.5,
    color: AppColors.textSecondary,
  );

  // MARK: - Monospace

  static const TextStyle monoMedium = TextStyle(
    fontFamily: 'Menlo',
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 1.4,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );
}
