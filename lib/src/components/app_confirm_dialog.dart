import 'package:flutter/material.dart';
import 'package:shipit_ui/src/components/app_button.dart';
import 'package:shipit_ui/src/theme/app_theme_tokens.dart';

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
    final space = context.space;
    final color = context.color;
    return Dialog(
      key: semanticLabel,
      backgroundColor: color.bg.surface,
      shape: RoundedRectangleBorder(borderRadius: context.radius.all.xl),
      elevation: 0,
      insetPadding: EdgeInsets.symmetric(
        horizontal: space.s4,
        vertical: space.s4,
      ),
      child: Semantics(
        label: title,
        container: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                space.s6,
                space.s5,
                space.s6,
                space.s2,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isDestructive)
                    Padding(
                      padding: EdgeInsets.only(bottom: space.s4),
                      child: _buildWarningIcon(context),
                    ),
                  Text(title, style: context.text.headline.medium),
                  if (message != null)
                    Padding(
                      padding: EdgeInsets.only(top: space.s1),
                      child: Text(
                        message!,
                        style: context.text.body.medium.copyWith(
                          color: color.fg.secondary,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            if (content != null)
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: space.s6,
                  vertical: space.s3,
                ),
                child: content!,
              ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                space.s6,
                space.s3,
                space.s6,
                space.s5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: space.s2,
                children: [
                  AppButton.secondary(
                    label: cancelLabel,
                    semanticLabel: cancelKey,
                    onPressed: onCancel,
                  ),
                  AppButton.primary(
                    label: confirmLabel,
                    semanticLabel: confirmKey,
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

  Widget _buildWarningIcon(BuildContext context) {
    final space = context.space;
    final error = context.color.state.error;
    return Container(
      width: space.s10,
      height: space.s10,
      decoration: BoxDecoration(color: error.bg, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Icon(Icons.warning_amber_rounded, color: error.fg, size: space.s6),
    );
  }
}
