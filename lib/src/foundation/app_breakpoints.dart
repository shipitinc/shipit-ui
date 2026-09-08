/// Breakpoint tokens for responsive design in the shipit_ui design system.
///
/// Values are derived from approved Penpot design tokens.
/// See docs/penpot-mapping.md for the mapping convention.
library;

import 'package:flutter/material.dart';

class AppBreakpoints {
  AppBreakpoints._();

  // MARK: - Breakpoint Tokens (Penpot breakpoint.mobile through breakpoint.wide)

  /// token/breakpoint/mobile → 360
  static const double mobile = 360;

  /// token/breakpoint/tablet → 600
  static const double tablet = 600;

  /// token/breakpoint/desktop → 1024
  static const double desktop = 1024;

  /// token/breakpoint/wide → 1440
  static const double wide = 1440;

  // MARK: - Standard Page/Container Widths

  /// Maximum width for standard page content.
  static const double pageWidth = 1200;

  /// Maximum width for centered content on mobile screens.
  static const double pageWidthMobile = 360;

  /// Maximum width for centered content on tablet screens.
  static const double pageWidthTablet = 600;

  /// Maximum width for centered content on desktop screens.
  static const double pageWidthDesktop = 1024;

  /// Maximum width for centered content on wide desktop screens.
  static const double pageWidthWide = 1440;

  // MARK: - Breakpoint Detection Helpers

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width >= mobile;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= tablet;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= desktop;

  static bool isWide(BuildContext context) =>
      MediaQuery.of(context).size.width >= wide;

  static bool isMobileOrLarger(BuildContext context) =>
      MediaQuery.of(context).size.width >= mobile;

  static bool isTabletOrLarger(BuildContext context) =>
      MediaQuery.of(context).size.width >= tablet;

  static bool isDesktopOrLarger(BuildContext context) =>
      MediaQuery.of(context).size.width >= desktop;

  static bool isWideOrLarger(BuildContext context) =>
      MediaQuery.of(context).size.width >= wide;

  // MARK: - Layout Type Detection

  /// Returns the current layout type based on screen width.
  static AppLayoutType getLayoutType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < mobile) return AppLayoutType.compact;
    if (width < tablet) return AppLayoutType.mobile;
    if (width < desktop) return AppLayoutType.tablet;
    if (width < wide) return AppLayoutType.desktop;
    return AppLayoutType.wide;
  }
}

/// Enumeration of layout types based on breakpoints.
enum AppLayoutType { compact, mobile, tablet, desktop, wide }

/// Extension for convenient breakpoint-based layout switching.
extension AppBreakpointExtension on BuildContext {
  /// Whether the current layout is compact (smaller than mobile).
  bool get isCompactLayout => !AppBreakpoints.isMobile(this);

  /// Whether the current layout is mobile.
  bool get isMobileLayout =>
      AppBreakpoints.isMobile(this) && !AppBreakpoints.isTablet(this);

  /// Whether the current layout is tablet.
  bool get isTabletLayout =>
      AppBreakpoints.isTablet(this) && !AppBreakpoints.isDesktop(this);

  /// Whether the current layout is desktop.
  bool get isDesktopLayout =>
      AppBreakpoints.isDesktop(this) && !AppBreakpoints.isWide(this);

  /// Whether the current layout is wide desktop.
  bool get isWideLayout => AppBreakpoints.isWide(this);
}
