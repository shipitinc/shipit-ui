import 'package:flutter/material.dart';
import 'package:shipit_ui/src/foundation/app_colors.dart';
import 'package:shipit_ui/src/foundation/app_spacing.dart';
import 'package:shipit_ui/src/foundation/app_typography.dart';

/// Size variants for [AppAvatar].
enum AppAvatarSize { sm, md, lg, xl }

/// Presence status shown as a dot on [AppAvatar].
enum AppAvatarStatus { online, offline, busy }

/// A circular avatar following the shipit_ui design system.
///
/// Renders an [image] clipped to a circle when provided, falling back to
/// initials derived from [name] (or a person icon when no name is given)
/// while the image loads or if it fails. An optional [status] dot is drawn
/// bottom-right and an optional custom [badge] top-right.
///
/// Based on approved Penpot design tokens.
///
/// ## Semantics
///
/// Exposed as an image node labelled with [semanticsLabel], which defaults
/// to [name] or `'Avatar'`. Initials and fallback icon are excluded so the
/// label is announced exactly once.
class AppAvatar extends StatelessWidget {
  final String? name;
  final ImageProvider? image;
  final AppAvatarSize size;
  final AppAvatarStatus? status;
  final Widget? badge;
  final String? semanticsLabel;
  final Key? semanticLabel;

  const AppAvatar({
    super.key,
    this.name,
    this.image,
    this.size = AppAvatarSize.md,
    this.status,
    this.badge,
    this.semanticsLabel,
    this.semanticLabel,
  });

  /// Status ring width; half of [AppSpacing.space1].
  static const double _ringWidth = 2.0;

  /// Diameter in logical pixels for the given [size].
  static double dimension(AppAvatarSize size) {
    switch (size) {
      case AppAvatarSize.sm:
        return AppSpacing.space6;
      case AppAvatarSize.md:
        return AppSpacing.space8;
      case AppAvatarSize.lg:
        return AppSpacing.space10;
      case AppAvatarSize.xl:
        return AppSpacing.space12 + AppSpacing.space2;
    }
  }

  /// Derives up to two uppercase initials from [name].
  static String initialsFor(String? name) {
    if (name == null) return '';
    final words = name.trim().split(RegExp(r'\s+'))
      ..removeWhere((w) => w.isEmpty);
    return words.take(2).map((w) => w[0].toUpperCase()).join();
  }

  static TextStyle _textStyle(AppAvatarSize size) {
    switch (size) {
      case AppAvatarSize.sm:
        return AppTypography.labelSmall;
      case AppAvatarSize.md:
        return AppTypography.labelMedium;
      case AppAvatarSize.lg:
        return AppTypography.labelLarge;
      case AppAvatarSize.xl:
        return AppTypography.titleMedium;
    }
  }

  static Color _statusColor(AppAvatarStatus status) {
    switch (status) {
      case AppAvatarStatus.online:
        return AppColors.stateSuccessFgColor;
      case AppAvatarStatus.offline:
        return AppColors.fgMutedColor;
      case AppAvatarStatus.busy:
        return AppColors.stateErrorFgColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double d = dimension(size);
    final String initials = initialsFor(name);

    final Widget fallback = initials.isEmpty
        ? Icon(
            Icons.person_outline,
            size: d / 2,
            color: AppColors.avatarFgColor,
          )
        : Text(
            initials,
            style: _textStyle(size).copyWith(
              color: AppColors.avatarFgColor,
              fontWeight: AppTypography.fontWeightSemibold,
            ),
          );

    final Widget circle = Container(
      width: d,
      height: d,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: AppColors.avatarBgColor,
        shape: BoxShape.circle,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          fallback,
          if (image != null)
            Image(
              image: image!,
              width: d,
              height: d,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => const SizedBox.shrink(),
            ),
        ],
      ),
    );

    return Semantics(
      key: semanticLabel,
      image: true,
      label: semanticsLabel ?? name ?? 'Avatar',
      excludeSemantics: true,
      child: SizedBox(
        width: d,
        height: d,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            circle,
            if (status != null)
              Positioned(
                right: 0,
                bottom: 0,
                child: _AppAvatarStatusDot(
                  color: _statusColor(status!),
                  diameter: d / 4,
                ),
              ),
            if (badge != null)
              Positioned(
                right: 0,
                top: 0,
                child: FractionalTranslation(
                  translation: const Offset(0.25, -0.25),
                  child: badge,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _AppAvatarStatusDot extends StatelessWidget {
  final Color color;
  final double diameter;

  const _AppAvatarStatusDot({required this.color, required this.diameter});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter + AppAvatar._ringWidth * 2,
      height: diameter + AppAvatar._ringWidth * 2,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.bgSurfaceColor,
          width: AppAvatar._ringWidth,
        ),
      ),
    );
  }
}
