import 'package:flutter/material.dart';
import 'package:shipit_ui/src/components/app_button.dart';
import 'package:shipit_ui/src/theme/app_theme_tokens.dart';

/// A text/link-style button following the shipit_ui design system.
///
/// Borderless button that renders its label in the primary action colour,
/// for low-emphasis screens such as a "Forgot password?" link. Matches the
/// theme's `TextButton` defaults (`color.action.primary.bg`,
/// `context.text.label.large`) with a full-height tap target.
///
/// Follows [AppButton] conventions: the same [AppButtonState]s and the
/// `semanticLabel` automation key.
///
/// ## Semantics
///
/// Uses [Semantics] with `button` label and `isButton: true` for
/// accessibility automation.
class AppTextButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final AppButtonState state;
  final Key? semanticLabel;

  const AppTextButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.state = AppButtonState.base,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    final action = context.color.action;
    final isEnabled =
        state != AppButtonState.disabled && state != AppButtonState.loading;

    final Color foregroundColor = isEnabled
        ? action.primary.bg
        : action.disabled.fg;

    return Semantics(
      key: semanticLabel,
      button: true,
      label: state == AppButtonState.loading ? '$label, loading' : label,
      enabled: isEnabled,
      container: true,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 44),
        child: TextButton(
          onPressed: isEnabled ? onPressed : null,
          style: TextButton.styleFrom(
            foregroundColor: foregroundColor,
            disabledForegroundColor: action.disabled.fg,
            padding: EdgeInsets.symmetric(
              horizontal: context.space.s2,
              vertical: context.space.s2,
            ),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: const RoundedRectangleBorder(),
            overlayColor: isEnabled
                ? action.primary.bg.withValues(alpha: 0.08)
                : Colors.transparent,
            animationDuration: context.motion.duration.buttonPress,
          ),
          child: state == AppButtonState.loading
              ? _buildLoadingIndicator(foregroundColor)
              : _buildContent(context, foregroundColor),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, Color foregroundColor) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 18),
          SizedBox(width: context.space.s1),
        ],
        Text(
          label,
          style: context.text.label.large.copyWith(color: foregroundColor),
        ),
      ],
    );
  }

  Widget _buildLoadingIndicator(Color foregroundColor) {
    return SizedBox(
      width: 18,
      height: 18,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
      ),
    );
  }
}
