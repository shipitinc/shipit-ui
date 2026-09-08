import 'package:flutter/material.dart';
import 'package:shipit_ui/src/components/app_button.dart';
import 'package:shipit_ui/src/foundation/app_colors.dart';
import 'package:shipit_ui/src/foundation/app_spacing.dart';
import 'package:shipit_ui/src/foundation/app_typography.dart';

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
    return Center(
      child: Semantics(
        key: semanticLabel,
        container: true,
        label: '$title. ${message ?? "No content available."}',
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.space8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: AppSpacing.space12,
                height: AppSpacing.space12,
                decoration: const BoxDecoration(
                  color: AppColors.bgSubtleColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: AppSpacing.space6,
                  color: AppColors.fgMutedColor,
                ),
              ),
              const SizedBox(height: AppSpacing.space4),
              ExcludeSemantics(
                child: Text(
                  title,
                  style: AppTypography.headlineSmall,
                  textAlign: TextAlign.center,
                ),
              ),
              if (message != null) ...[
                const SizedBox(height: AppSpacing.space1),
                ExcludeSemantics(
                  child: Text(
                    message!,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.fgSecondaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
              if (onAction != null && actionLabel != null) ...[
                const SizedBox(height: AppSpacing.space4),
                AppButton.secondary(label: actionLabel!, onPressed: onAction!),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
