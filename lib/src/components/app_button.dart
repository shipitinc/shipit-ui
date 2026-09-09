import 'package:flutter/material.dart';
import 'package:shipit_ui/src/theme/app_theme_tokens.dart';

/// Button variant types for AppButton.
enum AppButtonVariant { primary, secondary }

/// Button state types for AppButton.
enum AppButtonState { base, disabled, loading }

/// A reusable button widget following the shipit_ui design system.
///
/// Supports primary and secondary variants with base, disabled, and loading
/// states. Based on approved Penpot design tokens.
///
/// ## Semantics
///
/// Uses [Semantics] with `button` label and `isButton: true` for
/// accessibility automation.
class AppButton extends StatelessWidget {
  final String label;
  final AppButtonVariant variant;
  final AppButtonState state;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Key? semanticLabel;

  const AppButton({
    super.key,
    required this.label,
    this.variant = AppButtonVariant.primary,
    this.state = AppButtonState.base,
    this.onPressed,
    this.icon,
    this.semanticLabel,
  });

  factory AppButton.primary({
    required final String label,
    final VoidCallback? onPressed,
    final IconData? icon,
    final Key? semanticLabel,
    final AppButtonState state = AppButtonState.base,
  }) {
    return AppButton(
      label: label,
      onPressed: onPressed,
      icon: icon,
      semanticLabel: semanticLabel,
      state: state,
    );
  }

  factory AppButton.secondary({
    required final String label,
    final VoidCallback? onPressed,
    final IconData? icon,
    final Key? semanticLabel,
    final AppButtonState state = AppButtonState.base,
  }) {
    return AppButton(
      label: label,
      onPressed: onPressed,
      icon: icon,
      semanticLabel: semanticLabel,
      variant: AppButtonVariant.secondary,
      state: state,
    );
  }

  @override
  Widget build(BuildContext context) {
    final action = context.color.action;
    final isEnabled =
        state != AppButtonState.disabled && state != AppButtonState.loading;

    Color backgroundColor;
    Color foregroundColor;
    BorderSide? borderSide;

    switch (variant) {
      case AppButtonVariant.primary:
        switch (state) {
          case AppButtonState.base:
          case AppButtonState.loading:
            backgroundColor = action.primary.bg;
            foregroundColor = action.primary.fg;
            break;
          case AppButtonState.disabled:
            backgroundColor = action.disabled.bg;
            foregroundColor = action.disabled.fg;
            break;
        }
        break;
      case AppButtonVariant.secondary:
        switch (state) {
          case AppButtonState.base:
          case AppButtonState.loading:
            backgroundColor = action.secondary.bg;
            foregroundColor = action.secondary.fg;
            borderSide = BorderSide(color: action.secondary.border);
            break;
          case AppButtonState.disabled:
            backgroundColor = action.disabled.bg;
            foregroundColor = action.disabled.fg;
            borderSide = BorderSide(color: action.disabled.border);
            break;
        }
        break;
    }

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
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            disabledForegroundColor: foregroundColor.withValues(alpha: 0.5),
            padding: EdgeInsets.symmetric(
              horizontal: context.space.s4,
              vertical: context.space.s2,
            ),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: RoundedRectangleBorder(
              borderRadius: context.radius.all.md,
              side: borderSide ?? BorderSide.none,
            ),
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
          SizedBox(width: context.space.s2),
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
