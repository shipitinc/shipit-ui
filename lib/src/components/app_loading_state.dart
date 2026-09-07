import 'package:flutter/material.dart';
import 'package:shipit_ui/src/foundation/app_colors.dart';
import 'package:shipit_ui/src/foundation/app_spacing.dart';
import 'package:shipit_ui/src/foundation/app_typography.dart';

/// A reusable loading state widget following the shipit_ui design system.
///
/// ## Semantics
///
/// Uses [Semantics] with `progressBar: true` and `label` for
/// accessibility automation.
///
/// ## Provisional
///
/// Visual values are provisional until approved Penpot tokens are adopted.
class AppLoadingState extends StatelessWidget {
  final String? message;
  final double size;
  final Color? color;
  final Key? semanticLabel;

  const AppLoadingState({
    super.key,
    this.message,
    this.size = 40,
    this.color,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: message ?? 'Loading',
      container: true,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.spacingXl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: size,
                height: size,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    color ?? AppColors.actionPrimary,
                  ),
                ),
              ),
              if (message != null) ...[
                const SizedBox(height: AppSpacing.spacingMd),
                Text(
                  message!,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
