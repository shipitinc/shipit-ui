/// Icon size scale (`icon.size.*`). `context.icon.size.sm` is 16px — the size
/// of small inline icons beside caption text.
class AppIconSizeTokens {
  final double sm;
  final double md;
  final double lg;
  final double xl;

  const AppIconSizeTokens({
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
  });

  static const AppIconSizeTokens base = AppIconSizeTokens(
    sm: 16,
    md: 20,
    lg: 24,
    xl: 28,
  );

  AppIconSizeTokens copyWith({
    double? sm,
    double? md,
    double? lg,
    double? xl,
  }) => AppIconSizeTokens(
    sm: sm ?? this.sm,
    md: md ?? this.md,
    lg: lg ?? this.lg,
    xl: xl ?? this.xl,
  );
}

/// Icon tokens (`icon.*`): the size scale for icons. Read as
/// `context.icon.size.sm`.
class AppIconTokens {
  final AppIconSizeTokens size;

  const AppIconTokens({required this.size});

  static const AppIconTokens base = AppIconTokens(size: AppIconSizeTokens.base);

  AppIconTokens copyWith({AppIconSizeTokens? size}) =>
      AppIconTokens(size: size ?? this.size);
}
