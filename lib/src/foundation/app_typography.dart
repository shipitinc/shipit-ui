/// Semantic typography tokens for the shipit_ui design system.
///
/// Values are derived from approved Penpot design tokens.
/// See docs/penpot-mapping.md for the mapping convention.
import 'package:flutter/painting.dart';
import 'app_colors.dart';

class AppTypography {
  AppTypography._();

  // MARK: - Font Family

  /// token/typography/font/family/base → Inter
  static const String fontFamily = 'Inter';

  // MARK: - Font Weights

  /// token/typography/font/weight/regular → 400
  static const FontWeight fontWeightRegular = FontWeight.w400;

  /// token/typography/font/weight/medium → 500
  static const FontWeight fontWeightMedium = FontWeight.w500;

  /// token/typography/font/weight/semibold → 600
  static const FontWeight fontWeightSemibold = FontWeight.w600;

  /// token/typography/font/weight/bold → 700
  static const FontWeight fontWeightBold = FontWeight.w700;

  // MARK: - Font Sizes

  /// token/typography/font/size/xs → 12
  static const double fontSizeXs = 12;

  /// token/typography/font/size/sm → 14
  static const double fontSizeSm = 14;

  /// token/typography/font/size/md → 16
  static const double fontSizeMd = 16;

  /// token/typography/font/size/lg → 18
  static const double fontSizeLg = 18;

  /// token/typography/font/size/xl → 20
  static const double fontSizeXl = 20;

  /// token/typography/font/size/2xl → 24
  static const double fontSize2xl = 24;

  /// token/typography/font/size/3xl → 30
  static const double fontSize3xl = 30;

  /// token/typography/font/size/4xl → 36
  static const double fontSize4xl = 36;

  // MARK: - Letter Spacing

  /// token/typography/letterSpacing/tight → -0.02em
  static const double letterSpacingTight = -0.02;

  /// token/typography/letterSpacing/normal → 0
  static const double letterSpacingNormal = 0;

  /// token/typography/letterSpacing/wide → 0.02em
  static const double letterSpacingWide = 0.02;

  // MARK: - Semantic Text Styles

  // Display styles (largest)
  static const TextStyle displayLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSize4xl,
    fontWeight: fontWeightSemibold,
    height: 1.2,
    letterSpacing: letterSpacingTight,
    color: AppColors.fgPrimaryColor,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSize3xl,
    fontWeight: fontWeightSemibold,
    height: 1.2,
    letterSpacing: letterSpacingTight,
    color: AppColors.fgPrimaryColor,
  );

  static const TextStyle displaySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSize2xl,
    fontWeight: fontWeightSemibold,
    height: 1.2,
    letterSpacing: letterSpacingNormal,
    color: AppColors.fgPrimaryColor,
  );

  // Headline styles
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSize2xl,
    fontWeight: fontWeightSemibold,
    height: 1.2,
    letterSpacing: letterSpacingNormal,
    color: AppColors.fgPrimaryColor,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSizeXl,
    fontWeight: fontWeightSemibold,
    height: 1.3,
    letterSpacing: letterSpacingNormal,
    color: AppColors.fgPrimaryColor,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSizeLg,
    fontWeight: fontWeightSemibold,
    height: 1.4,
    letterSpacing: letterSpacingNormal,
    color: AppColors.fgPrimaryColor,
  );

  // Title styles
  static const TextStyle titleLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSizeLg,
    fontWeight: fontWeightSemibold,
    height: 1.4,
    letterSpacing: letterSpacingNormal,
    color: AppColors.fgPrimaryColor,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSizeMd,
    fontWeight: fontWeightSemibold,
    height: 1.4,
    letterSpacing: letterSpacingNormal,
    color: AppColors.fgPrimaryColor,
  );

  static const TextStyle titleSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSizeSm,
    fontWeight: fontWeightSemibold,
    height: 1.4,
    letterSpacing: letterSpacingNormal,
    color: AppColors.fgPrimaryColor,
  );

  // Body styles
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSizeLg,
    fontWeight: fontWeightRegular,
    height: 1.5,
    letterSpacing: letterSpacingNormal,
    color: AppColors.fgPrimaryColor,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSizeMd,
    fontWeight: fontWeightRegular,
    height: 1.5,
    letterSpacing: letterSpacingNormal,
    color: AppColors.fgPrimaryColor,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSizeSm,
    fontWeight: fontWeightRegular,
    height: 1.43,
    letterSpacing: letterSpacingNormal,
    color: AppColors.fgSecondaryColor,
  );

  // Label styles
  static const TextStyle labelLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSizeSm,
    fontWeight: fontWeightMedium,
    height: 1.43,
    letterSpacing: letterSpacingWide,
    color: AppColors.fgPrimaryColor,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSizeXs,
    fontWeight: fontWeightMedium,
    height: 1.33,
    letterSpacing: letterSpacingWide,
    color: AppColors.fgPrimaryColor,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSizeXs,
    fontWeight: fontWeightMedium,
    height: 1.33,
    letterSpacing: letterSpacingWide,
    color: AppColors.fgMutedColor,
  );

  // MARK: - Monospace

  static const TextStyle monoMedium = TextStyle(
    fontFamily: 'Menlo',
    fontSize: fontSizeSm,
    fontWeight: fontWeightRegular,
    height: 1.4,
    letterSpacing: letterSpacingNormal,
    color: AppColors.fgPrimaryColor,
  );
}