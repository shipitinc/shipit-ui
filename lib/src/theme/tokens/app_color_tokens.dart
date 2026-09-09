import 'dart:ui';

/// Primitive color scales (Penpot set `shipit/primitives`).
///
/// Not for use in product code: consume semantic tokens via
/// `context.color.*`. Exposed so light/dark semantic sets and tests can be
/// expressed against the same source values.
abstract final class AppPrimitiveColors {
  static const Color neutral0 = Color(0xFFFFFFFF);
  static const Color neutral50 = Color(0xFFF8FAFC);
  static const Color neutral100 = Color(0xFFF1F5F9);
  static const Color neutral200 = Color(0xFFE2E8F0);
  static const Color neutral300 = Color(0xFFCBD5E1);
  static const Color neutral400 = Color(0xFF94A3B8);
  static const Color neutral500 = Color(0xFF64748B);
  static const Color neutral600 = Color(0xFF475569);
  static const Color neutral700 = Color(0xFF334155);
  static const Color neutral800 = Color(0xFF1E293B);
  static const Color neutral900 = Color(0xFF0F172A);
  static const Color neutral950 = Color(0xFF020617);

  static const Color accent50 = Color(0xFFEFF6FF);
  static const Color accent400 = Color(0xFF60A5FA);
  static const Color accent500 = Color(0xFF3B82F6);
  static const Color accent600 = Color(0xFF2563EB);
  static const Color accent700 = Color(0xFF1D4ED8);
  static const Color accent950 = Color(0xFF172554);

  static const Color red50 = Color(0xFFFEF2F2);
  static const Color red400 = Color(0xFFF87171);
  static const Color red600 = Color(0xFFDC2626);
  static const Color red950 = Color(0xFF450A0A);

  static const Color green50 = Color(0xFFF0FDF4);
  static const Color green400 = Color(0xFF4ADE80);
  static const Color green600 = Color(0xFF16A34A);
  static const Color green950 = Color(0xFF052E16);

  static const Color amber50 = Color(0xFFFFFBEB);
  static const Color amber400 = Color(0xFFFBBF24);
  static const Color amber600 = Color(0xFFD97706);
  static const Color amber950 = Color(0xFF451A03);
}

/// `color.bg.*`
class AppBgColors {
  final Color base;
  final Color surface;
  final Color subtle;
  final Color disabled;

  const AppBgColors({
    required this.base,
    required this.surface,
    required this.subtle,
    required this.disabled,
  });

  AppBgColors copyWith({
    Color? base,
    Color? surface,
    Color? subtle,
    Color? disabled,
  }) => AppBgColors(
    base: base ?? this.base,
    surface: surface ?? this.surface,
    subtle: subtle ?? this.subtle,
    disabled: disabled ?? this.disabled,
  );
}

/// `color.fg.*`
class AppFgColors {
  final Color primary;
  final Color secondary;
  final Color muted;
  final Color inverse;
  final Color disabled;

  const AppFgColors({
    required this.primary,
    required this.secondary,
    required this.muted,
    required this.inverse,
    required this.disabled,
  });

  AppFgColors copyWith({
    Color? primary,
    Color? secondary,
    Color? muted,
    Color? inverse,
    Color? disabled,
  }) => AppFgColors(
    primary: primary ?? this.primary,
    secondary: secondary ?? this.secondary,
    muted: muted ?? this.muted,
    inverse: inverse ?? this.inverse,
    disabled: disabled ?? this.disabled,
  );
}

/// `color.border.*`
class AppBorderColors {
  final Color base;
  final Color strong;
  final Color focus;
  final Color error;

  const AppBorderColors({
    required this.base,
    required this.strong,
    required this.focus,
    required this.error,
  });

  AppBorderColors copyWith({
    Color? base,
    Color? strong,
    Color? focus,
    Color? error,
  }) => AppBorderColors(
    base: base ?? this.base,
    strong: strong ?? this.strong,
    focus: focus ?? this.focus,
    error: error ?? this.error,
  );
}

/// `color.action.primary.*`
class AppActionPrimaryColors {
  final Color bg;
  final Color bgHover;
  final Color fg;

  const AppActionPrimaryColors({
    required this.bg,
    required this.bgHover,
    required this.fg,
  });

  AppActionPrimaryColors copyWith({Color? bg, Color? bgHover, Color? fg}) =>
      AppActionPrimaryColors(
        bg: bg ?? this.bg,
        bgHover: bgHover ?? this.bgHover,
        fg: fg ?? this.fg,
      );
}

/// `color.action.secondary.*` and `color.action.disabled.*`
class AppActionSurfaceColors {
  final Color bg;
  final Color border;
  final Color fg;

  const AppActionSurfaceColors({
    required this.bg,
    required this.border,
    required this.fg,
  });

