/// Elevation/shadow tokens for the shipit_ui design system.
///
/// Values are derived from approved Penpot design tokens.
/// See docs/penpot-mapping.md for the mapping convention.
import 'dart:ui';
import 'package:flutter/painting.dart';

class AppElevation {
  AppElevation._();

  // MARK: - Elevation Levels (Penpot elevation.0 through elevation.3)

  /// token/elevation/0 → No shadow
  static const List<BoxShadow> elevation0 = [];

  /// token/elevation/1 → 0px 1px 2px 0px rgba(15,23,42,0.08)
  static const List<BoxShadow> elevation1 = [
    BoxShadow(
      color: Color.fromRGBO(15, 23, 42, 0.08),
      offset: Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
    ),
  ];

  /// token/elevation/2 → 0px 2px 8px 0px rgba(15,23,42,0.10)
  static const List<BoxShadow> elevation2 = [
    BoxShadow(
      color: Color.fromRGBO(15, 23, 42, 0.10),
      offset: Offset(0, 2),
      blurRadius: 8,
      spreadRadius: 0,
    ),
  ];

  /// token/elevation/3 → 0px 8px 24px 0px rgba(15,23,42,0.16)
  static const List<BoxShadow> elevation3 = [
    BoxShadow(
      color: Color.fromRGBO(15, 23, 42, 0.16),
      offset: Offset(0, 8),
      blurRadius: 24,
      spreadRadius: 0,
    ),
  ];
}