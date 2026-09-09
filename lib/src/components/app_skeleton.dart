import 'package:flutter/material.dart';
import 'package:shipit_ui/src/components/app_shimmer.dart';
import 'package:shipit_ui/src/theme/app_theme_tokens.dart';

enum _AppSkeletonKind { line, circle, block }

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
  /// Explicit width; `null` fills the available width (line / block) or uses
  /// the default diameter (circle).
  final double? width;

  /// Explicit height; `null` uses the kind-specific token default.
  final double? height;

  /// Explicit corner radius; `null` uses the kind-specific token default.
  final BorderRadius? borderRadius;

  final _AppSkeletonKind _kind;

  const AppSkeleton._(
    this._kind, {
    super.key,
    this.width,
    this.height,
    this.borderRadius,
  });

  /// A text-line placeholder. [width] null fills the available width;
  /// [height] defaults to `context.font.size.sm`.
  const AppSkeleton.line({Key? key, double? width, double? height})
    : this._(_AppSkeletonKind.line, key: key, width: width, height: height);

  /// A circular placeholder (avatars, icons). [diameter] defaults to
  /// `context.space.s10`.
  const AppSkeleton.circle({Key? key, double? diameter})
    : this._(
        _AppSkeletonKind.circle,
        key: key,
        width: diameter,
        height: diameter,
      );

  /// A rectangular placeholder (images, charts, cards). [width] null fills;
  /// [height] defaults to `context.space.s16` and [borderRadius] to
  /// `context.radius.all.md`.
  const AppSkeleton.block({
    Key? key,
    double? width,
    double? height,
    BorderRadius? borderRadius,
  }) : this._(
         _AppSkeletonKind.block,
         key: key,
         width: width,
         height: height,
         borderRadius: borderRadius,
       );

  /// The rendered shape.
  BoxShape get shape =>
      _kind == _AppSkeletonKind.circle ? BoxShape.circle : BoxShape.rectangle;

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

  static Widget _listTileBody(BuildContext context) {
    final space = context.space;
    return Row(
      spacing: space.s3,
      children: [
        const AppSkeleton.circle(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: space.s2,
            children: [
              const AppSkeleton.line(width: 180),
              AppSkeleton.line(width: 120, height: space.s3),
            ],
          ),
        ),
      ],
    );
  }

  /// Silhouette of a list tile: leading circle plus title and subtitle lines.
  static Widget listTile({Key? key, bool autoplay = true}) {
    return shimmer(
      key: key,
      autoplay: autoplay,
      child: const Builder(builder: _listTileBody),
    );
  }

  /// Silhouette of a card: list-tile header plus a body block inside a card
  /// surface. Only the placeholders shimmer, not the card chrome.
  static Widget card({Key? key, bool autoplay = true}) {
    return Builder(
      key: key,
      builder: (context) {
        final space = context.space;
        return Container(
          padding: EdgeInsets.all(space.s4),
          decoration: BoxDecoration(
            color: context.color.bg.surface,
            borderRadius: context.radius.all.lg,
            border: Border.all(color: context.color.border.base),
          ),
          child: shimmer(
            autoplay: autoplay,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: space.s3,
              children: [
                _listTileBody(context),
                AppSkeleton.block(height: space.s16 + space.s2),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double? resolvedWidth;
    final double resolvedHeight;
    final BorderRadius? resolvedRadius;
    switch (_kind) {
      case _AppSkeletonKind.line:
        resolvedWidth = width;
        resolvedHeight = height ?? context.font.size.sm;
        resolvedRadius = borderRadius ?? context.radius.all.sm;
      case _AppSkeletonKind.circle:
        final diameter = width ?? context.space.s10;
        resolvedWidth = diameter;
        resolvedHeight = height ?? diameter;
        resolvedRadius = null;
      case _AppSkeletonKind.block:
        resolvedWidth = width;
        resolvedHeight = height ?? context.space.s16;
        resolvedRadius = borderRadius ?? context.radius.all.md;
    }

    return Container(
      width: resolvedWidth,
      height: resolvedHeight,
      decoration: BoxDecoration(
        color: context.color.shimmer.base,
        shape: shape,
        borderRadius: resolvedRadius,
      ),
    );
  }
}
