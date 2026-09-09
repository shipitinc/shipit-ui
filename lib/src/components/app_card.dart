import 'package:flutter/material.dart';
import 'package:shipit_ui/src/theme/app_theme_tokens.dart';

/// A reusable card widget following the shipit_ui design system.
///
/// Based on approved Penpot design tokens.
///
/// ## Semantics
///
/// Uses [Semantics] with `container: true` for accessibility automation.
class AppCard extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final List<Widget>? children;
  final Widget? child;
  final VoidCallback? onTap;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final Key? semanticLabel;

  const AppCard({
    super.key,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.children,
    this.child,
    this.onTap,
    this.color,
    this.padding,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.color;
    final space = context.space;
    final text = context.text;
    final card = Card(
      color: color ?? colors.bg.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: colors.border.base),
        borderRadius: context.radius.all.lg,
      ),
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: context.radius.all.lg,
        child: Padding(
          padding: padding ?? EdgeInsets.all(space.s4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null || leading != null) ...[
                Row(
                  children: [
                    if (leading != null) ...[
                      leading!,
                      SizedBox(width: space.s2),
                    ],
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (title != null)
                            Text(
                              title!,
                              style: text.headline.medium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          if (subtitle != null && title != null)
                            Text(
                              subtitle!,
                              style: text.body.small,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    ),
                    ?trailing,
                  ],
                ),
                if (subtitle != null && title == null) ...[
                  Text(subtitle!, style: text.body.small),
                ],
                if (children != null || child != null) ...[
                  SizedBox(height: space.s2),
                  ?child,
                  ...?children,
                ],
              ] else if (children != null || child != null) ...[
                ?child,
                ...?children,
              ],
            ],
          ),
        ),
      ),
    );

    return Semantics(container: true, label: title ?? 'Card', child: card);
  }
}
