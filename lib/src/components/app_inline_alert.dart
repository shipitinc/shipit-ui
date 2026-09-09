import 'package:flutter/material.dart';
import 'package:shipit_ui/src/theme/app_theme_tokens.dart';

/// Severity of an [AppInlineAlert].
enum AppInlineAlertSeverity { error, warning, info, success }

/// A dismissible inline alert following the shipit_ui design system.
///
/// Surfaces errors and other feedback *next to* the affected content instead
/// of replacing it. Use [AppInlineAlert.error] for failed loads or actions
/// (optionally with a retry [actionLabel]); reserve dialogs for blocking
/// decisions.
///
/// Based on approved Penpot design tokens.
///
/// ## Semantics
///
/// Exposed as a live region labelled with the severity, title and message.
/// The dismiss control uses key `inline_alert_dismiss`.
class AppInlineAlert extends StatelessWidget {
  static const Key dismissKey = Key('inline_alert_dismiss');
  static const Key actionKey = Key('inline_alert_action');

  final AppInlineAlertSeverity severity;
  final String title;
  final String? message;
  final String? actionLabel;
  final VoidCallback? onAction;
  final VoidCallback? onDismiss;
  final Key? semanticLabel;

  const AppInlineAlert({
    super.key,
    required this.severity,
    required this.title,
    this.message,
    this.actionLabel,
    this.onAction,
    this.onDismiss,
    this.semanticLabel,
  });

  const AppInlineAlert.error({
    super.key,
    required this.title,
    this.message,
    this.actionLabel,
    this.onAction,
    this.onDismiss,
    this.semanticLabel,
  }) : severity = AppInlineAlertSeverity.error;

  const AppInlineAlert.warning({
    super.key,
    required this.title,
    this.message,
    this.actionLabel,
    this.onAction,
    this.onDismiss,
    this.semanticLabel,
  }) : severity = AppInlineAlertSeverity.warning;

  const AppInlineAlert.info({
    super.key,
    required this.title,
    this.message,
    this.actionLabel,
    this.onAction,
    this.onDismiss,
    this.semanticLabel,
  }) : severity = AppInlineAlertSeverity.info;

  const AppInlineAlert.success({
    super.key,
    required this.title,
    this.message,
    this.actionLabel,
    this.onAction,
    this.onDismiss,
    this.semanticLabel,
  }) : severity = AppInlineAlertSeverity.success;

  Color _fg(AppColorTokens color) => switch (severity) {
    AppInlineAlertSeverity.error => color.state.error.fg,
    AppInlineAlertSeverity.warning => color.state.warning.fg,
    AppInlineAlertSeverity.info => color.state.info.fg,
    AppInlineAlertSeverity.success => color.state.success.fg,
  };

  Color _bg(AppColorTokens color) => switch (severity) {
    AppInlineAlertSeverity.error => color.state.error.bg,
    AppInlineAlertSeverity.warning => color.state.warning.bg,
    AppInlineAlertSeverity.info => color.state.info.bg,
    AppInlineAlertSeverity.success => color.state.success.bg,
  };

  IconData get _icon => switch (severity) {
    AppInlineAlertSeverity.error => Icons.error_outline,
    AppInlineAlertSeverity.warning => Icons.warning_amber_rounded,
    AppInlineAlertSeverity.info => Icons.info_outline,
    AppInlineAlertSeverity.success => Icons.check_circle_outline,
  };

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    final space = context.space;
    final Color fg = _fg(color);
    final Color bg = _bg(color);
    return Semantics(
      key: semanticLabel,
      container: true,
      liveRegion: true,
      label: '${severity.name}. $title${message == null ? '' : '. $message'}',
      child: Container(
        padding: EdgeInsets.all(space.s3),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: context.radius.all.md,
          border: Border.all(color: fg),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: space.s3,
          children: [
            Icon(_icon, size: space.s5, color: fg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: space.s1,
                children: [
                  ExcludeSemantics(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: space.s1,
                      children: [
                        Text(
                          title,
                          style: context.text.label.large.copyWith(
                            color: color.fg.primary,
                            fontWeight: context.font.weight.semibold,
                          ),
                        ),
                        if (message != null)
                          Text(
                            message!,
                            style: context.text.body.small.copyWith(
                              color: color.fg.secondary,
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (actionLabel != null && onAction != null)
                    Semantics(
                      button: true,
                      label: actionLabel,
                      onTap: onAction,
                      excludeSemantics: true,
                      child: InkWell(
                        key: actionKey,
                        onTap: onAction,
                        borderRadius: context.radius.all.sm,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: space.s1),
                          child: Text(
                            actionLabel!,
                            style: context.text.label.large.copyWith(
                              color: fg,
                              fontWeight: context.font.weight.semibold,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            if (onDismiss != null)
              Semantics(
                button: true,
                label: 'Dismiss',
                child: InkWell(
                  key: dismissKey,
                  onTap: onDismiss,
                  borderRadius: context.radius.all.sm,
                  child: Icon(
                    Icons.close,
                    size: space.s5,
                    color: color.fg.secondary,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
