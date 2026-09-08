import 'package:flutter/material.dart';
import 'package:shipit_ui/src/components/app_button.dart';
import 'package:shipit_ui/src/foundation/app_colors.dart';
import 'package:shipit_ui/src/foundation/app_radius.dart';
import 'package:shipit_ui/src/foundation/app_spacing.dart';
import 'package:shipit_ui/src/foundation/app_typography.dart';

/// A confirmation dialog following the shipit_ui design system.
///
/// Presents a title, optional message and content, plus cancel and confirm
/// actions. Mirrors the surface, radius and spacing of `AppDialog`. Use
/// [AppConfirmDialog.destructive] for irreversible actions: it adds a leading
/// warning icon and disables barrier dismissal.
///
/// Based on approved Penpot design tokens.
///
/// ## Semantics
///
/// Uses [Semantics] with `label` set to [title] and `container: true`. The
/// action buttons expose deterministic keys `confirm_dialog_cancel` and
/// `confirm_dialog_confirm` for automation.
class AppConfirmDialog extends StatelessWidget {
  static const Key cancelKey = Key('confirm_dialog_cancel');
  static const Key confirmKey = Key('confirm_dialog_confirm');

  final String title;
  final String? message;
  final Widget? content;
  final String confirmLabel;
  final String cancelLabel;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool isDestructive;
  final Key? semanticLabel;

  const AppConfirmDialog({
    super.key,
    required this.title,
    this.message,
    this.content,
    this.confirmLabel = 'OK',
    this.cancelLabel = 'Cancel',
    this.onConfirm,
    this.onCancel,
    this.isDestructive = false,
    this.semanticLabel,
  });

  const AppConfirmDialog.destructive({
    super.key,
    required this.title,
    this.message,
    this.content,
    this.confirmLabel = 'Delete',
    this.cancelLabel = 'Cancel',
    this.onConfirm,
    this.onCancel,
    this.semanticLabel,
  }) : isDestructive = true;

  /// Shows the dialog and resolves `true` on confirm, `false` on cancel or
  /// barrier dismissal. Destructive dialogs are not barrier-dismissible.
  static Future<bool> show(
    BuildContext context, {
    required String title,
    String? message,
    Widget? content,
    String confirmLabel = 'OK',
    String cancelLabel = 'Cancel',
    bool isDestructive = false,
    Key? semanticLabel,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: !isDestructive,
      builder: (dialogContext) => AppConfirmDialog(
        title: title,
        message: message,
        content: content,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        isDestructive: isDestructive,
        semanticLabel: semanticLabel,
        onConfirm: () => Navigator.of(dialogContext).pop(true),
        onCancel: () => Navigator.of(dialogContext).pop(false),
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      key: semanticLabel,
      backgroundColor: AppColors.bgSurfaceColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.radiusXl),
      ),
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space4,
        vertical: AppSpacing.space4,
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
                AppSpacing.space6,
                AppSpacing.space5,
                AppSpacing.space6,
                AppSpacing.space2,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isDestructive)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.space4),
                      child: _buildWarningIcon(),
                    ),
                  Text(title, style: AppTypography.headlineMedium),
                  if (message != null)
                    Padding(
                      padding: const EdgeInsets.only(top: AppSpacing.space1),
                      child: Text(
                        message!,
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.fgSecondaryColor,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            if (content != null)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.space6,
                  vertical: AppSpacing.space3,
                ),
                child: content!,
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.space6,
                AppSpacing.space3,
                AppSpacing.space6,
                AppSpacing.space5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: AppSpacing.space2,
                children: [
                  AppButton(
                    key: cancelKey,
                    label: cancelLabel,
                    variant: AppButtonVariant.secondary,
                    onPressed: onCancel,
                  ),
                  AppButton(
                    key: confirmKey,
                    label: confirmLabel,
                    onPressed: onConfirm,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWarningIcon() {
    return Container(
      width: AppSpacing.space10,
      height: AppSpacing.space10,
      decoration: const BoxDecoration(
        color: AppColors.stateErrorBgColor,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: const Icon(
        Icons.warning_amber_rounded,
        color: AppColors.stateErrorFgColor,
        size: AppSpacing.space6,
      ),
    );
  }
}
