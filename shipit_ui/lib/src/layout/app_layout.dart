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
              const EdgeInsets.symmetric(horizontal: AppSpacing.spacingMd),
          child: child,
        ),
      ),
    );
  }

  /// Returns a responsive max-width for the current context.
  static double responsivePageWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < AppBreakpoints.sm) {
      return width;
    }
    return AppBreakpoints.pageWidth;
  }

  // MARK: - Responsive wrapper

  /// Wraps [child] with responsive horizontal padding based on layout type.
  static Widget responsivePadding({
    required Widget child,
    EdgeInsetsGeometry? compactPadding,
    EdgeInsetsGeometry? mediumPadding,
    EdgeInsetsGeometry? largePadding,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final padding = _getPadding(
          constraints.maxWidth,
          compactPadding,
          mediumPadding,
          largePadding,
        );
        return Padding(padding: padding ?? EdgeInsets.zero, child: child);
      },
    );
  }

  static EdgeInsetsGeometry? _getPadding(
    double width,
    EdgeInsetsGeometry? compact,
    EdgeInsetsGeometry? medium,
    EdgeInsetsGeometry? large,
  ) {
    if (width < AppBreakpoints.md) return compact;
    if (width < AppBreakpoints.lg) return medium;
    return large;
  }

  // MARK: - Flex layout helpers

  /// Returns a [Row] with standard spacing and alignment.
  static Widget hStack({
    required List<Widget> children,
    double spacing = AppSpacing.spacingMd,
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
    double spacing = AppSpacing.spacingMd,
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

  /// Returns a sized box with width [AppSpacing.spacingSm].
  static Widget get widthSm => const SizedBox(width: AppSpacing.spacingSm);

  /// Returns a sized box with width [AppSpacing.spacingMd].
  static Widget get widthMd => const SizedBox(width: AppSpacing.spacingMd);

  /// Returns a sized box with width [AppSpacing.spacingLg].
  static Widget get widthLg => const SizedBox(width: AppSpacing.spacingLg);

  /// Returns a sized box with height [AppSpacing.spacingSm].
  static Widget get heightSm => const SizedBox(height: AppSpacing.spacingSm);

  /// Returns a sized box with height [AppSpacing.spacingMd].
  static Widget get heightMd => const SizedBox(height: AppSpacing.spacingMd);

  /// Returns a sized box with height [AppSpacing.spacingLg].
  static Widget get heightLg => const SizedBox(height: AppSpacing.spacingLg);

  /// Returns a divider with standard spacing.
  static Widget divider({Color? color, double? thickness}) {
    return Divider(
      color: color ?? AppColors.divider,
      thickness: thickness ?? 1,
      height: AppSpacing.spacingMd,
    );
  }
}
