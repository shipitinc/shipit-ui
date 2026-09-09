import 'package:flutter/material.dart';
import 'package:shipit_ui/src/theme/app_theme_tokens.dart';

/// Builds a light [ThemeData] for the shipit_ui design system.
///
/// Pass [tokens] to override any token node, e.g.
/// `AppTheme.light.copyWith(radius: AppTheme.light.radius.copyWith(md: 12))`.
ThemeData shipitLightTheme({AppTheme? tokens}) =>
    buildShipitTheme(tokens ?? AppTheme.light);

/// Builds a dark [ThemeData] for the shipit_ui design system
/// (Penpot theme ShipIt / Dark).
ThemeData shipitDarkTheme({AppTheme? tokens}) =>
    buildShipitTheme(tokens ?? AppTheme.dark);

/// Builds a [ThemeData] from an arbitrary [AppTheme] token tree and registers
/// the tree as a [ThemeExtension] so `context.color.*` etc. resolve to it.
ThemeData buildShipitTheme(AppTheme t) {
  final c = t.color, s = t.space, r = t.radius, x = t.text;
  final bool isDark = c.brightness == Brightness.dark;
  final RoundedRectangleBorder buttonShape = RoundedRectangleBorder(
    borderRadius: r.all.md,
  );
  OutlineInputBorder border(Color color, {double width = 1}) =>
      OutlineInputBorder(
        borderRadius: r.all.md,
        borderSide: BorderSide(color: color, width: width),
      );
  final EdgeInsets buttonPadding = EdgeInsets.symmetric(
    horizontal: s.s4,
    vertical: s.s2,
  );

  return ThemeData(
    useMaterial3: true,
    brightness: c.brightness,
    extensions: <ThemeExtension<dynamic>>[t],
    colorScheme: ColorScheme(
      brightness: c.brightness,
      primary: c.action.primary.bg,
      onPrimary: c.action.primary.fg,
      primaryContainer: c.state.info.bg,
      onPrimaryContainer: c.state.info.fg,
      secondary: c.action.secondary.fg,
      onSecondary: c.action.secondary.bg,
      secondaryContainer: c.bg.subtle,
      onSecondaryContainer: c.fg.primary,
      tertiary: c.state.success.fg,
      onTertiary: c.action.primary.fg,
      tertiaryContainer: c.state.success.bg,
      onTertiaryContainer: c.state.success.fg,
      error: c.state.error.fg,
      onError: isDark ? c.fg.inverse : c.action.primary.fg,
      errorContainer: c.state.error.bg,
      onErrorContainer: c.state.error.fg,
      surface: c.bg.surface,
      onSurface: c.fg.primary,
      surfaceDim: c.bg.base,
      surfaceBright: c.bg.surface,
      surfaceContainerLowest: isDark ? c.bg.base : c.bg.surface,
      surfaceContainerLow: isDark ? c.bg.surface : c.bg.base,
      surfaceContainer: c.bg.subtle,
      surfaceContainerHigh: c.bg.subtle,
      surfaceContainerHighest: isDark ? c.border.base : c.bg.subtle,
      onSurfaceVariant: c.fg.secondary,
      outline: c.border.base,
      outlineVariant: isDark ? c.bg.subtle : c.border.base,
      shadow: c.scrim,
      scrim: c.scrim,
      inverseSurface: c.fg.primary,
      onInverseSurface: c.bg.surface,
      inversePrimary: c.nav.selected.fg,
    ),
    textTheme: TextTheme(
      displayLarge: x.display.large,
      displayMedium: x.display.medium,
      displaySmall: x.display.small,
      headlineLarge: x.headline.large,
      headlineMedium: x.headline.medium,
      headlineSmall: x.headline.small,
      titleLarge: x.title.large,
      titleMedium: x.title.medium,
      titleSmall: x.title.small,
      bodyLarge: x.body.large,
      bodyMedium: x.body.medium,
      bodySmall: x.body.small,
      labelLarge: x.label.large,
      labelMedium: x.label.medium,
      labelSmall: x.label.small,
    ),
    scaffoldBackgroundColor: c.bg.base,
    canvasColor: c.bg.surface,
    cardColor: c.bg.surface,
    dialogTheme: DialogThemeData(
      backgroundColor: c.bg.surface,
      shape: RoundedRectangleBorder(borderRadius: r.all.xl),
    ),
    dividerColor: c.border.base,
    dividerTheme: DividerThemeData(color: c.border.base, thickness: 1),
    iconTheme: IconThemeData(color: c.fg.secondary),
    appBarTheme: AppBarTheme(
      backgroundColor: c.bg.surface,
      foregroundColor: c.fg.primary,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: x.headline.medium,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: c.border.base),
        borderRadius: r.all.md,
      ),
      color: c.bg.surface,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: c.action.primary.bg,
        foregroundColor: c.action.primary.fg,
        disabledBackgroundColor: c.action.disabled.bg,
        disabledForegroundColor: c.action.disabled.fg,
        padding: buttonPadding,
        shape: buttonShape,
        textStyle: x.label.large,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: c.action.secondary.fg,
        backgroundColor: c.action.secondary.bg,
        disabledForegroundColor: c.action.disabled.fg,
        padding: buttonPadding,
        shape: buttonShape,
        side: BorderSide(color: c.action.secondary.border),
        textStyle: x.label.large,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: c.action.primary.bg,
        textStyle: x.label.large,
        shape: buttonShape,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: c.bg.surface,
      contentPadding: buttonPadding,
      border: border(c.border.base),
      enabledBorder: border(c.border.base),
      focusedBorder: border(c.border.focus, width: 2),
      errorBorder: border(c.border.error),
      focusedErrorBorder: border(c.border.error, width: 2),
      disabledBorder: border(c.action.disabled.border),
      hintStyle: x.body.medium.copyWith(color: c.fg.muted),
      labelStyle: x.label.medium.copyWith(color: c.fg.secondary),
      errorStyle: x.body.small.copyWith(color: c.state.error.fg),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: c.chip.bg,
      selectedColor: c.chip.selected.bg,
      side: BorderSide(color: c.chip.border),
      labelStyle: x.label.medium.copyWith(color: c.chip.fg),
      shape: RoundedRectangleBorder(borderRadius: r.all.full),
      padding: EdgeInsets.symmetric(horizontal: s.s2, vertical: s.s1),
    ),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(color: c.tooltip.bg, borderRadius: r.all.md),
      textStyle: x.label.medium.copyWith(color: c.tooltip.fg),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: c.tooltip.bg,
      contentTextStyle: x.body.medium.copyWith(color: c.tooltip.fg),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: r.all.md),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: c.action.primary.bg,
      strokeWidth: 3,
    ),
    listTileTheme: ListTileThemeData(
      tileColor: c.bg.surface,
      textColor: c.fg.primary,
      iconColor: c.fg.secondary,
    ),
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: c.bg.surface,
      indicatorColor: c.nav.selected.bg,
      selectedIconTheme: IconThemeData(color: c.nav.selected.fg),
      unselectedIconTheme: IconThemeData(color: c.nav.unselected.fg),
      selectedLabelTextStyle: x.label.large.copyWith(color: c.nav.selected.fg),
      unselectedLabelTextStyle: x.label.large.copyWith(
        color: c.nav.unselected.fg,
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: c.bg.surface,
      headerForegroundColor: c.fg.primary,
      shape: RoundedRectangleBorder(borderRadius: r.all.xl),
    ),
  );
}
