import 'package:flutter/material.dart';
import 'package:shipit_ui/src/foundation/app_colors.dart';
import 'package:shipit_ui/src/foundation/app_spacing.dart';
import 'package:shipit_ui/src/foundation/app_typography.dart';
import 'package:shipit_ui/src/components/app_button.dart';

/// A reusable empty state widget following the shipit_ui design system.
///
/// ## Semantics
///
/// Uses [Semantics] with `image` and `label` for accessibility automation.
///
/// ## Provisional
///
/// Visual values are provisional until approved Penpot tokens are adopted.
class AppEmptyState extends StatelessWidget {
  final String title;
  final String? message;
  final Widget? illustration;
  final VoidCallback? onAction;
  final String? actionLabel;
  final Key? semanticLabel;

  const AppEmptyState({
    super.key,
    required this.title,
    this.message,
    this.illustration,
    this.onAction,
    this.actionLabel,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Semantics(
        image: true,
        label: '$title. ${message ?? "No content available."}',
        container: true,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.spacingXxl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (illustration != null) ...[
                illustration!,
                const SizedBox(height: AppSpacing.spacingMd),
              ] else ...[
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: AppColors.neutral100,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.inbox,
                    size: 40,
                    color: AppColors.neutral400,
                  ),
                ),
                const SizedBox(height: AppSpacing.spacingMd),
              ],
              Text(
                title,
                style: AppTypography.headlineSmall,
                textAlign: TextAlign.center,
              ),
              if (message != null) ...[
                const SizedBox(height: AppSpacing.spacingXs),
                Text(
                  message!,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
              if (onAction != null && actionLabel != null) ...[
                const SizedBox(height: AppSpacing.spacingMd),
                AppButton.primary(label: actionLabel!, onPressed: onAction!),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
