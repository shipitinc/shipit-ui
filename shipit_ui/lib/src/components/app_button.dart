import 'package:flutter/material.dart';
import 'package:shipit_ui/src/foundation/app_colors.dart';
import 'package:shipit_ui/src/foundation/app_spacing.dart';
import 'package:shipit_ui/src/foundation/app_radius.dart';
import 'package:shipit_ui/src/foundation/app_typography.dart';
import 'package:shipit_ui/src/foundation/app_motion.dart';

/// Button variant types for AppButton.
enum AppButtonVariant { primary, secondary, destructive, ghost }

/// Button size types for AppButton.
enum AppButtonSize { small, medium, large }

/// A reusable button widget following the shipit_ui design system.
///
/// Supports primary, secondary, destructive, and ghost variants.
/// Includes loading and disabled states.
///
/// ## Semantics
///
/// Uses [Semantics] with `button` label and `isButton: true` for
/// accessibility automation.
///
/// ## Provisional
///
/// Visual values are provisional until approved Penpot tokens are adopted.
class AppButton extends StatelessWidget {
  final String label;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final bool isLoading;
  final bool isDisabled;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Key? semanticLabel;

  const AppButton({
    super.key,
    required this.label,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isDisabled = false,
    this.onPressed,
    this.icon,
    this.semanticLabel,
  });

  factory AppButton.primary({
    required final String label,
    final VoidCallback? onPressed,
    final IconData? icon,
    final Key? semanticLabel,
    final bool isDisabled = false,
    final bool isLoading = false,
  }) {
    return AppButton(
      key: semanticLabel,
      label: label,
      onPressed: onPressed,
      icon: icon,
      semanticLabel: semanticLabel,
      isDisabled: isDisabled,
      isLoading: isLoading,
    );
  }

  factory AppButton.secondary({
    required final String label,
    final VoidCallback? onPressed,
    final IconData? icon,
    final Key? semanticLabel,
    final bool isDisabled = false,
    final bool isLoading = false,
  }) {
    return AppButton(
      key: semanticLabel,
      label: label,
      variant: AppButtonVariant.secondary,
      onPressed: onPressed,
      icon: icon,
      semanticLabel: semanticLabel,
      isDisabled: isDisabled,
      isLoading: isLoading,
    );
  }

  factory AppButton.destructive({
    required final String label,
    final VoidCallback? onPressed,
    final IconData? icon,
    final Key? semanticLabel,
    final bool isDisabled = false,
    final bool isLoading = false,
  }) {
    return AppButton(
      key: semanticLabel,
      label: label,
      variant: AppButtonVariant.destructive,
      onPressed: onPressed,
      icon: icon,
      semanticLabel: semanticLabel,
      isDisabled: isDisabled,
      isLoading: isLoading,
    );
  }

  factory AppButton.ghost({
    required final String label,
    final VoidCallback? onPressed,
    final IconData? icon,
    final Key? semanticLabel,
    final bool isDisabled = false,
    final bool isLoading = false,
  }) {
    return AppButton(
      key: semanticLabel,
      label: label,
      variant: AppButtonVariant.ghost,
      onPressed: onPressed,
      icon: icon,
      semanticLabel: semanticLabel,
      isDisabled: isDisabled,
      isLoading: isLoading,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = !isDisabled && !isLoading;

    Color backgroundColor;
    Color foregroundColor;
    BorderSide? borderSide;

    switch (variant) {
      case AppButtonVariant.primary:
        backgroundColor = isEnabled
            ? AppColors.actionPrimary
            : AppColors.neutral300;
        foregroundColor = AppColors.textOnPrimary;
        break;
      case AppButtonVariant.secondary:
        backgroundColor = isEnabled
            ? AppColors.neutral100
            : AppColors.neutral50;
        foregroundColor = isEnabled
            ? AppColors.actionPrimary
            : AppColors.textDisabled;
        borderSide = const BorderSide(color: AppColors.neutral300);
        break;
      case AppButtonVariant.destructive:
        backgroundColor = isEnabled
            ? AppColors.actionDestructive
            : AppColors.neutral300;
        foregroundColor = AppColors.textOnPrimary;
        break;
      case AppButtonVariant.ghost:
        backgroundColor = Colors.transparent;
        foregroundColor = isEnabled
            ? AppColors.actionPrimary
            : AppColors.textDisabled;
        break;
    }

    final padding = _getPadding(size);
    final minSize = _getMinSize(size);

    return Semantics(
      button: true,
      label: isLoading ? '$label, loading' : label,
      enabled: isEnabled,
      container: true,
      child: ConstrainedBox(
        key: semanticLabel,
        constraints: BoxConstraints(
          minWidth: minSize.toDouble(),
          minHeight: minSize.toDouble(),
        ),
        child: TextButton(
          onPressed: isEnabled ? onPressed : null,
          style: TextButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            disabledForegroundColor: foregroundColor.withValues(alpha: 0.5),
            padding: padding,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.radiusMd),
              side: borderSide ?? BorderSide.none,
            ),
            animationDuration: AppMotion.buttonPress,
          ),
          child: isLoading
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
          Icon(icon, size: _getIconSize()),
          const SizedBox(width: AppSpacing.spacingSm),
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
      width: _getIconSize(),
      height: _getIconSize(),
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
      ),
    );
  }

  double _getIconSize() {
    switch (size) {
      case AppButtonSize.small:
        return 16;
      case AppButtonSize.medium:
        return 18;
      case AppButtonSize.large:
        return 20;
    }
  }

  EdgeInsetsGeometry _getPadding(AppButtonSize size) {
    switch (size) {
      case AppButtonSize.small:
        return const EdgeInsets.symmetric(
          horizontal: AppSpacing.spacingSm,
          vertical: AppSpacing.spacingXs,
        );
      case AppButtonSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: AppSpacing.spacingMd,
          vertical: AppSpacing.spacingSm,
        );
      case AppButtonSize.large:
        return const EdgeInsets.symmetric(
          horizontal: AppSpacing.spacingLg,
          vertical: AppSpacing.spacingMd,
        );
    }
  }

  double _getMinSize(AppButtonSize size) {
    switch (size) {
      case AppButtonSize.small:
        return 32;
      case AppButtonSize.medium:
        return 40;
      case AppButtonSize.large:
        return 48;
    }
  }
}
