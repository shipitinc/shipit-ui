import 'package:flutter/material.dart';
import 'package:shipit_ui/src/foundation/app_colors.dart';
import 'package:shipit_ui/src/foundation/app_radius.dart';
import 'package:shipit_ui/src/foundation/app_spacing.dart';
import 'package:shipit_ui/src/foundation/app_typography.dart';

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

  Color get _fg => switch (severity) {
    AppInlineAlertSeverity.error => AppColors.stateErrorFgColor,
    AppInlineAlertSeverity.warning => AppColors.stateWarningFgColor,
    AppInlineAlertSeverity.info => AppColors.stateInfoFgColor,
    AppInlineAlertSeverity.success => AppColors.stateSuccessFgColor,
  };

  Color get _bg => switch (severity) {
    AppInlineAlertSeverity.error => AppColors.stateErrorBgColor,
    AppInlineAlertSeverity.warning => AppColors.stateWarningBgColor,
    AppInlineAlertSeverity.info => AppColors.stateInfoBgColor,
    AppInlineAlertSeverity.success => AppColors.stateSuccessBgColor,
  };

  IconData get _icon => switch (severity) {
    AppInlineAlertSeverity.error => Icons.error_outline,
    AppInlineAlertSeverity.warning => Icons.warning_amber_rounded,
    AppInlineAlertSeverity.info => Icons.info_outline,
    AppInlineAlertSeverity.success => Icons.check_circle_outline,
  };

  @override
  Widget build(BuildContext context) {
    return Semantics(
      key: semanticLabel,
      container: true,
      liveRegion: true,
      label: '${severity.name}. $title${message == null ? '' : '. $message'}',
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.space3),
        decoration: BoxDecoration(
          color: _bg,
          borderRadius: AppRadius.borderRadiusMd,
          border: Border.all(color: _fg),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSpacing.space3,
          children: [
            Icon(_icon, size: AppSpacing.space5, color: _fg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: AppSpacing.space1,
                children: [
                  ExcludeSemantics(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: AppSpacing.space1,
                      children: [
                        Text(
                          title,
                          style: AppTypography.labelLarge.copyWith(
                            color: AppColors.fgPrimaryColor,
                            fontWeight: AppTypography.fontWeightSemibold,
                          ),
                        ),
                        if (message != null)
                          Text(
                            message!,
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.fgSecondaryColor,
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
                        borderRadius: AppRadius.borderRadiusSm,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: AppSpacing.space1,
                          ),
                          child: Text(
                            actionLabel!,
                            style: AppTypography.labelLarge.copyWith(
                              color: _fg,
                              fontWeight: AppTypography.fontWeightSemibold,
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
                  borderRadius: AppRadius.borderRadiusSm,
                  child: const Icon(
                    Icons.close,
                    size: AppSpacing.space5,
                    color: AppColors.fgSecondaryColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