  AppActionSurfaceColors copyWith({Color? bg, Color? border, Color? fg}) =>
      AppActionSurfaceColors(
        bg: bg ?? this.bg,
        border: border ?? this.border,
        fg: fg ?? this.fg,
      );
}

/// `color.action.*`
class AppActionColors {
  final AppActionPrimaryColors primary;
  final AppActionSurfaceColors secondary;
  final AppActionSurfaceColors disabled;

  const AppActionColors({
    required this.primary,
    required this.secondary,
    required this.disabled,
  });

  AppActionColors copyWith({
    AppActionPrimaryColors? primary,
    AppActionSurfaceColors? secondary,
    AppActionSurfaceColors? disabled,
  }) => AppActionColors(
    primary: primary ?? this.primary,
    secondary: secondary ?? this.secondary,
    disabled: disabled ?? this.disabled,
  );
}

/// A foreground/background pair (`color.state.<severity>.*`, `color.tooltip`,
/// `color.avatar`, `color.shimmer`).
class AppColorPair {
  final Color fg;
  final Color bg;

  const AppColorPair({required this.fg, required this.bg});

  AppColorPair copyWith({Color? fg, Color? bg}) =>
      AppColorPair(fg: fg ?? this.fg, bg: bg ?? this.bg);
}

/// `color.state.*`
class AppStateColors {
  final AppColorPair error;
  final AppColorPair success;
  final AppColorPair warning;
  final AppColorPair info;

  const AppStateColors({
    required this.error,
    required this.success,
    required this.warning,
    required this.info,
  });

  AppStateColors copyWith({
    AppColorPair? error,
    AppColorPair? success,
    AppColorPair? warning,
    AppColorPair? info,
  }) => AppStateColors(
    error: error ?? this.error,
    success: success ?? this.success,
    warning: warning ?? this.warning,
    info: info ?? this.info,
  );
}

/// `color.shimmer.*`
class AppShimmerColors {
  final Color base;
  final Color highlight;

  const AppShimmerColors({required this.base, required this.highlight});

  AppShimmerColors copyWith({Color? base, Color? highlight}) =>
      AppShimmerColors(
        base: base ?? this.base,
        highlight: highlight ?? this.highlight,
      );
}

/// `color.nav.unselected.*`
class AppNavUnselectedColors {
  final Color fg;

  const AppNavUnselectedColors({required this.fg});

  AppNavUnselectedColors copyWith({Color? fg}) =>
      AppNavUnselectedColors(fg: fg ?? this.fg);
}

/// `color.nav.*`
class AppNavColors {
  final AppColorPair selected;
  final AppNavUnselectedColors unselected;

  const AppNavColors({required this.selected, required this.unselected});

  AppNavColors copyWith({
    AppColorPair? selected,
    AppNavUnselectedColors? unselected,
  }) => AppNavColors(
    selected: selected ?? this.selected,
    unselected: unselected ?? this.unselected,
  );
}

/// `color.chip.*` (also the `selected` sub-node)
class AppChipSurfaceColors {
  final Color bg;
  final Color fg;
  final Color border;

  const AppChipSurfaceColors({
    required this.bg,
    required this.fg,
    required this.border,
  });

  AppChipSurfaceColors copyWith({Color? bg, Color? fg, Color? border}) =>
      AppChipSurfaceColors(
        bg: bg ?? this.bg,
        fg: fg ?? this.fg,
        border: border ?? this.border,
      );
}

class AppChipColors extends AppChipSurfaceColors {
  final AppChipSurfaceColors selected;

  const AppChipColors({
    required super.bg,
    required super.fg,
    required super.border,
    required this.selected,
  });

  @override
  AppChipColors copyWith({
    Color? bg,
    Color? fg,
    Color? border,
    AppChipSurfaceColors? selected,
  }) => AppChipColors(
    bg: bg ?? this.bg,
    fg: fg ?? this.fg,
    border: border ?? this.border,
    selected: selected ?? this.selected,
  );
}

/// `color.table.header.*`
class AppTableHeaderColors {
  final Color bg;

  const AppTableHeaderColors({required this.bg});

  AppTableHeaderColors copyWith({Color? bg}) =>
      AppTableHeaderColors(bg: bg ?? this.bg);
}

/// `color.table.row.*`
class AppTableRowColors {
  final Color hover;

  const AppTableRowColors({required this.hover});

  AppTableRowColors copyWith({Color? hover}) =>
      AppTableRowColors(hover: hover ?? this.hover);
}

/// `color.table.*`
class AppTableColors {
  final AppTableHeaderColors header;
  final AppTableRowColors row;
  final Color border;

  const AppTableColors({
    required this.header,
    required this.row,
    required this.border,
  });

