import 'package:flutter/material.dart';
import 'package:shipit_ui/src/theme/tokens/app_color_tokens.dart';
import 'package:shipit_ui/src/theme/tokens/app_layout_tokens.dart';
import 'package:shipit_ui/src/theme/tokens/app_motion_tokens.dart';
import 'package:shipit_ui/src/theme/tokens/app_text_tokens.dart';

export 'package:shipit_ui/src/theme/tokens/app_color_tokens.dart';
export 'package:shipit_ui/src/theme/tokens/app_layout_tokens.dart';
export 'package:shipit_ui/src/theme/tokens/app_motion_tokens.dart';
export 'package:shipit_ui/src/theme/tokens/app_text_tokens.dart';

/// The complete shipit_ui token tree, registered on [ThemeData] as a
/// [ThemeExtension].
///
/// Read it through the [AppThemeContext] extension — `context.color.bg.base`,
/// `context.space.s4`, `context.radius.all.md`, `context.text.body.medium`,
/// `context.motion.duration.fast` — never through static constants. Every
/// node has a `copyWith`, so a consuming app can replace one segment:
///
/// ```dart
/// shipitLightTheme(
///   tokens: AppTheme.light.copyWith(
///     radius: AppTheme.light.radius.copyWith(md: 12),
///   ),
/// )
/// ```
class AppTheme extends ThemeExtension<AppTheme> {
  final AppColorTokens color;
  final AppSpaceTokens space;
  final AppRadiusTokens radius;
  final AppFontTokens font;
  final AppTextTokens text;
  final AppElevationTokens elevation;
  final AppMotionTokens motion;
  final AppBreakpointTokens breakpoint;
  final AppOpacityTokens opacity;

  const AppTheme({
    required this.color,
    required this.space,
    required this.radius,
    required this.font,
    required this.text,
    required this.elevation,
    required this.motion,
    required this.breakpoint,
    required this.opacity,
  });

  /// Builds a theme from [color] with the shared non-color defaults; text
  /// styles are derived from [font] and [color].
  factory AppTheme.fromColor(
    AppColorTokens color, {
    AppFontTokens font = AppFontTokens.base,
  }) => AppTheme(
    color: color,
    space: AppSpaceTokens.base,
    radius: AppRadiusTokens.base,
    font: font,
    text: AppTextTokens.from(font, color),
    elevation: AppElevationTokens.base,
    motion: AppMotionTokens.base,
    breakpoint: AppBreakpointTokens.base,
    opacity: AppOpacityTokens.base,
  );

  static final AppTheme light = AppTheme.fromColor(AppColorTokens.light);
  static final AppTheme dark = AppTheme.fromColor(AppColorTokens.dark);

  Brightness get brightness => color.brightness;

  /// The tokens registered on the ambient [Theme]; falls back to
  /// [AppTheme.light] / [AppTheme.dark] by theme brightness when the app does
  /// not use `shipitLightTheme()` / `shipitDarkTheme()`.
  static AppTheme of(BuildContext context) {
    final theme = Theme.of(context);
    return theme.extension<AppTheme>() ??
        (theme.brightness == Brightness.dark ? dark : light);
  }

  /// Replaces whole nodes. When [color] or [font] change and [text] is not
  /// supplied, text styles are re-derived so colours stay consistent.
  @override
  AppTheme copyWith({
    AppColorTokens? color,
    AppSpaceTokens? space,
    AppRadiusTokens? radius,
    AppFontTokens? font,
    AppTextTokens? text,
    AppElevationTokens? elevation,
    AppMotionTokens? motion,
    AppBreakpointTokens? breakpoint,
    AppOpacityTokens? opacity,
  }) {
    final c = color ?? this.color;
    final f = font ?? this.font;
    return AppTheme(
      color: c,
      space: space ?? this.space,
      radius: radius ?? this.radius,
      font: f,
      text:
          text ??
          ((color != null || font != null)
              ? AppTextTokens.from(f, c)
              : this.text),
      elevation: elevation ?? this.elevation,
      motion: motion ?? this.motion,
      breakpoint: breakpoint ?? this.breakpoint,
      opacity: opacity ?? this.opacity,
    );
  }

  @override
  AppTheme lerp(ThemeExtension<AppTheme>? other, double t) =>
      t < 0.5 ? this : (other is AppTheme ? other : this);
}

/// Token access on [BuildContext]: the only sanctioned way to read design
/// values in product code.
extension AppThemeContext on BuildContext {
  AppTheme get appTheme => AppTheme.of(this);
  AppColorTokens get color => appTheme.color;
  AppSpaceTokens get space => appTheme.space;
  AppRadiusTokens get radius => appTheme.radius;
  AppFontTokens get font => appTheme.font;
  AppTextTokens get text => appTheme.text;
  AppElevationTokens get elevation => appTheme.elevation;
  AppMotionTokens get motion => appTheme.motion;
  AppBreakpointTokens get breakpoint => appTheme.breakpoint;
  AppOpacityTokens get opacity => appTheme.opacity;

  /// Current layout class from the window width and [breakpoint] tokens.
  AppLayoutType get layoutType =>
      breakpoint.layoutTypeFor(MediaQuery.sizeOf(this).width);

  bool get isCompactLayout => layoutType == AppLayoutType.compact;
  bool get isMobileLayout => layoutType == AppLayoutType.mobile;
  bool get isTabletLayout => layoutType == AppLayoutType.tablet;
  bool get isDesktopLayout => layoutType == AppLayoutType.desktop;
  bool get isWideLayout => layoutType == AppLayoutType.wide;

  /// Width is at least the tablet / desktop / wide breakpoint.
  bool get isTabletOrLarger => layoutType.index >= AppLayoutType.tablet.index;
  bool get isDesktopOrLarger => layoutType.index >= AppLayoutType.desktop.index;
  bool get isWideOrLarger => layoutType == AppLayoutType.wide;
}
