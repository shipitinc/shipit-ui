/// Semantic spacing tokens for the shipit_ui design system.
///
/// Values are derived from approved Penpot design tokens.
/// See docs/penpot-mapping.md for the mapping convention.
import 'package:flutter/painting.dart';

class AppSpacing {
  AppSpacing._();

  // MARK: - Spacing Scale (Penpot space.0 through space.16)

  /// token/spacing/0 → 0
  static const double space0 = 0;

  /// token/spacing/1 → 4
  static const double space1 = 4;

  /// token/spacing/2 → 8
  static const double space2 = 8;

  /// token/spacing/3 → 12
  static const double space3 = 12;

  /// token/spacing/4 → 16
  static const double space4 = 16;

  /// token/spacing/5 → 20
  static const double space5 = 20;

  /// token/spacing/6 → 24
  static const double space6 = 24;

  /// token/spacing/8 → 32
  static const double space8 = 32;

  /// token/spacing/10 → 40
  static const double space10 = 40;

  /// token/spacing/12 → 48
  static const double space12 = 48;

  /// token/spacing/16 → 64
  static const double space16 = 64;

  // MARK: - Convenience Getters

  static EdgeInsetsGeometry get padding0 => const EdgeInsets.all(space0);
  static EdgeInsetsGeometry get padding1 => const EdgeInsets.all(space1);
  static EdgeInsetsGeometry get padding2 => const EdgeInsets.all(space2);
  static EdgeInsetsGeometry get padding3 => const EdgeInsets.all(space3);
  static EdgeInsetsGeometry get padding4 => const EdgeInsets.all(space4);
  static EdgeInsetsGeometry get padding5 => const EdgeInsets.all(space5);
  static EdgeInsetsGeometry get padding6 => const EdgeInsets.all(space6);
  static EdgeInsetsGeometry get padding8 => const EdgeInsets.all(space8);
  static EdgeInsetsGeometry get padding10 => const EdgeInsets.all(space10);
  static EdgeInsetsGeometry get padding12 => const EdgeInsets.all(space12);
  static EdgeInsetsGeometry get padding16 => const EdgeInsets.all(space16);

  static EdgeInsetsGeometry get paddingHorizontal4 =>
      const EdgeInsets.symmetric(horizontal: space4);
  static EdgeInsetsGeometry get paddingHorizontal6 =>
      const EdgeInsets.symmetric(horizontal: space6);
  static EdgeInsetsGeometry get paddingHorizontal8 =>
      const EdgeInsets.symmetric(horizontal: space8);

  static EdgeInsetsGeometry get paddingVertical4 =>
      const EdgeInsets.symmetric(vertical: space4);
  static EdgeInsetsGeometry get paddingVertical6 =>
      const EdgeInsets.symmetric(vertical: space6);
  static EdgeInsetsGeometry get paddingVertical8 =>
      const EdgeInsets.symmetric(vertical: space8);
}