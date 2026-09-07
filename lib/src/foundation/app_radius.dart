/// Semantic border radius tokens for the shipit_ui design system.
///
/// Values are derived from approved Penpot design tokens.
/// See docs/penpot-mapping.md for the mapping convention.
import 'package:flutter/painting.dart';

class AppRadius {
  AppRadius._();

  // MARK: - Radius Scale (Penpot radius.none through radius.full)

  /// token/radius/none → 0
  static const double radiusNone = 0;

  /// token/radius/sm → 4
  static const double radiusSm = 4;

  /// token/radius/md → 8
  static const double radiusMd = 8;

  /// token/radius/lg → 12
  static const double radiusLg = 12;

  /// token/radius/xl → 16
  static const double radiusXl = 16;

  /// token/radius/full → 999
  static const double radiusFull = 999;

  // MARK: - Border Radius Instances

  static const BorderRadius borderRadiusNone = BorderRadius.all(
    Radius.circular(radiusNone),
  );
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
  static const BorderRadius borderRadiusFull = BorderRadius.all(
    Radius.circular(radiusFull),
  );

  // MARK: - Border Radius Geometry (horizontal/vertical variants)

  static const BorderRadius borderRadiusTopMd = BorderRadius.vertical(
    top: Radius.circular(radiusMd),
  );
  static const BorderRadius borderRadiusBottomMd = BorderRadius.vertical(
    bottom: Radius.circular(radiusMd),
  );
  static const BorderRadius borderRadiusLeftMd = BorderRadius.horizontal(
    left: Radius.circular(radiusMd),
  );
  static const BorderRadius borderRadiusRightMd = BorderRadius.horizontal(
    right: Radius.circular(radiusMd),
  );
}