import 'package:flutter/material.dart';
import 'package:shipit_ui/src/theme/app_theme_tokens.dart';

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

  /// Status ring width; half of `space.s1`.
  static const double _ringWidth = 2.0;

  /// Diameter in logical pixels for the given [size], resolved against
  /// [space] (defaults to the base scale; pass `context.space` in widgets).
  static double dimension(
    AppAvatarSize size, [
    AppSpaceTokens space = AppSpaceTokens.base,
  ]) {
    switch (size) {
      case AppAvatarSize.sm:
        return space.s6;
      case AppAvatarSize.md:
        return space.s8;
      case AppAvatarSize.lg:
        return space.s10;
      case AppAvatarSize.xl:
        return space.s12 + space.s2;
    }
  }

  /// Derives up to two uppercase initials from [name].
  static String initialsFor(String? name) {
    if (name == null) return '';
    final words = name.trim().split(RegExp(r'\s+'))
      ..removeWhere((w) => w.isEmpty);
    return words.take(2).map((w) => w[0].toUpperCase()).join();
  }

  static TextStyle _textStyle(AppAvatarSize size, AppTextTokens text) {
    switch (size) {
      case AppAvatarSize.sm:
        return text.label.small;
      case AppAvatarSize.md:
        return text.label.medium;
      case AppAvatarSize.lg:
        return text.label.large;
      case AppAvatarSize.xl:
        return text.title.medium;
    }
  }

  static Color _statusColor(AppAvatarStatus status, AppColorTokens color) {
    switch (status) {
      case AppAvatarStatus.online:
        return color.state.success.fg;
      case AppAvatarStatus.offline:
        return color.fg.muted;
      case AppAvatarStatus.busy:
        return color.state.error.fg;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    final double d = dimension(size, context.space);
    final String initials = initialsFor(name);

    final Widget fallback = initials.isEmpty
        ? Icon(Icons.person_outline, size: d / 2, color: color.avatar.fg)
        : Text(
            initials,
            style: _textStyle(size, context.text).copyWith(
              color: color.avatar.fg,
              fontWeight: context.font.weight.semibold,
            ),
          );

    final Widget circle = Container(
      width: d,
      height: d,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: color.avatar.bg, shape: BoxShape.circle),
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
                  color: _statusColor(status!, color),
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
          color: context.color.bg.surface,
          width: AppAvatar._ringWidth,
        ),
      ),
    );
  }
}
