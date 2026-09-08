import 'package:flutter/material.dart';
import 'package:shipit_ui/src/foundation/app_breakpoints.dart';
import 'package:shipit_ui/src/foundation/app_colors.dart';
import 'package:shipit_ui/src/foundation/app_spacing.dart';

/// Layout primitives for the shipit_ui design system.
///
/// Provides responsive layout helpers, standard page widths,
/// and spacing/layout primitives.
class AppLayout {
  AppLayout._();

  // MARK: - Standard page widths

  /// Returns a constrained [BoxConstraints] for standard page content.
  static BoxConstraints pageConstraints({
    double? width,
    EdgeInsetsGeometry? padding,
  }) {
    return BoxConstraints(maxWidth: width ?? AppBreakpoints.pageWidth);
  }

  /// Returns a horizontally centered [Container] with max-width constraints.
  static Widget centeredPage({
    required Widget child,
    double? width,
    EdgeInsetsGeometry? padding,
  }) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: width ?? AppBreakpoints.pageWidth,
        ),
        child: Padding(
          padding:
              padding ??
              const EdgeInsets.symmetric(horizontal: AppSpacing.space4),
          child: child,
        ),
      ),
    );
  }

  /// Returns a responsive max-width for the current context.
  static double responsivePageWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < AppBreakpoints.mobile) {
      return width;
    }
    return AppBreakpoints.pageWidth;
  }

  // MARK: - Responsive wrapper

  /// Wraps [child] with responsive horizontal padding based on layout type.
  static Widget responsivePadding({
    required Widget child,
    EdgeInsetsGeometry? compactPadding,
    EdgeInsetsGeometry? mobilePadding,
    EdgeInsetsGeometry? tabletPadding,
    EdgeInsetsGeometry? desktopPadding,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final padding = _getPadding(
          constraints.maxWidth,
          compactPadding,
          mobilePadding,
          tabletPadding,
          desktopPadding,
        );
        return Padding(padding: padding ?? EdgeInsets.zero, child: child);
      },
    );
  }

  static EdgeInsetsGeometry? _getPadding(
    double width,
    EdgeInsetsGeometry? compact,
    EdgeInsetsGeometry? mobile,
    EdgeInsetsGeometry? tablet,
    EdgeInsetsGeometry? desktop,
  ) {
    if (width < AppBreakpoints.mobile) return compact;
    if (width < AppBreakpoints.tablet) return mobile;
    if (width < AppBreakpoints.desktop) return tablet;
    return desktop;
  }

  // MARK: - Flex layout helpers

  /// Returns a [Row] with standard spacing and alignment.
  static Widget hStack({
    required List<Widget> children,
    double spacing = AppSpacing.space4,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    WrapAlignment wrapAlignment = WrapAlignment.start,
    bool wrap = false,
  }) {
    if (wrap) {
      return Wrap(
        spacing: spacing,
        runSpacing: spacing,
        alignment: wrapAlignment,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: children,
      );
    }
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      spacing: spacing,
      children: children,
    );
  }

  /// Returns a [Column] with standard spacing and alignment.
  static Widget vStack({
    required List<Widget> children,
    double spacing = AppSpacing.space4,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
    bool wrap = false,
  }) {
    if (wrap) {
      return Wrap(
        spacing: spacing,
        runSpacing: spacing,
        direction: Axis.vertical,
        children: children,
      );
    }
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      spacing: spacing,
      children: children,
    );
  }

  // MARK: - Spacer utilities

  /// Returns a sized box with width [AppSpacing.space2].
  static Widget get width2 => const SizedBox(width: AppSpacing.space2);

  /// Returns a sized box with width [AppSpacing.space4].
  static Widget get width4 => const SizedBox(width: AppSpacing.space4);

  /// Returns a sized box with width [AppSpacing.space6].
  static Widget get width6 => const SizedBox(width: AppSpacing.space6);

  /// Returns a sized box with height [AppSpacing.space2].
  static Widget get height2 => const SizedBox(height: AppSpacing.space2);

  /// Returns a sized box with height [AppSpacing.space4].
  static Widget get height4 => const SizedBox(height: AppSpacing.space4);

  /// Returns a sized box with height [AppSpacing.space6].
  static Widget get height6 => const SizedBox(height: AppSpacing.space6);

  /// Returns a divider with standard spacing.
  static Widget divider({Color? color, double? thickness}) {
    return Divider(
      color: color ?? AppColors.borderDefaultColor,
      thickness: thickness ?? 1,
      height: AppSpacing.space4,
    );
  }
}
