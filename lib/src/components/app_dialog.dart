import 'package:flutter/material.dart';
import 'package:shipit_ui/src/components/app_button.dart';
import 'package:shipit_ui/src/theme/app_theme_tokens.dart';

/// A reusable dialog widget following the shipit_ui design system.
///
/// Based on approved Penpot design tokens.
///
/// ## Semantics
///
/// Uses [Semantics] with `label` for accessibility automation.
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
        AppButton.secondary(label: 'Cancel', onPressed: onCancel ?? () {}),
        AppButton.primary(label: confirmLabel, onPressed: onConfirm),
      ],
      semanticLabel: semanticLabel,
    );
  }

  @override
  Widget build(BuildContext context) {
    final space = context.space;
    final text = context.text;
    return Dialog(
      key: semanticLabel,
      backgroundColor: context.color.bg.surface,
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
                  Text(title, style: text.headline.medium),
                  if (subtitle != null)
                    Padding(
                      padding: EdgeInsets.only(top: space.s1),
                      child: Text(
                        subtitle!,
                        style: text.body.medium.copyWith(
                          color: context.color.fg.secondary,
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
            if (actions != null && actions!.isNotEmpty)
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
                  children: actions!,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
