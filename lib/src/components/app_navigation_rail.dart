import 'package:flutter/material.dart';
import 'package:shipit_ui/src/components/app_tooltip.dart';
import 'package:shipit_ui/src/foundation/app_breakpoints.dart';
import 'package:shipit_ui/src/foundation/app_colors.dart';
import 'package:shipit_ui/src/foundation/app_motion.dart';
import 'package:shipit_ui/src/foundation/app_radius.dart';
import 'package:shipit_ui/src/foundation/app_spacing.dart';
import 'package:shipit_ui/src/foundation/app_typography.dart';

/// A single destination in an [AppNavigationRail].
class AppNavigationRailItem {
  final IconData icon;
  final IconData? selectedIcon;
  final String label;
  final Key? semanticLabel;

  const AppNavigationRailItem({
    required this.icon,
    required this.label,
    this.selectedIcon,
    this.semanticLabel,
  });
}

/// A reusable, cross-product navigation rail following the shipit_ui
/// design system.
///
/// Intended for tablet and desktop layouts. Shows icon + label per
/// destination when [extended] is true and collapses to icon-only (with
/// [AppTooltip] labels) when false. When [extended] is null the rail
/// collapses automatically below [AppBreakpoints.desktop].
///
/// Based on approved Penpot design tokens.
///
/// ## Semantics
///
/// Each destination is exposed as a selectable button with its label so it
/// can be targeted by automation and assistive technology.
class AppNavigationRail extends StatelessWidget {
  final List<AppNavigationRailItem> items;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final bool? extended;
  final Widget? leading;
  final Widget? trailing;
  final Key? semanticLabel;

  const AppNavigationRail({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onDestinationSelected,
    this.extended,
    this.leading,
    this.trailing,
    this.semanticLabel,
  }) : assert(items.length >= 2, 'AppNavigationRail requires at least 2 items');

  static const double collapsedWidth = 72;
  static const double extendedWidth = 240;

  @override
  Widget build(BuildContext context) {
    final bool isExtended = extended ?? AppBreakpoints.isDesktop(context);

    return Semantics(
      key: semanticLabel,
      container: true,
      label: 'Navigation',
      child: AnimatedContainer(
        duration: AppMotion.normal,
        curve: AppMotion.curveStandard,
        width: isExtended ? extendedWidth : collapsedWidth,
        decoration: const BoxDecoration(
          color: AppColors.bgSurfaceColor,
          border: Border(
            right: BorderSide(color: AppColors.borderDefaultColor),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (leading != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.space3,
                  AppSpacing.space4,
                  AppSpacing.space3,
                  AppSpacing.space2,
                ),
                child: leading,
              ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.space3,
                  vertical: AppSpacing.space2,
                ),
                children: [
                  for (var i = 0; i < items.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.space1),
                      child: _AppNavigationRailDestination(
                        item: items[i],
                        selected: i == selectedIndex,
                        extended: isExtended,
                        onTap: () => onDestinationSelected(i),
                      ),
                    ),
                ],
              ),
            ),
            if (trailing != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.space3,
                  AppSpacing.space2,
                  AppSpacing.space3,
                  AppSpacing.space4,
                ),
                child: trailing,
              ),
          ],
        ),
      ),
    );
  }
}

class _AppNavigationRailDestination extends StatelessWidget {
  final AppNavigationRailItem item;
  final bool selected;
  final bool extended;
  final VoidCallback onTap;

  const _AppNavigationRailDestination({
    required this.item,
    required this.selected,
    required this.extended,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color fg = selected
        ? AppColors.navSelectedFgColor
        : AppColors.navUnselectedFgColor;
    final Color bg = selected
        ? AppColors.navSelectedBgColor
        : AppColors.bgSurfaceColor;

    final Widget icon = Icon(
      selected ? (item.selectedIcon ?? item.icon) : item.icon,
      size: AppSpacing.space6,
      color: fg,
    );

    Widget content = AnimatedContainer(
      duration: AppMotion.fast,
      curve: AppMotion.curveStandard,
      height: AppSpacing.space12,
      padding: EdgeInsets.symmetric(
        horizontal: extended ? AppSpacing.space3 : AppSpacing.space0,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: AppRadius.borderRadiusMd,
      ),
      child: extended
          ? Row(
              children: [
                icon,
                const SizedBox(width: AppSpacing.space3),
                Expanded(
                  child: ExcludeSemantics(
                    child: Text(
                      item.label,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.labelLarge.copyWith(
                        color: fg,
                        fontWeight: selected
                            ? AppTypography.fontWeightSemibold
                            : AppTypography.fontWeightMedium,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Center(child: icon),
    );

    if (!extended) {
      content = AppTooltip(
        message: item.label,
        preferBelow: false,
        excludeFromSemantics: true,
        child: content,
      );
    }

    return Semantics(
      key: item.semanticLabel,
      button: true,
      selected: selected,
      label: item.label,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppRadius.borderRadiusMd,
          hoverColor: AppColors.bgSubtleColor,
          child: content,
        ),
      ),
    );
  }
}
