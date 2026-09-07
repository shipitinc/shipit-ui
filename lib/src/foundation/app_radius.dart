// Provisional radius tokens.
// Values are placeholders until Penpot design tokens are adopted.

import 'package:flutter/painting.dart';

/// Semantic border radius tokens for the shipit_ui design system.
///
/// All values are provisional and must be replaced with approved
/// Penpot tokens before shipping to production.
class AppRadius {
  AppRadius._();

  /// token/radius/none → 0.0
  static const double radiusNone = 0.0;

  /// token/radius/sm → 4.0
  static const double radiusSm = 4.0;

  /// token/radius/md → 8.0
  static const double radiusMd = 8.0;

  /// token/radius/lg → 12.0
  static const double radiusLg = 12.0;

  /// token/radius/xl → 16.0
  static const double radiusXl = 16.0;

  /// token/radius/xxl → 24.0 (full pill)
  static const double radiusXxl = 24.0;

  /// token/radius/full → 9999.0
  static const double radiusFull = 9999.0;

  // MARK: - Border Radius instances

  static const BorderRadius borderRadiusSm = BorderRadius.all(
    Radius.circular(radiusSm),
  );
  static const BorderRadius borderRadiusMd = BorderRadius.all(
    Radius.circular(radiusMd),
  );
  static const BorderRadius borderRadiusLg = BorderRadius.all(
    Radius.circular(radiusLg),
  );
  static const BorderRadius borderRadiusXl = BorderRadius.all(
    Radius.circular(radiusXl),
  );
  static const BorderRadius borderRadiusXxl = BorderRadius.all(
    Radius.circular(radiusXxl),
  );
  static const BorderRadius borderRadiusFull = BorderRadius.all(
    Radius.circular(radiusFull),
  );

  // MARK: - Border Radius Geometry (horizontal/vertical variants)

  static BorderRadius borderRadiusTopMd = const BorderRadius.vertical(
    top: Radius.circular(radiusMd),
  );
  static BorderRadius borderRadiusBottomMd = const BorderRadius.vertical(
    bottom: Radius.circular(radiusMd),
  );
  static BorderRadius borderRadiusLeftMd = const BorderRadius.horizontal(
    left: Radius.circular(radiusMd),
  );
  static BorderRadius borderRadiusRightMd = const BorderRadius.horizontal(
    right: Radius.circular(radiusMd),
  );
}
