import 'package:flutter/material.dart';
import 'package:shipit_ui/src/foundation/app_colors.dart';
import 'package:shipit_ui/src/foundation/app_spacing.dart';
import 'package:shipit_ui/src/foundation/app_radius.dart';
import 'package:shipit_ui/src/foundation/app_typography.dart';
import 'package:shipit_ui/src/foundation/app_motion.dart';

/// Button variant types for AppButton.
enum AppButtonVariant { primary, secondary }

/// Button state types for AppButton.
enum AppButtonState { default_, disabled, loading }

/// A reusable button widget following the shipit_ui design system.
///
/// Supports primary and secondary variants with default, disabled, and loading states.
/// Based on approved Penpot design tokens.
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
    this.state = AppButtonState.default_,
    this.onPressed,
    this.icon,
    this.semanticLabel,
  });

  factory AppButton.primary({
    required final String label,
    final VoidCallback? onPressed,
    final IconData? icon,
    final Key? semanticLabel,
    final AppButtonState state = AppButtonState.default_,
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
    final AppButtonState state = AppButtonState.default_,
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
    final isEnabled =
        state != AppButtonState.disabled && state != AppButtonState.loading;

    Color backgroundColor;
    Color foregroundColor;
    BorderSide? borderSide;

    switch (variant) {
      case AppButtonVariant.primary:
        switch (state) {
          case AppButtonState.default_:
            backgroundColor = AppColors.actionPrimaryBgColor;
            foregroundColor = AppColors.actionPrimaryFgColor;
            break;
          case AppButtonState.disabled:
            backgroundColor = AppColors.actionDisabledBgColor;
            foregroundColor = AppColors.actionDisabledFgColor;
            break;
          case AppButtonState.loading:
            backgroundColor = AppColors.actionPrimaryBgColor;
            foregroundColor = AppColors.actionPrimaryFgColor;
            break;
        }
        break;
      case AppButtonVariant.secondary:
        switch (state) {
          case AppButtonState.default_:
            backgroundColor = AppColors.actionSecondaryBgColor;
            foregroundColor = AppColors.actionSecondaryFgColor;
            borderSide = const BorderSide(
              color: AppColors.actionSecondaryBorderColor,
            );
            break;
          case AppButtonState.disabled:
            backgroundColor = AppColors.actionDisabledBgColor;
            foregroundColor = AppColors.actionDisabledFgColor;
            borderSide = const BorderSide(
              color: AppColors.actionDisabledBorderColor,
            );
            break;
          case AppButtonState.loading:
            backgroundColor = AppColors.actionSecondaryBgColor;
            foregroundColor = AppColors.actionSecondaryFgColor;
            borderSide = const BorderSide(
              color: AppColors.actionSecondaryBorderColor,
            );
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
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.space4,
              vertical: AppSpacing.space2,
            ),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.radiusMd),
              side: borderSide ?? BorderSide.none,
            ),
            animationDuration: AppMotion.buttonPress,
          ),
          child: state == AppButtonState.loading
              ? _buildLoadingIndicator(foregroundColor)
              : _buildContent(foregroundColor),
        ),
      ),
    );
  }

  Widget _buildContent(Color foregroundColor) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 18),
          const SizedBox(width: AppSpacing.space2),
        ],
        Text(
          label,
          style: AppTypography.labelLarge.copyWith(color: foregroundColor),
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
