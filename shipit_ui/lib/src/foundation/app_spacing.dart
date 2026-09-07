// Provisional spacing tokens.
// Values are placeholders until Penpot design tokens are adopted.

import 'package:flutter/painting.dart';

/// Semantic spacing tokens for the shipit_ui design system.
///
/// All values are provisional and must be replaced with approved
/// Penpot tokens before shipping to production.
///
/// Mapping convention:
///   Penpot: token/spacing/{xs|sm|md|lg|xl|xxl}
///   Flutter: AppSpacing.{xs|sm|md|lg|xl|xxl}
class AppSpacing {
  AppSpacing._();

  /// token/spacing/2xs → 2.0
  static const double spacing2xs = 2.0;

  /// token/spacing/xs → 4.0
  static const double spacingXs = 4.0;

  /// token/spacing/sm → 8.0
  static const double spacingSm = 8.0;

  /// token/spacing/md → 16.0
  static const double spacingMd = 16.0;

  /// token/spacing/lg → 24.0
  static const double spacingLg = 24.0;

  /// token/spacing/xl → 32.0
  static const double spacingXl = 32.0;

  /// token/spacing/xxl → 48.0
  static const double spacingXxl = 48.0;

  /// token/spacing/xxxl → 64.0
  static const double spacingXxxl = 64.0;

  // MARK: - Convenience getters

  static EdgeInsetsGeometry get paddingXs => const EdgeInsets.all(spacingXs);
  static EdgeInsetsGeometry get paddingSm => const EdgeInsets.all(spacingSm);
  static EdgeInsetsGeometry get paddingMd => const EdgeInsets.all(spacingMd);
  static EdgeInsetsGeometry get paddingLg => const EdgeInsets.all(spacingLg);
  static EdgeInsetsGeometry get paddingXl => const EdgeInsets.all(spacingXl);

  static EdgeInsetsGeometry get paddingHorizontalMd =>
      const EdgeInsets.symmetric(horizontal: spacingMd);

  static EdgeInsetsGeometry get paddingHorizontalLg =>
      const EdgeInsets.symmetric(horizontal: spacingLg);

  static EdgeInsetsGeometry get paddingVerticalMd =>
      const EdgeInsets.symmetric(vertical: spacingMd);

  static EdgeInsetsGeometry get paddingVerticalLg =>
      const EdgeInsets.symmetric(vertical: spacingLg);

  static EdgeInsetsGeometry get paddingXsHorizontal =>
      const EdgeInsets.symmetric(horizontal: spacingXs);

  static EdgeInsetsGeometry get paddingSmHorizontal =>
      const EdgeInsets.symmetric(horizontal: spacingSm);

  static EdgeInsetsGeometry get paddingMdVertical =>
      const EdgeInsets.symmetric(vertical: spacingMd);
}
