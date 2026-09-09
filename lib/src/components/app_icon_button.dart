import 'package:flutter/material.dart';
import 'package:shipit_ui/src/components/app_button.dart';
import 'package:shipit_ui/src/components/app_tooltip.dart';
import 'package:shipit_ui/src/theme/app_theme_tokens.dart';

/// An icon-only button following the shipit_ui design system.
///
/// Square button on the tap-target scale (44×44) for compact actions such as
/// a show/hide password toggle. Provide [tooltip] for an accessible label
/// and hover tooltip.
///
/// Follows [AppButton] conventions: the same [AppButtonState]s and the
/// `semanticLabel` automation key.
///
/// ## Semantics
///
/// Exposed as a button labelled with [tooltip] so it can be targeted by
/// automation and assistive technology.
class AppIconButton extends StatelessWidget {
  final IconData icon;
  final String? tooltip;
  final VoidCallback? onPressed;
  final AppButtonState state;
  final Key? semanticLabel;

  const AppIconButton({
    super.key,
    required this.icon,
    this.tooltip,
    this.onPressed,
    this.state = AppButtonState.base,
    this.semanticLabel,
  });

  /// Button size on the base scale; sized to the 44px tap target used by
  /// [AppButton].
  static const double buttonSize = 44;

  /// Leading icon size, matching [AppButton]'s inline icons.
  static const double iconSize = 18;

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    final isEnabled =
        state != AppButtonState.disabled && state != AppButtonState.loading;

    final Color fg = isEnabled ? color.fg.secondary : color.fg.disabled;

    final Widget button = Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: isEnabled ? onPressed : null,
        customBorder: const CircleBorder(),
        hoverColor: color.bg.subtle,
        highlightColor: color.bg.subtle,
        splashColor: color.bg.subtle,
        focusColor: color.bg.subtle,
        child: SizedBox(
          width: buttonSize,
          height: buttonSize,
          child: state == AppButtonState.loading
              ? _buildLoadingIndicator(fg)
              : Icon(icon, size: iconSize, color: fg),
        ),
      ),
    );

    final Widget semantics = Semantics(
      key: semanticLabel,
      button: true,
      enabled: isEnabled,
      label: tooltip,
      container: true,
      child: button,
    );

    if (tooltip == null) {
      return semantics;
    }
    return AppTooltip(
      message: tooltip!,
      excludeFromSemantics: true,
      child: semantics,
    );
  }

  Widget _buildLoadingIndicator(Color foregroundColor) {
    return SizedBox(
      width: iconSize,
      height: iconSize,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
      ),
    );
  }
}
