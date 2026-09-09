import 'package:flutter/animation.dart';

/// `motion.duration.*`
class AppDurationTokens {
  final Duration instant;
  final Duration fast;
  final Duration normal;
  final Duration slow;
  final Duration slower;
  final Duration shimmer;
  final Duration buttonPress;
  final Duration tooltip;
  final Duration menu;
  final Duration dialog;
  final Duration snackbar;
  final Duration pageTransition;

  const AppDurationTokens({
    required this.instant,
    required this.fast,
    required this.normal,
    required this.slow,
    required this.slower,
    required this.shimmer,
    required this.buttonPress,
    required this.tooltip,
    required this.menu,
    required this.dialog,
    required this.snackbar,
    required this.pageTransition,
  });

  AppDurationTokens copyWith({
    Duration? instant,
    Duration? fast,
    Duration? normal,
    Duration? slow,
    Duration? slower,
    Duration? shimmer,
    Duration? buttonPress,
    Duration? tooltip,
    Duration? menu,
    Duration? dialog,
    Duration? snackbar,
    Duration? pageTransition,
  }) => AppDurationTokens(
    instant: instant ?? this.instant,
    fast: fast ?? this.fast,
    normal: normal ?? this.normal,
    slow: slow ?? this.slow,
    slower: slower ?? this.slower,
    shimmer: shimmer ?? this.shimmer,
    buttonPress: buttonPress ?? this.buttonPress,
    tooltip: tooltip ?? this.tooltip,
    menu: menu ?? this.menu,
    dialog: dialog ?? this.dialog,
    snackbar: snackbar ?? this.snackbar,
    pageTransition: pageTransition ?? this.pageTransition,
  );
}

/// `motion.curve.*`
class AppCurveTokens {
  final Curve standard;
  final Curve decelerate;
  final Curve accelerate;
  final Curve sharp;
  final Curve bouncy;

  const AppCurveTokens({
    required this.standard,
    required this.decelerate,
    required this.accelerate,
    required this.sharp,
    required this.bouncy,
  });

  AppCurveTokens copyWith({
    Curve? standard,
    Curve? decelerate,
    Curve? accelerate,
    Curve? sharp,
    Curve? bouncy,
  }) => AppCurveTokens(
    standard: standard ?? this.standard,
    decelerate: decelerate ?? this.decelerate,
    accelerate: accelerate ?? this.accelerate,
    sharp: sharp ?? this.sharp,
    bouncy: bouncy ?? this.bouncy,
  );
}

/// Motion tokens (`motion.*`): `context.motion.duration.fast`,
/// `context.motion.curve.standard`.
class AppMotionTokens {
  final AppDurationTokens duration;
  final AppCurveTokens curve;

  const AppMotionTokens({required this.duration, required this.curve});

  static const AppMotionTokens base = AppMotionTokens(
    duration: AppDurationTokens(
      instant: Duration.zero,
      fast: Duration(milliseconds: 150),
      normal: Duration(milliseconds: 250),
      slow: Duration(milliseconds: 400),
      slower: Duration(milliseconds: 600),
      shimmer: Duration(milliseconds: 1200),
      buttonPress: Duration(milliseconds: 100),
      tooltip: Duration(milliseconds: 150),
      menu: Duration(milliseconds: 200),
      dialog: Duration(milliseconds: 250),
      snackbar: Duration(milliseconds: 300),
      pageTransition: Duration(milliseconds: 300),
    ),
    curve: AppCurveTokens(
      standard: Curves.easeInOut,
      decelerate: Curves.easeOut,
      accelerate: Curves.easeIn,
      sharp: Curves.fastOutSlowIn,
      bouncy: Curves.elasticOut,
    ),
  );

  AppMotionTokens copyWith({
    AppDurationTokens? duration,
    AppCurveTokens? curve,
  }) => AppMotionTokens(
    duration: duration ?? this.duration,
    curve: curve ?? this.curve,
  );
}
