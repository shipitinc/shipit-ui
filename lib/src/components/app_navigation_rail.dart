import 'package:flutter/material.dart';
import 'package:shipit_ui/src/components/app_tooltip.dart';
import 'package:shipit_ui/src/theme/app_theme_tokens.dart';

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
/// collapses automatically below the desktop breakpoint
/// (`context.breakpoint.desktop`).
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
    final bool isExtended = extended ?? context.isDesktopOrLarger;
    final space = context.space;
    final color = context.color;

    return Semantics(
      key: semanticLabel,
      container: true,
      label: 'Navigation',
      child: AnimatedContainer(
        duration: context.motion.duration.normal,
        curve: context.motion.curve.standard,
        width: isExtended ? extendedWidth : collapsedWidth,
        decoration: BoxDecoration(
          color: color.bg.surface,
          border: Border(right: BorderSide(color: color.border.base)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (leading != null)
              Padding(
                padding: EdgeInsets.fromLTRB(
                  space.s3,
                  space.s4,
                  space.s3,
                  space.s2,
                ),
                child: leading,
              ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: space.s3,
                  vertical: space.s2,
                ),
                children: [
                  for (var i = 0; i < items.length; i++)
                    Padding(
                      padding: EdgeInsets.only(bottom: space.s1),
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
                padding: EdgeInsets.fromLTRB(
                  space.s3,
                  space.s2,
                  space.s3,
                  space.s4,
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
    final color = context.color;
    final space = context.space;
    final Color fg = selected ? color.nav.selected.fg : color.nav.unselected.fg;
    final Color bg = selected ? color.nav.selected.bg : color.bg.surface;

    final Widget icon = Icon(
      selected ? (item.selectedIcon ?? item.icon) : item.icon,
      size: space.s6,
      color: fg,
    );

    Widget content = AnimatedContainer(
      duration: context.motion.duration.fast,
      curve: context.motion.curve.standard,
      height: space.s12,
      padding: EdgeInsets.symmetric(horizontal: extended ? space.s3 : space.s0),
      decoration: BoxDecoration(color: bg, borderRadius: context.radius.all.md),
      child: extended
          ? Row(
              children: [
                icon,
                SizedBox(width: space.s3),
                Expanded(
                  child: ExcludeSemantics(
                    child: Text(
                      item.label,
                      overflow: TextOverflow.ellipsis,
                      style: context.text.label.large.copyWith(
                        color: fg,
                        fontWeight: selected
                            ? context.font.weight.semibold
                            : context.font.weight.medium,
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
          borderRadius: context.radius.all.md,
          hoverColor: color.bg.subtle,
          child: content,
        ),
      ),
    );
  }
}
