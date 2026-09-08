import 'package:flutter/material.dart';
import 'package:shipit_ui/src/components/app_shimmer.dart';
import 'package:shipit_ui/src/foundation/app_colors.dart';
import 'package:shipit_ui/src/foundation/app_radius.dart';
import 'package:shipit_ui/src/foundation/app_spacing.dart';
import 'package:shipit_ui/src/foundation/app_typography.dart';

/// Skeleton placeholders for loading states following the shipit_ui design
/// system.
///
/// A loading state is a shimmering silhouette of the content that will appear
/// once loaded: compose [AppSkeleton.line], [AppSkeleton.circle] and
/// [AppSkeleton.block] to mirror the final layout, or use the ready-made
/// [AppSkeleton.listTile] / [AppSkeleton.card] shapes. Wrap the composition
/// in a single [AppShimmer] via [AppSkeleton.shimmer] so all placeholders
/// animate together.
///
/// Never replace a content area with a spinner; see `docs/patterns.md`.
///
/// Based on approved Penpot design tokens.
///
/// ## Semantics
///
/// The shimmer wrapper is exposed as a single live-region node labelled
/// 'Loading'; individual placeholders are excluded.
class AppSkeleton extends StatelessWidget {
  final double? width;
  final double height;
  final BorderRadius borderRadius;
  final BoxShape shape;

  const AppSkeleton._({
    super.key,
    this.width,
    required this.height,
    this.borderRadius = AppRadius.borderRadiusSm,
    this.shape = BoxShape.rectangle,
  });

  /// A text-line placeholder. [width] null fills the available width.
  const AppSkeleton.line({
    Key? key,
    double? width,
    double height = AppTypography.fontSizeSm,
  }) : this._(key: key, width: width, height: height);

  /// A circular placeholder (avatars, icons).
  const AppSkeleton.circle({Key? key, double diameter = AppSpacing.space10})
    : this._(
        key: key,
        width: diameter,
        height: diameter,
        shape: BoxShape.circle,
      );

  /// A rectangular placeholder (images, charts, cards). [width] null fills.
  const AppSkeleton.block({
    Key? key,
    double? width,
    double height = AppSpacing.space16,
    BorderRadius borderRadius = AppRadius.borderRadiusMd,
  }) : this._(
         key: key,
         width: width,
         height: height,
         borderRadius: borderRadius,
       );

  /// Wraps a skeleton composition in one [AppShimmer] with loading semantics.
  static Widget shimmer({
    Key? key,
    required Widget child,
    bool autoplay = true,
    double initialProgress = 0.5,
    String semanticsLabel = 'Loading',
  }) {
    return Semantics(
      key: key,
      container: true,
      liveRegion: true,
      label: semanticsLabel,
      excludeSemantics: true,
      child: AppShimmer(
        autoplay: autoplay,
        initialProgress: initialProgress,
        child: child,
      ),
    );
  }

  /// Silhouette of a list tile: leading circle plus title and subtitle lines.
  static Widget listTile({Key? key, bool autoplay = true}) {
    return shimmer(
      key: key,
      autoplay: autoplay,
      child: const Row(
        spacing: AppSpacing.space3,
        children: [
          AppSkeleton.circle(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpacing.space2,
              children: [
                AppSkeleton.line(width: 180),
                AppSkeleton.line(width: 120, height: AppSpacing.space3),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Silhouette of a card: list-tile header plus a body block inside a card
  /// surface. Only the placeholders shimmer, not the card chrome.
  static Widget card({Key? key, bool autoplay = true}) {
    return Container(
      key: key,
      padding: const EdgeInsets.all(AppSpacing.space4),
      decoration: BoxDecoration(
        color: AppColors.bgSurfaceColor,
        borderRadius: AppRadius.borderRadiusLg,
        border: Border.all(color: AppColors.borderDefaultColor),
      ),
      child: shimmer(
        autoplay: autoplay,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSpacing.space3,
          children: [
            Row(
              spacing: AppSpacing.space3,
              children: [
                AppSkeleton.circle(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: AppSpacing.space2,
                    children: [
                      AppSkeleton.line(width: 180),
                      AppSkeleton.line(width: 120, height: AppSpacing.space3),
                    ],
                  ),
                ),
              ],
            ),
            AppSkeleton.block(height: AppSpacing.space16 + AppSpacing.space2),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.shimmerBaseColor,
        shape: shape,
        borderRadius: shape == BoxShape.circle ? null : borderRadius,
      ),
    );
  }
}
