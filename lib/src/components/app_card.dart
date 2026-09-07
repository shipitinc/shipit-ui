import 'package:flutter/material.dart';
import 'package:shipit_ui/src/foundation/app_colors.dart';
import 'package:shipit_ui/src/foundation/app_spacing.dart';
import 'package:shipit_ui/src/foundation/app_radius.dart';
import 'package:shipit_ui/src/foundation/app_typography.dart';

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
    final card = Card(
      color: color ?? AppColors.bgSurfaceColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: AppColors.borderDefaultColor),
        borderRadius: BorderRadius.circular(AppRadius.radiusLg),
      ),
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.radiusLg),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(AppSpacing.space4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null || leading != null) ...[
                Row(
                  children: [
                    if (leading != null) ...[
                      leading!,
                      const SizedBox(width: AppSpacing.space2),
                    ],
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (title != null)
                            Text(
                              title!,
                              style: AppTypography.headlineMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          if (subtitle != null && title != null)
                            Text(
                              subtitle!,
                              style: AppTypography.bodySmall,
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
                  Text(subtitle!, style: AppTypography.bodySmall),
                ],
                if (children != null || child != null) ...[
                  const SizedBox(height: AppSpacing.space2),
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