import 'package:flutter/material.dart';
import 'package:shipit_ui/src/theme/app_theme_tokens.dart';

/// A single destination in an [AppBottomNavigationBar].
class AppBottomNavigationItem {
  final IconData icon;
  final IconData? selectedIcon;
  final String label;
  final Key? semanticLabel;

  const AppBottomNavigationItem({
    required this.icon,
    required this.label,
    this.selectedIcon,
    this.semanticLabel,
  });
}

/// A mobile/compact navigation bar following the shipit_ui design system.
///
/// Companion to [AppNavigationRail] for narrow layouts: distributes up to five
/// destinations across the bottom of the screen and is intended to be placed
/// in a `Scaffold.bottomNavigationBar` (e.g. as the shell of a
/// `StatefulShellRoute.indexedStack`).
///
/// The active destination shows the same pill indicator as the rail
/// (`color.nav.selected.bg` behind the icon, `radius.md`, filled `selectedIcon`
/// and a `semibold` label) so navigation reads identically whichever primitive
/// hosts it. Every destination exposes a tap target of at least 44 px.
///
/// ## Semantics
///
/// Each destination is exposed as a selectable button with its label so it
/// can be targeted by automation and assistive technology.
class AppBottomNavigationBar extends StatelessWidget {
  final List<AppBottomNavigationItem> items;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final Key? semanticLabel;

  const AppBottomNavigationBar({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onDestinationSelected,
    this.semanticLabel,
  }) : assert(
         items.length >= 2,
         'AppBottomNavigationBar requires at least 2 items',
       );

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    final space = context.space;

    return Semantics(
      key: semanticLabel,
      container: true,
      label: 'Navigation',
      child: Material(
        color: color.bg.surface,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: color.border.base)),
          ),
          child: SafeArea(
            top: false,
            child: SizedBox(
              height: space.s16,
              child: Row(
                children: [
                  for (var i = 0; i < items.length; i++)
                    Expanded(
                      child: _AppBottomNavigationDestination(
                        item: items[i],
                        selected: i == selectedIndex,
                        onTap: () => onDestinationSelected(i),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AppBottomNavigationDestination extends StatelessWidget {
  final AppBottomNavigationItem item;
  final bool selected;
  final VoidCallback onTap;

  const _AppBottomNavigationDestination({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    final space = context.space;
    final Color fg = selected ? color.nav.selected.fg : color.nav.unselected.fg;

    return Semantics(
      key: item.semanticLabel,
      button: true,
      selected: selected,
      label: item.label,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          hoverColor: color.bg.subtle,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: context.motion.duration.fast,
                curve: context.motion.curve.standard,
                padding: EdgeInsets.symmetric(
                  horizontal: space.s3,
                  vertical: space.s2,
                ),
                decoration: BoxDecoration(
                  color: selected ? color.nav.selected.bg : Colors.transparent,
                  borderRadius: context.radius.all.md,
                ),
                child: Icon(
                  selected ? (item.selectedIcon ?? item.icon) : item.icon,
                  size: context.icon.size.lg,
                  color: fg,
                ),
              ),
              SizedBox(height: space.s1),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: space.s2),
                child: ExcludeSemantics(
                  child: Text(
                    item.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.text.label.small.copyWith(
                      color: fg,
                      fontWeight: selected
                          ? context.font.weight.semibold
                          : context.font.weight.medium,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
