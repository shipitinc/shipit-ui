import 'package:flutter/material.dart';
import 'package:shipit_ui/src/foundation/app_colors.dart';
import 'package:shipit_ui/src/foundation/app_spacing.dart';
import 'package:shipit_ui/src/foundation/app_radius.dart';
import 'package:shipit_ui/src/foundation/app_typography.dart';
import 'package:shipit_ui/src/components/app_button.dart';
import 'package:shipit_ui/src/components/app_shimmer.dart';

/// State view type for AppStateView.
enum AppStateViewType { loading, empty, error }

/// A reusable state view widget following the shipit_ui design system.
///
/// Combines loading, empty, and error states into a single component.
/// Based on approved Penpot design tokens (AppStateView component).
///
/// ## Semantics
///
/// Uses [Semantics] with appropriate labels for accessibility automation.
class AppStateView extends StatelessWidget {
  final AppStateViewType type;
  final String title;
  final String? message;
  final VoidCallback? onAction;
  final String? actionLabel;
  final Key? semanticLabel;

  const AppStateView({
    super.key,
    required this.type,
    required this.title,
    this.message,
    this.onAction,
    this.actionLabel,
    this.semanticLabel,
  });

  factory AppStateView.loading({
    required String title,
    String? message,
    Key? semanticLabel,
  }) {
    return AppStateView(
      key: semanticLabel,
      type: AppStateViewType.loading,
      title: title,
      message: message,
      semanticLabel: semanticLabel,
    );
  }

  factory AppStateView.empty({
    required String title,
    String? message,
    VoidCallback? onAction,
    String? actionLabel,
    Key? semanticLabel,
  }) {
    return AppStateView(
      key: semanticLabel,
      type: AppStateViewType.empty,
      title: title,
      message: message,
      onAction: onAction,
      actionLabel: actionLabel,
      semanticLabel: semanticLabel,
    );
  }

  factory AppStateView.error({
    required String title,
    String? message,
    VoidCallback? onRetry,
    String retryLabel = 'Retry',
    Key? semanticLabel,
  }) {
    return AppStateView(
      key: semanticLabel,
      type: AppStateViewType.error,
      title: title,
      message: message,
      onAction: onRetry,
      actionLabel: retryLabel,
      semanticLabel: semanticLabel,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Semantics(
        container: true,
        label: _getSemanticLabel(),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.space8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildIcon(),
              const SizedBox(height: AppSpacing.space4),
              Text(
                title,
                style: AppTypography.headlineSmall,
                textAlign: TextAlign.center,
              ),
              if (message != null) ...[
                const SizedBox(height: AppSpacing.space1),
                Text(
                  message!,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.fgSecondaryColor,
                  ),
                  textAlign: TextAlign.center,
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

  String _getSemanticLabel() {
    switch (type) {
      case AppStateViewType.loading:
        return '$title. ${message ?? "Loading"}';
      case AppStateViewType.empty:
        return '$title. ${message ?? "No content available."}';
      case AppStateViewType.error:
        return '$title error. ${message ?? "Something went wrong."}';
    }
  }

  Widget _buildIcon() {
    switch (type) {
      case AppStateViewType.loading:
        return AppShimmer(
          initialProgress: 0.5,
          child: Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: AppColors.shimmerBaseColor,
              shape: BoxShape.circle,
            ),
          ),
        );
      case AppStateViewType.empty:
        return Container(
          width: 48,
          height: 48,
          decoration: const BoxDecoration(
            color: AppColors.neutral100Color,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.inbox,
            size: 24,
            color: AppColors.fgMutedColor,
          ),
        );
      case AppStateViewType.error:
        return Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.stateErrorBgColor,
            border: Border.all(color: AppColors.stateErrorFgColor),
            borderRadius: BorderRadius.circular(AppRadius.radiusFull),
          ),
          child: const Icon(
            Icons.error_outline,
            size: 24,
            color: AppColors.stateErrorFgColor,
          ),
        );
    }
  }
}
