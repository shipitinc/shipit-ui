import 'package:flutter/material.dart';
import 'package:shipit_ui/src/foundation/app_colors.dart';
import 'package:shipit_ui/src/foundation/app_elevation.dart';
import 'package:shipit_ui/src/foundation/app_motion.dart';
import 'package:shipit_ui/src/foundation/app_radius.dart';
import 'package:shipit_ui/src/foundation/app_spacing.dart';
import 'package:shipit_ui/src/foundation/app_typography.dart';

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
    return Tooltip(
      key: semanticLabel,
      message: message,
      richMessage: richMessage,
      preferBelow: preferBelow,
      verticalOffset: AppSpacing.space6,
      waitDuration: waitDuration ?? _defaultWait,
      showDuration: showDuration ?? _defaultShow,
      excludeFromSemantics: excludeFromSemantics,
      exitDuration: AppMotion.fast,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space3,
        vertical: AppSpacing.space2,
      ),
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.space4),
      decoration: const BoxDecoration(
        color: AppColors.tooltipBgColor,
        borderRadius: AppRadius.borderRadiusMd,
        boxShadow: AppElevation.elevation2,
      ),
      textStyle: AppTypography.labelMedium.copyWith(
        color: AppColors.tooltipFgColor,
      ),
      textAlign: TextAlign.center,
      child: child,
    );
  }
}
