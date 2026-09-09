import 'package:flutter/painting.dart';
import 'package:shipit_ui/src/theme/tokens/app_color_tokens.dart';

/// `font.size.*`
class AppFontSizeTokens {
  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double xxl;
  final double xxxl;
  final double xxxxl;

  const AppFontSizeTokens({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.xxl,
    required this.xxxl,
    required this.xxxxl,
  });

  AppFontSizeTokens copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
    double? xxxl,
    double? xxxxl,
  }) => AppFontSizeTokens(
    xs: xs ?? this.xs,
    sm: sm ?? this.sm,
    md: md ?? this.md,
    lg: lg ?? this.lg,
    xl: xl ?? this.xl,
    xxl: xxl ?? this.xxl,
    xxxl: xxxl ?? this.xxxl,
    xxxxl: xxxxl ?? this.xxxxl,
  );
}

/// `font.weight.*`
class AppFontWeightTokens {
  final FontWeight regular;
  final FontWeight medium;
  final FontWeight semibold;
  final FontWeight bold;

  const AppFontWeightTokens({
    required this.regular,
    required this.medium,
    required this.semibold,
    required this.bold,
  });

  AppFontWeightTokens copyWith({
    FontWeight? regular,
    FontWeight? medium,
    FontWeight? semibold,
    FontWeight? bold,
  }) => AppFontWeightTokens(
    regular: regular ?? this.regular,
    medium: medium ?? this.medium,
    semibold: semibold ?? this.semibold,
    bold: bold ?? this.bold,
  );
}

/// `letterSpacing.*`
class AppLetterSpacingTokens {
  final double tight;
  final double normal;
  final double wide;

  const AppLetterSpacingTokens({
    required this.tight,
    required this.normal,
    required this.wide,
  });

  AppLetterSpacingTokens copyWith({
    double? tight,
    double? normal,
    double? wide,
  }) => AppLetterSpacingTokens(
    tight: tight ?? this.tight,
    normal: normal ?? this.normal,
    wide: wide ?? this.wide,
  );
}

/// Font tokens (`font.*`): family, bundled package, sizes, weights and
/// letter spacing. Text *styles* are composed in [AppTextTokens].
class AppFontTokens {
  /// Family name as declared in `pubspec.yaml` (bundled Inter).
  final String family;

  /// Package that bundles [family]; `null` when the consumer supplies it.
  final String? package;
  final String monoFamily;
  final AppFontSizeTokens size;
  final AppFontWeightTokens weight;
  final AppLetterSpacingTokens letterSpacing;

  const AppFontTokens({
    required this.family,
    required this.package,
    required this.monoFamily,
    required this.size,
    required this.weight,
    required this.letterSpacing,
  });

  /// Family name as the engine resolves it (`packages/<package>/<family>`).
  String get resolvedFamily =>
      package == null ? family : 'packages/$package/$family';

  static const AppFontTokens base = AppFontTokens(
    family: 'Inter',
    package: 'shipit_ui',
    monoFamily: 'Menlo',
    size: AppFontSizeTokens(
      xs: 12,
      sm: 14,
      md: 16,
      lg: 18,
      xl: 20,
      xxl: 24,
      xxxl: 30,
      xxxxl: 36,
    ),
    weight: AppFontWeightTokens(
      regular: FontWeight.w400,
      medium: FontWeight.w500,
      semibold: FontWeight.w600,
      bold: FontWeight.w700,
    ),
    letterSpacing: AppLetterSpacingTokens(tight: -0.02, normal: 0, wide: 0.02),
  );

  AppFontTokens copyWith({
    String? family,
    String? package,
    String? monoFamily,
    AppFontSizeTokens? size,
    AppFontWeightTokens? weight,
    AppLetterSpacingTokens? letterSpacing,
  }) => AppFontTokens(
    family: family ?? this.family,
    package: package ?? this.package,
    monoFamily: monoFamily ?? this.monoFamily,
    size: size ?? this.size,
    weight: weight ?? this.weight,
    letterSpacing: letterSpacing ?? this.letterSpacing,
  );
}

