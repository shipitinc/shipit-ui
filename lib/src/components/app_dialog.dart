import 'package:flutter/material.dart';
import 'package:shipit_ui/src/foundation/app_colors.dart';
import 'package:shipit_ui/src/foundation/app_spacing.dart';
import 'package:shipit_ui/src/foundation/app_radius.dart';
import 'package:shipit_ui/src/foundation/app_typography.dart';
import 'package:shipit_ui/src/components/app_button.dart';

/// A reusable dialog widget following the shipit_ui design system.
///
/// ## Semantics
///
/// Uses [Semantics] with `label` for accessibility automation.
///
/// ## Provisional
///
/// Visual values are provisional until approved Penpot tokens are adopted.
class AppDialog extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? content;
  final List<Widget>? actions;
  final bool barrierDismissible;
  final Key? semanticLabel;

  const AppDialog({
    super.key,
    required this.title,
    this.subtitle,
    this.content,
    this.actions,
    this.barrierDismissible = true,
    this.semanticLabel,
  });

  factory AppDialog.error({
    required String title,
    String? subtitle,
    Widget? content,
    required VoidCallback onConfirm,
    String confirmLabel = 'Delete',
    VoidCallback? onCancel,
    Key? semanticLabel,
  }) {
    return AppDialog(
      key: semanticLabel,
      title: title,
      subtitle: subtitle,
      content: content,
      barrierDismissible: false,
      actions: [
        AppButton.ghost(label: 'Cancel', onPressed: onCancel ?? () {}),
        AppButton.destructive(label: confirmLabel, onPressed: onConfirm),
      ],
      semanticLabel: semanticLabel,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      key: semanticLabel,
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.radiusXl),
        side: const BorderSide(color: AppColors.divider),
      ),
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.spacingMd,
        vertical: AppSpacing.spacingMd,
      ),
      child: Semantics(
        label: title,
        container: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.spacingXl,
                AppSpacing.spacingLg,
                AppSpacing.spacingXl,
                AppSpacing.spacingXs,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.headlineMedium),
                  if (subtitle != null)
                    Padding(
                      padding: const EdgeInsets.only(top: AppSpacing.spacingXs),
                      child: Text(
                        subtitle!,
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            if (content != null)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.spacingXl,
                  vertical: AppSpacing.spacingSm,
                ),
                child: content!,
              ),
            if (actions != null && actions!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.spacingXl,
                  AppSpacing.spacingSm,
                  AppSpacing.spacingXl,
                  AppSpacing.spacingLg,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  spacing: AppSpacing.spacingSm,
                  children: actions!,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
