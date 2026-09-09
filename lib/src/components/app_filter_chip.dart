import 'package:flutter/material.dart';
import 'package:shipit_ui/src/theme/app_theme_tokens.dart';

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

  /// Chip height (`space.s8`) on the base scale; the widget itself reads
  /// `context.space.s8` so a themed spacing scale is honoured.
  static final double height = AppSpaceTokens.base.s8;

  @override
  Widget build(BuildContext context) {
    final chip = context.color.chip;
    final space = context.space;
    final Color fg = selected ? chip.selected.fg : chip.fg;
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
          borderRadius: context.radius.all.full,
          hoverColor: context.color.bg.subtle,
          child: AnimatedContainer(
            duration: context.motion.duration.fast,
            curve: context.motion.curve.standard,
            height: space.s8,
            padding: EdgeInsets.symmetric(horizontal: space.s3),
            decoration: BoxDecoration(
              color: selected ? chip.selected.bg : chip.bg,
              borderRadius: context.radius.all.full,
              border: Border.all(
                color: selected ? chip.selected.border : chip.border,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (leading != null) ...[
                  Icon(leading, size: space.s4, color: fg),
                  SizedBox(width: space.s1),
                ],
                ExcludeSemantics(
                  child: Text(
                    label,
                    style: context.text.label.medium.copyWith(
                      color: fg,
                      fontWeight: selected
                          ? context.font.weight.semibold
                          : context.font.weight.medium,
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