  AppTableColors copyWith({
    AppTableHeaderColors? header,
    AppTableRowColors? row,
    Color? border,
  }) => AppTableColors(
    header: header ?? this.header,
    row: row ?? this.row,
    border: border ?? this.border,
  );
}

/// Semantic color tokens (`color.*`), one instance per brightness.
///
/// Paths mirror the Penpot token names: `context.color.bg.base` is
/// `color.bg.base`, `context.color.state.error.fg` is `color.state.error.fg`.
class AppColorTokens {
  final Brightness brightness;
  final AppBgColors bg;
  final AppFgColors fg;
  final AppBorderColors border;
  final AppActionColors action;
  final AppStateColors state;
  final Color scrim;
  final AppShimmerColors shimmer;
  final AppNavColors nav;
  final AppColorPair tooltip;
  final AppColorPair avatar;
  final AppChipColors chip;
  final AppTableColors table;

  const AppColorTokens({
    required this.brightness,
    required this.bg,
    required this.fg,
    required this.border,
    required this.action,
    required this.state,
    required this.scrim,
    required this.shimmer,
    required this.nav,
    required this.tooltip,
    required this.avatar,
    required this.chip,
    required this.table,
  });

  AppColorTokens copyWith({
    Brightness? brightness,
    AppBgColors? bg,
    AppFgColors? fg,
    AppBorderColors? border,
    AppActionColors? action,
    AppStateColors? state,
    Color? scrim,
    AppShimmerColors? shimmer,
    AppNavColors? nav,
    AppColorPair? tooltip,
    AppColorPair? avatar,
    AppChipColors? chip,
    AppTableColors? table,
  }) => AppColorTokens(
    brightness: brightness ?? this.brightness,
    bg: bg ?? this.bg,
    fg: fg ?? this.fg,
    border: border ?? this.border,
    action: action ?? this.action,
    state: state ?? this.state,
    scrim: scrim ?? this.scrim,
    shimmer: shimmer ?? this.shimmer,
    nav: nav ?? this.nav,
    tooltip: tooltip ?? this.tooltip,
    avatar: avatar ?? this.avatar,
    chip: chip ?? this.chip,
    table: table ?? this.table,
  );

  /// Penpot set `shipit/color` (theme ShipIt / Light).
  static const AppColorTokens light = AppColorTokens(
    brightness: Brightness.light,
    bg: AppBgColors(
      base: AppPrimitiveColors.neutral50,
      surface: AppPrimitiveColors.neutral0,
      subtle: AppPrimitiveColors.neutral100,
      disabled: AppPrimitiveColors.neutral100,
    ),
    fg: AppFgColors(
      primary: AppPrimitiveColors.neutral900,
      secondary: AppPrimitiveColors.neutral600,
      muted: AppPrimitiveColors.neutral400,
      inverse: AppPrimitiveColors.neutral0,
      disabled: AppPrimitiveColors.neutral400,
    ),
    border: AppBorderColors(
      base: AppPrimitiveColors.neutral300,
      strong: AppPrimitiveColors.neutral400,
      focus: AppPrimitiveColors.accent600,
      error: AppPrimitiveColors.red600,
    ),
    action: AppActionColors(
      primary: AppActionPrimaryColors(
        bg: AppPrimitiveColors.accent600,
        bgHover: AppPrimitiveColors.accent700,
        fg: AppPrimitiveColors.neutral0,
      ),
      secondary: AppActionSurfaceColors(
        bg: AppPrimitiveColors.neutral0,
        border: AppPrimitiveColors.neutral300,
        fg: AppPrimitiveColors.neutral900,
      ),
      disabled: AppActionSurfaceColors(
        bg: AppPrimitiveColors.neutral100,
        border: AppPrimitiveColors.neutral200,
        fg: AppPrimitiveColors.neutral400,
      ),
    ),
    state: AppStateColors(
      error: AppColorPair(
        fg: AppPrimitiveColors.red600,
        bg: AppPrimitiveColors.red50,
      ),
      success: AppColorPair(
        fg: AppPrimitiveColors.green600,
        bg: AppPrimitiveColors.green50,
      ),
      warning: AppColorPair(
        fg: AppPrimitiveColors.amber600,
        bg: AppPrimitiveColors.amber50,
      ),
      info: AppColorPair(
        fg: AppPrimitiveColors.accent600,
        bg: AppPrimitiveColors.accent50,
      ),
    ),
    scrim: AppPrimitiveColors.neutral950,
    shimmer: AppShimmerColors(
      base: AppPrimitiveColors.neutral200,
      highlight: AppPrimitiveColors.neutral50,
    ),
    nav: AppNavColors(
      selected: AppColorPair(
        bg: AppPrimitiveColors.accent50,
        fg: AppPrimitiveColors.accent600,
      ),
      unselected: AppNavUnselectedColors(fg: AppPrimitiveColors.neutral600),
    ),
    tooltip: AppColorPair(
      bg: AppPrimitiveColors.neutral900,
      fg: AppPrimitiveColors.neutral0,
    ),
    avatar: AppColorPair(
      bg: AppPrimitiveColors.neutral200,
      fg: AppPrimitiveColors.neutral700,
    ),
    chip: AppChipColors(
      bg: AppPrimitiveColors.neutral0,
      fg: AppPrimitiveColors.neutral600,
      border: AppPrimitiveColors.neutral300,
      selected: AppChipSurfaceColors(
        bg: AppPrimitiveColors.accent50,
        fg: AppPrimitiveColors.accent600,
        border: AppPrimitiveColors.accent600,
      ),
    ),
    table: AppTableColors(
      header: AppTableHeaderColors(bg: AppPrimitiveColors.neutral100),
      row: AppTableRowColors(hover: AppPrimitiveColors.neutral50),
      border: AppPrimitiveColors.neutral200,
    ),
  );

