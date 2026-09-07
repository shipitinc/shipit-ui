// Provisional breakpoint tokens.
// Values are placeholders until Penpot design tokens are adopted.

import 'package:flutter/material.dart';

/// Breakpoint tokens for responsive design in the shipit_ui design system.
///
/// All values are provisional and must be replaced with approved
/// Penpot tokens before shipping to production.
///
/// Mapping convention:
///   Penpot: token/breakpoint/{sm|md|lg|xl}
///   Flutter: AppBreakpoints.{sm|md|lg|xl}
class AppBreakpoints {
  AppBreakpoints._();

  /// token/breakpoint/sm → 600
  static const double sm = 600;

  /// token/breakpoint/md → 900
  static const double md = 900;

  /// token/breakpoint/lg → 1200
  static const double lg = 1200;

  /// token/breakpoint/xl → 1600
  static const double xl = 1600;

  // MARK: - Standard page/container widths

  /// Maximum width for standard page content.
  static const double pageWidth = 1200;

  /// Maximum width for centered content on smaller screens.
  static const double pageWidthSm = 600;

  /// Maximum width for centered content on medium screens.
  static const double pageWidthMd = 960;

  /// Maximum width for centered content on large screens.
  static const double pageWidthLg = 1200;

  // MARK: - Breakpoint detection helpers

  static bool isSm(BuildContext context) =>
      MediaQuery.of(context).size.width >= sm;

  static bool isMd(BuildContext context) =>
      MediaQuery.of(context).size.width >= md;

  static bool isLg(BuildContext context) =>
      MediaQuery.of(context).size.width >= lg;

  static bool isXl(BuildContext context) =>
      MediaQuery.of(context).size.width >= xl;

  static bool isSmOrLarger(BuildContext context) =>
      MediaQuery.of(context).size.width >= sm;

  static bool isMdOrLarger(BuildContext context) =>
      MediaQuery.of(context).size.width >= md;

  static bool isLgOrLarger(BuildContext context) =>
      MediaQuery.of(context).size.width >= lg;

  static bool isXlOrLarger(BuildContext context) =>
      MediaQuery.of(context).size.width >= xl;

  // MARK: - Layout type detection

  /// Returns the current layout type based on screen width.
  static AppLayoutType getLayoutType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < sm) return AppLayoutType.compact;
    if (width < md) return AppLayoutType.medium;
    if (width < lg) return AppLayoutType.large;
    return AppLayoutType.extraLarge;
  }
}

/// Enumeration of layout types based on breakpoints.
enum AppLayoutType { compact, medium, large, extraLarge }

/// Extension for convenient breakpoint-based layout switching.
extension AppBreakpointExtension on BuildContext {
  /// Whether the current layout is compact (mobile).
  bool get isCompactLayout => !AppBreakpoints.isSm(this);

  /// Whether the current layout is medium (tablet).
  bool get isMediumLayout =>
      AppBreakpoints.isSm(this) && !AppBreakpoints.isMd(this);

  /// Whether the current layout is large (desktop).
  bool get isLargeLayout =>
      AppBreakpoints.isMd(this) && !AppBreakpoints.isLg(this);

  /// Whether the current layout is extra large (wide desktop).
  bool get isExtraLargeLayout => AppBreakpoints.isLg(this);
}
