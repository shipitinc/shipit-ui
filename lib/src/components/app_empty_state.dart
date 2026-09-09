import 'package:flutter/material.dart';
import 'package:shipit_ui/src/components/app_button.dart';
import 'package:shipit_ui/src/theme/app_theme_tokens.dart';

/// An empty-state view following the shipit_ui design system.
///
/// This is the only state that *replaces* a content area. Loading states use
/// `AppSkeleton` / `AppShimmer` silhouettes in place of the content, and
/// errors are surfaced with `AppInlineAlert` or a dialog on top of it.
///
/// Based on approved Penpot design tokens.
///
/// ## Semantics
///
/// Uses [Semantics] with a combined `title. message` label for accessibility
/// automation.
class AppEmptyState extends StatelessWidget {
  final String title;
  final String? message;
  final IconData icon;
  final VoidCallback? onAction;
  final String? actionLabel;
  final Key? semanticLabel;

  const AppEmptyState({
    super.key,
    required this.title,
    this.message,
    this.icon = Icons.inbox,
    this.onAction,
    this.actionLabel,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    final space = context.space;
    final color = context.color;
    return Center(
      child: Semantics(
        key: semanticLabel,
        container: true,
        label: '$title. ${message ?? "No content available."}',
        child: Padding(
          padding: EdgeInsets.all(space.s8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: space.s12,
                height: space.s12,
                decoration: BoxDecoration(
                  color: color.bg.subtle,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: space.s6, color: color.fg.muted),
              ),
              SizedBox(height: space.s4),
              ExcludeSemantics(
                child: Text(
                  title,
                  style: context.text.headline.small,
                  textAlign: TextAlign.center,
                ),
              ),
              if (message != null) ...[
                SizedBox(height: space.s1),
                ExcludeSemantics(
                  child: Text(
                    message!,
                    style: context.text.body.medium.copyWith(
                      color: color.fg.secondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
              if (onAction != null && actionLabel != null) ...[
                SizedBox(height: space.s4),
                AppButton.secondary(label: actionLabel!, onPressed: onAction!),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