/// A large / medium / small trio of [TextStyle]s.
class AppTextScale {
  final TextStyle large;
  final TextStyle medium;
  final TextStyle small;

  const AppTextScale({
    required this.large,
    required this.medium,
    required this.small,
  });

  AppTextScale copyWith({
    TextStyle? large,
    TextStyle? medium,
    TextStyle? small,
  }) => AppTextScale(
    large: large ?? this.large,
    medium: medium ?? this.medium,
    small: small ?? this.small,
  );
}

/// Semantic text styles: `context.text.body.medium`, `context.text.label.small`.
///
/// Styles carry the brightness-appropriate foreground colour, so they are
/// built per theme via [AppTextTokens.from].
class AppTextTokens {
  final AppTextScale display;
  final AppTextScale headline;
  final AppTextScale title;
  final AppTextScale body;
  final AppTextScale label;
  final TextStyle mono;

  const AppTextTokens({
    required this.display,
    required this.headline,
    required this.title,
    required this.body,
    required this.label,
    required this.mono,
  });

  /// Composes the shipit_ui type ramp from [font] coloured with [color].
  factory AppTextTokens.from(AppFontTokens font, AppColorTokens color) {
    TextStyle style(
      double size,
      FontWeight weight,
      double height,
      double spacing,
      Color c,
    ) => TextStyle(
      fontFamily: font.family,
      package: font.package,
      fontSize: size,
      fontWeight: weight,
      height: height,
      letterSpacing: spacing,
      color: c,
    );
    final s = font.size, w = font.weight, ls = font.letterSpacing;
    final fg = color.fg;
    return AppTextTokens(
      display: AppTextScale(
        large: style(s.xxxxl, w.semibold, 1.2, ls.tight, fg.primary),
        medium: style(s.xxxl, w.semibold, 1.2, ls.tight, fg.primary),
        small: style(s.xxl, w.semibold, 1.2, ls.normal, fg.primary),
      ),
      headline: AppTextScale(
        large: style(s.xxl, w.semibold, 1.2, ls.normal, fg.primary),
        medium: style(s.xl, w.semibold, 1.3, ls.normal, fg.primary),
        small: style(s.lg, w.semibold, 1.4, ls.normal, fg.primary),
      ),
      title: AppTextScale(
        large: style(s.lg, w.semibold, 1.4, ls.normal, fg.primary),
        medium: style(s.md, w.semibold, 1.4, ls.normal, fg.primary),
        small: style(s.sm, w.semibold, 1.4, ls.normal, fg.primary),
      ),
      body: AppTextScale(
        large: style(s.lg, w.regular, 1.5, ls.normal, fg.primary),
        medium: style(s.md, w.regular, 1.5, ls.normal, fg.primary),
        small: style(s.sm, w.regular, 1.43, ls.normal, fg.secondary),
      ),
      label: AppTextScale(
        large: style(s.sm, w.medium, 1.43, ls.wide, fg.primary),
        medium: style(s.xs, w.medium, 1.33, ls.wide, fg.primary),
        small: style(s.xs, w.medium, 1.33, ls.wide, fg.muted),
      ),
      mono: TextStyle(
        fontFamily: font.monoFamily,
        fontSize: s.sm,
        fontWeight: w.regular,
        height: 1.4,
        letterSpacing: ls.normal,
        color: fg.primary,
      ),
    );
  }

  AppTextTokens copyWith({
    AppTextScale? display,
    AppTextScale? headline,
    AppTextScale? title,
    AppTextScale? body,
    AppTextScale? label,
    TextStyle? mono,
  }) => AppTextTokens(
    display: display ?? this.display,
    headline: headline ?? this.headline,
    title: title ?? this.title,
    body: body ?? this.body,
    label: label ?? this.label,
    mono: mono ?? this.mono,
  );
}