  /// Penpot set `shipit/color-dark` (theme ShipIt / Dark).
  static const AppColorTokens dark = AppColorTokens(
    brightness: Brightness.dark,
    bg: AppBgColors(
      base: AppPrimitiveColors.neutral950,
      surface: AppPrimitiveColors.neutral900,
      subtle: AppPrimitiveColors.neutral800,
      disabled: AppPrimitiveColors.neutral800,
    ),
    fg: AppFgColors(
      primary: AppPrimitiveColors.neutral50,
      secondary: AppPrimitiveColors.neutral300,
      muted: AppPrimitiveColors.neutral500,
      inverse: AppPrimitiveColors.neutral900,
      disabled: AppPrimitiveColors.neutral600,
    ),
    border: AppBorderColors(
      base: AppPrimitiveColors.neutral700,
      strong: AppPrimitiveColors.neutral600,
      focus: AppPrimitiveColors.accent400,
      error: AppPrimitiveColors.red400,
    ),
    action: AppActionColors(
      primary: AppActionPrimaryColors(
        bg: AppPrimitiveColors.accent600,
        bgHover: AppPrimitiveColors.accent500,
        fg: AppPrimitiveColors.neutral0,
      ),
      secondary: AppActionSurfaceColors(
        bg: AppPrimitiveColors.neutral900,
        border: AppPrimitiveColors.neutral700,
        fg: AppPrimitiveColors.neutral50,
      ),
      disabled: AppActionSurfaceColors(
        bg: AppPrimitiveColors.neutral800,
        border: AppPrimitiveColors.neutral700,
        fg: AppPrimitiveColors.neutral600,
      ),
    ),
    state: AppStateColors(
      error: AppColorPair(
        fg: AppPrimitiveColors.red400,
        bg: AppPrimitiveColors.red950,
      ),
      success: AppColorPair(
        fg: AppPrimitiveColors.green400,
        bg: AppPrimitiveColors.green950,
      ),
      warning: AppColorPair(
        fg: AppPrimitiveColors.amber400,
        bg: AppPrimitiveColors.amber950,
      ),
      info: AppColorPair(
        fg: AppPrimitiveColors.accent400,
        bg: AppPrimitiveColors.accent950,
      ),
    ),
    scrim: AppPrimitiveColors.neutral950,
    shimmer: AppShimmerColors(
      base: AppPrimitiveColors.neutral800,
      highlight: AppPrimitiveColors.neutral700,
    ),
    nav: AppNavColors(
      selected: AppColorPair(
        bg: AppPrimitiveColors.accent950,
        fg: AppPrimitiveColors.accent400,
      ),
      unselected: AppNavUnselectedColors(fg: AppPrimitiveColors.neutral300),
    ),
    tooltip: AppColorPair(
      bg: AppPrimitiveColors.neutral100,
      fg: AppPrimitiveColors.neutral900,
    ),
    avatar: AppColorPair(
      bg: AppPrimitiveColors.neutral700,
      fg: AppPrimitiveColors.neutral100,
    ),
    chip: AppChipColors(
      bg: AppPrimitiveColors.neutral900,
      fg: AppPrimitiveColors.neutral300,
      border: AppPrimitiveColors.neutral700,
      selected: AppChipSurfaceColors(
        bg: AppPrimitiveColors.accent950,
        fg: AppPrimitiveColors.accent400,
        border: AppPrimitiveColors.accent400,
      ),
    ),
    table: AppTableColors(
      header: AppTableHeaderColors(bg: AppPrimitiveColors.neutral800),
      row: AppTableRowColors(hover: AppPrimitiveColors.neutral800),
      border: AppPrimitiveColors.neutral700,
    ),
  );
}
