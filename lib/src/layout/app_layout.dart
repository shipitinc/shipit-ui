import 'package:flutter/material.dart';
import 'package:shipit_ui/src/theme/app_theme_tokens.dart';

/// Layout primitives for the shipit_ui design system.
///
/// Every helper resolves its defaults from the ambient [AppTheme] via
/// `context.space` / `context.breakpoint`, so consumer overrides apply.
class AppLayout {
  AppLayout._();

  // MARK: - Standard page widths

  /// Max-width constraints for standard page content.
  static BoxConstraints pageConstraints(
    BuildContext context, {
    double? width,
  }) => BoxConstraints(maxWidth: width ?? context.breakpoint.pageWidth);

  /// A horizontally centered, max-width constrained page body.
  static Widget centeredPage({
    required Widget child,
    double? width,
    EdgeInsetsGeometry? padding,
  }) {
    return Builder(
      builder: (context) => Center(
        child: ConstrainedBox(
          constraints: pageConstraints(context, width: width),
          child: Padding(
            padding:
                padding ?? EdgeInsets.symmetric(horizontal: context.space.s4),
            child: child,
          ),
        ),
      ),
    );
  }

  /// Full width below the mobile breakpoint, otherwise the page width.
  static double responsivePageWidth(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width < context.breakpoint.mobile
        ? width
        : context.breakpoint.pageWidth;
  }

  // MARK: - Responsive wrapper

  /// Wraps [child] with padding chosen by the available width's layout class.
  static Widget responsivePadding({
    required Widget child,
    EdgeInsetsGeometry? compactPadding,
    EdgeInsetsGeometry? mobilePadding,
    EdgeInsetsGeometry? tabletPadding,
    EdgeInsetsGeometry? desktopPadding,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final padding = switch (context.breakpoint.layoutTypeFor(
          constraints.maxWidth,
        )) {
          AppLayoutType.compact => compactPadding,
          AppLayoutType.mobile => mobilePadding,
          AppLayoutType.tablet => tabletPadding,
          AppLayoutType.desktop || AppLayoutType.wide => desktopPadding,
        };
        return Padding(padding: padding ?? EdgeInsets.zero, child: child);
      },
    );
  }

  // MARK: - Flex layout helpers

  /// A [Row] (or [Wrap]) with token spacing; [spacing] defaults to `space.s4`.
  static Widget hStack({
    required List<Widget> children,
    double? spacing,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    WrapAlignment wrapAlignment = WrapAlignment.start,
    bool wrap = false,
  }) {
    return Builder(
      builder: (context) {
        final gap = spacing ?? context.space.s4;
        if (wrap) {
          return Wrap(
            spacing: gap,
            runSpacing: gap,
            alignment: wrapAlignment,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: children,
          );
        }
        return Row(
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          spacing: gap,
          children: children,
        );
      },
    );
  }

  /// A [Column] (or vertical [Wrap]) with token spacing; defaults to `space.s4`.
  static Widget vStack({
    required List<Widget> children,
    double? spacing,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
    bool wrap = false,
  }) {
    return Builder(
      builder: (context) {
        final gap = spacing ?? context.space.s4;
        if (wrap) {
          return Wrap(
            spacing: gap,
            runSpacing: gap,
            direction: Axis.vertical,
            children: children,
          );
        }
        return Column(
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          spacing: gap,
          children: children,
        );
      },
    );
  }

  // MARK: - Spacer utilities

  static Widget _gap({
    double Function(AppSpaceTokens)? w,
    double Function(AppSpaceTokens)? h,
  }) => Builder(
    builder: (context) =>
        SizedBox(width: w?.call(context.space), height: h?.call(context.space)),
  );

  /// Horizontal gap of `space.s2`.
  static Widget get width2 => _gap(w: (s) => s.s2);

  /// Horizontal gap of `space.s4`.
  static Widget get width4 => _gap(w: (s) => s.s4);

  /// Horizontal gap of `space.s6`.
  static Widget get width6 => _gap(w: (s) => s.s6);

  /// Vertical gap of `space.s2`.
  static Widget get height2 => _gap(h: (s) => s.s2);

  /// Vertical gap of `space.s4`.
  static Widget get height4 => _gap(h: (s) => s.s4);

  /// Vertical gap of `space.s6`.
  static Widget get height6 => _gap(h: (s) => s.s6);

  /// A divider in `color.border.base` with `space.s4` vertical extent.
  static Widget divider({Color? color, double? thickness}) {
    return Builder(
      builder: (context) => Divider(
        color: color ?? context.color.border.base,
        thickness: thickness ?? 1,
        height: context.space.s4,
      ),
    );
  }
}
