import 'package:flutter/material.dart';
import 'package:shipit_ui/src/foundation/app_colors.dart';
import 'package:shipit_ui/src/foundation/app_motion.dart';
import 'package:shipit_ui/src/foundation/app_radius.dart';
import 'package:shipit_ui/src/foundation/app_spacing.dart';
import 'package:shipit_ui/src/foundation/app_typography.dart';

/// A compact, toggleable filter chip following the shipit_ui design system.
///
/// Renders as a pill with an optional leading [icon]. When [selected] the
/// chip shows a check mark, accent border/background and semibold label.
/// Based on approved Penpot design tokens.
///
/// ## Semantics
///
/// Exposed as a selectable button labelled with [label] so it can be
/// targeted by automation and assistive technology.
class AppFilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final ValueChanged<bool>? onSelected;
  final IconData? icon;
  final Key? semanticLabel;

  const AppFilterChip({
    super.key,
    required this.label,
    this.selected = false,
    this.onSelected,
    this.icon,
    this.semanticLabel,
  });

  static const double height = AppSpacing.space8;

  @override
  Widget build(BuildContext context) {
    final Color fg = selected
        ? AppColors.chipSelectedFgColor
        : AppColors.chipFgColor;
    final IconData? leading = selected ? Icons.check : icon;

    return Semantics(
      key: semanticLabel,
      button: true,
      selected: selected,
      enabled: onSelected != null,
      label: label,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onSelected == null ? null : () => onSelected!(!selected),
          borderRadius: AppRadius.borderRadiusFull,
          hoverColor: AppColors.bgSubtleColor,
          child: AnimatedContainer(
            duration: AppMotion.fast,
            curve: AppMotion.curveStandard,
            height: height,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space3),
            decoration: BoxDecoration(
              color: selected
                  ? AppColors.chipSelectedBgColor
                  : AppColors.chipBgColor,
              borderRadius: AppRadius.borderRadiusFull,
              border: Border.all(
                color: selected
                    ? AppColors.chipSelectedBorderColor
                    : AppColors.chipBorderColor,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (leading != null) ...[
                  Icon(leading, size: AppSpacing.space4, color: fg),
                  const SizedBox(width: AppSpacing.space1),
                ],
                ExcludeSemantics(
                  child: Text(
                    label,
                    style: AppTypography.labelMedium.copyWith(
                      color: fg,
                      fontWeight: selected
                          ? AppTypography.fontWeightSemibold
                          : AppTypography.fontWeightMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
