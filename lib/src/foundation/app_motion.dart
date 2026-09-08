// Provisional motion tokens.
// Values are placeholders until Penpot design tokens are adopted.

import 'package:flutter/material.dart';

/// Motion/easing tokens for the shipit_ui design system.
///
/// All values are provisional and must be replaced with approved
/// Penpot tokens before shipping to production.
class AppMotion {
  AppMotion._();

  // MARK: - Durations

  /// token/motion/duration/instant → 0ms
  static const Duration instant = Duration();

  /// token/motion/duration/fast → 150ms
  static const Duration fast = Duration(milliseconds: 150);

  /// token/motion/duration/normal → 250ms
  static const Duration normal = Duration(milliseconds: 250);

  /// token/motion/duration/slow → 400ms
  static const Duration slow = Duration(milliseconds: 400);

  /// token/motion/duration/slower → 600ms
  static const Duration slower = Duration(milliseconds: 600);

  /// token/motion/duration/shimmer → 1200ms
  static const Duration shimmer = Duration(milliseconds: 1200);

  // MARK: - Curves

  /// token/motion/curve/standard → ease-in-out
  static const Curve curveStandard = Curves.easeInOut;

  /// token/motion/curve/decelerate → ease-out
  static const Curve curveDecelerate = Curves.easeOut;

  /// token/motion/curve/accelerate → ease-in
  static const Curve curveAccelerate = Curves.easeIn;

  /// token/motion/curve/sharp → sharp curve
  static const Curve curveSharp = Curves.fastOutSlowIn;

  /// token/motion/curve/bouncy → bouncy curve
  static const Curve curveBouncy = Curves.elasticOut;

  // MARK: - Animation durations for specific component types

  /// Duration for button press feedback.
  static const Duration buttonPress = Duration(milliseconds: 100);

  /// Duration for tooltip fade.
  static const Duration tooltip = Duration(milliseconds: 150);

  /// Duration for menu/dropdown entrance.
  static const Duration menu = Duration(milliseconds: 200);

  /// Duration for dialog entrance.
  static const Duration dialog = Duration(milliseconds: 250);

  /// Duration for snackbar/notification entrance.
  static const Duration snackbar = Duration(milliseconds: 300);

  /// Duration for page transitions.
  static const Duration pageTransition = Duration(milliseconds: 300);

  // MARK: - Convenience animation tuples

  static const AnimationPair buttonAnimation = AnimationPair(
    duration: buttonPress,
    curve: curveSharp,
  );

  static const AnimationPair dialogAnimation = AnimationPair(
    duration: dialog,
    curve: curveStandard,
  );

  static const AnimationPair pageAnimation = AnimationPair(
    duration: pageTransition,
    curve: curveStandard,
  );
}

/// A tuple of duration and curve for convenience in animation specs.
class AnimationPair {
  final Duration duration;
  final Curve curve;

  const AnimationPair({required this.duration, required this.curve});
}
