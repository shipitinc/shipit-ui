import 'package:flutter/painting.dart';

/// Spacing scale (`space.*`). `context.space.s4` is Penpot `space.4` = 16px.
class AppSpaceTokens {
  final double s0;
  final double s1;
  final double s2;
  final double s3;
  final double s4;
  final double s5;
  final double s6;
  final double s8;
  final double s10;
  final double s12;
  final double s16;

  const AppSpaceTokens({
    required this.s0,
    required this.s1,
    required this.s2,
    required this.s3,
    required this.s4,
    required this.s5,
    required this.s6,
    required this.s8,
    required this.s10,
    required this.s12,
    required this.s16,
  });

  static const AppSpaceTokens base = AppSpaceTokens(
    s0: 0,
    s1: 4,
    s2: 8,
    s3: 12,
    s4: 16,
    s5: 20,
    s6: 24,
    s8: 32,
    s10: 40,
    s12: 48,
    s16: 64,
  );

  AppSpaceTokens copyWith({
    double? s0,
    double? s1,
    double? s2,
    double? s3,
    double? s4,
    double? s5,
    double? s6,
    double? s8,
    double? s10,
    double? s12,
    double? s16,
  }) => AppSpaceTokens(
    s0: s0 ?? this.s0,
    s1: s1 ?? this.s1,
    s2: s2 ?? this.s2,
    s3: s3 ?? this.s3,
    s4: s4 ?? this.s4,
    s5: s5 ?? this.s5,
    s6: s6 ?? this.s6,
    s8: s8 ?? this.s8,
    s10: s10 ?? this.s10,
    s12: s12 ?? this.s12,
    s16: s16 ?? this.s16,
  );
}

/// Radius scale (`radius.*`) as raw values; `all` gives the same scale as
/// [BorderRadius] (`context.radius.all.md`).
class AppRadiusTokens {
  final double none;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double full;

  const AppRadiusTokens({
    required this.none,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.full,
  });

  static const AppRadiusTokens base = AppRadiusTokens(
    none: 0,
    sm: 4,
    md: 8,
    lg: 12,
    xl: 16,
    full: 999,
  );

  AppBorderRadiusTokens get all => AppBorderRadiusTokens._(this);

  AppRadiusTokens copyWith({
    double? none,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? full,
  }) => AppRadiusTokens(
    none: none ?? this.none,
    sm: sm ?? this.sm,
    md: md ?? this.md,
    lg: lg ?? this.lg,
    xl: xl ?? this.xl,
    full: full ?? this.full,
  );
}

/// [BorderRadius] view over [AppRadiusTokens].
class AppBorderRadiusTokens {
  final AppRadiusTokens _r;
  const AppBorderRadiusTokens._(this._r);

  BorderRadius get none => BorderRadius.circular(_r.none);
  BorderRadius get sm => BorderRadius.circular(_r.sm);
  BorderRadius get md => BorderRadius.circular(_r.md);
  BorderRadius get lg => BorderRadius.circular(_r.lg);
  BorderRadius get xl => BorderRadius.circular(_r.xl);
  BorderRadius get full => BorderRadius.circular(_r.full);
}

/// Shadow levels (`elevation.*`). `context.elevation.e2` is Penpot
/// `elevation.2`.
class AppElevationTokens {
  final List<BoxShadow> e0;
  final List<BoxShadow> e1;
  final List<BoxShadow> e2;
  final List<BoxShadow> e3;

  const AppElevationTokens({
    required this.e0,
    required this.e1,
    required this.e2,
    required this.e3,
  });

  static const AppElevationTokens base = AppElevationTokens(
    e0: [],
    e1: [
      BoxShadow(
        color: Color.fromRGBO(15, 23, 42, 0.08),
        offset: Offset(0, 1),
        blurRadius: 2,
      ),
    ],
    e2: [
      BoxShadow(
        color: Color.fromRGBO(15, 23, 42, 0.10),
        offset: Offset(0, 2),
        blurRadius: 8,
      ),
    ],
    e3: [
      BoxShadow(
        color: Color.fromRGBO(15, 23, 42, 0.16),
        offset: Offset(0, 8),
        blurRadius: 24,
      ),
    ],
  );

  AppElevationTokens copyWith({
    List<BoxShadow>? e0,
    List<BoxShadow>? e1,
    List<BoxShadow>? e2,
    List<BoxShadow>? e3,
  }) => AppElevationTokens(
    e0: e0 ?? this.e0,
    e1: e1 ?? this.e1,
    e2: e2 ?? this.e2,
    e3: e3 ?? this.e3,
  );
}

/// Opacity tokens (`opacity.*`).
class AppOpacityTokens {
  final double scrim;

  const AppOpacityTokens({required this.scrim});

  static const AppOpacityTokens base = AppOpacityTokens(scrim: 0.4);

  AppOpacityTokens copyWith({double? scrim}) =>
      AppOpacityTokens(scrim: scrim ?? this.scrim);
}

/// Max-width constraints (`maxWidth.*`).
class AppLayoutMaxWidthTokens {
  final double form;

  const AppLayoutMaxWidthTokens({required this.form});

  static const AppLayoutMaxWidthTokens base = AppLayoutMaxWidthTokens(
    form: 440,
  );

  AppLayoutMaxWidthTokens copyWith({double? form}) =>
      AppLayoutMaxWidthTokens(form: form ?? this.form);
}

/// Layout tokens (`layout.*`): max-width constraints for centered content.
class AppLayoutTokens {
  final AppLayoutMaxWidthTokens maxWidth;

  const AppLayoutTokens({required this.maxWidth});

  static const AppLayoutTokens base = AppLayoutTokens(
    maxWidth: AppLayoutMaxWidthTokens.base,
  );

  AppLayoutTokens copyWith({AppLayoutMaxWidthTokens? maxWidth}) =>
      AppLayoutTokens(maxWidth: maxWidth ?? this.maxWidth);
}

/// Layout classes derived from [AppBreakpointTokens].
enum AppLayoutType { compact, mobile, tablet, desktop, wide }

/// Responsive breakpoints (`breakpoint.*`) and page widths.
class AppBreakpointTokens {
  final double mobile;
  final double tablet;
  final double desktop;
  final double wide;
  final double pageWidth;

  const AppBreakpointTokens({
    required this.mobile,
    required this.tablet,
    required this.desktop,
    required this.wide,
    required this.pageWidth,
  });

  static const AppBreakpointTokens base = AppBreakpointTokens(
    mobile: 360,
    tablet: 600,
    desktop: 1024,
    wide: 1440,
    pageWidth: 1200,
  );

  AppLayoutType layoutTypeFor(double width) {
    if (width < mobile) return AppLayoutType.compact;
    if (width < tablet) return AppLayoutType.mobile;
    if (width < desktop) return AppLayoutType.tablet;
    if (width < wide) return AppLayoutType.desktop;
    return AppLayoutType.wide;
  }

  AppBreakpointTokens copyWith({
    double? mobile,
    double? tablet,
    double? desktop,
    double? wide,
    double? pageWidth,
  }) => AppBreakpointTokens(
    mobile: mobile ?? this.mobile,
    tablet: tablet ?? this.tablet,
    desktop: desktop ?? this.desktop,
    wide: wide ?? this.wide,
    pageWidth: pageWidth ?? this.pageWidth,
  );
}
