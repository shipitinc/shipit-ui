import 'package:flutter/material.dart';
import 'package:shipit_ui/src/theme/app_theme_tokens.dart';

/// A token-styled tooltip following the shipit_ui design system.
///
/// Wraps Material [Tooltip] so consumers get hover, long-press, focus and
/// screen-reader behaviour for free, while enforcing shipit_ui colors,
/// typography, radius, spacing and elevation.
///
/// Use [AppTooltip] for plain text and [AppTooltip.rich] for inline-styled
/// content via [InlineSpan].
///
/// ## Semantics
///
/// The tooltip message is exposed to assistive technology via the underlying
/// [Tooltip]. Pass [excludeFromSemantics] when the child already exposes an
/// equivalent label.
class AppTooltip extends StatelessWidget {
  final String? message;
  final InlineSpan? richMessage;
  final Widget child;
  final bool preferBelow;
  final Duration? waitDuration;
  final Duration? showDuration;
  final bool excludeFromSemantics;
  final Key? semanticLabel;

  const AppTooltip({
    super.key,
    required String this.message,
    required this.child,
    this.preferBelow = true,
    this.waitDuration,
    this.showDuration,
    this.excludeFromSemantics = false,
    this.semanticLabel,
  }) : richMessage = null;

  const AppTooltip.rich({
    super.key,
    required InlineSpan this.richMessage,
    required this.child,
    this.preferBelow = true,
    this.waitDuration,
    this.showDuration,
    this.excludeFromSemantics = false,
    this.semanticLabel,
  }) : message = null;

  static const Duration _defaultWait = Duration(milliseconds: 500);
  static const Duration _defaultShow = Duration(milliseconds: 1500);

  @override
  Widget build(BuildContext context) {
    final space = context.space;
    return Tooltip(
      key: semanticLabel,
      message: message,
      richMessage: richMessage,
      preferBelow: preferBelow,
      verticalOffset: space.s6,
      waitDuration: waitDuration ?? _defaultWait,
      showDuration: showDuration ?? _defaultShow,
      excludeFromSemantics: excludeFromSemantics,
      exitDuration: context.motion.duration.fast,
      padding: EdgeInsets.symmetric(horizontal: space.s3, vertical: space.s2),
      margin: EdgeInsets.symmetric(horizontal: space.s4),
      decoration: BoxDecoration(
        color: context.color.tooltip.bg,
        borderRadius: context.radius.all.md,
        boxShadow: context.elevation.e2,
      ),
      textStyle: context.text.label.medium.copyWith(
        color: context.color.tooltip.fg,
      ),
      textAlign: TextAlign.center,
      child: child,
    );
  }
}
