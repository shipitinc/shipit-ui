# shipit_ui

The canonical implementation of the ShipIt cross-product Flutter design system.

## Purpose

`shipit_ui` provides semantic design tokens, reusable widgets, and theme
integration for ShipIt products targeting Flutter Web, Android, and iOS.

## Architecture

```
lib/
├── shipit_ui.dart              # Public API barrel export
├── src/
│   ├── foundation/             # Design tokens
│   │   ├── app_colors.dart     # Semantic color tokens
│   │   ├── app_typography.dart # Typography tokens
│   │   ├── app_spacing.dart    # Spacing tokens
│   │   ├── app_radius.dart     # Border radius tokens
│   │   ├── app_breakpoints.dart# Responsive breakpoints
│   │   └── app_motion.dart     # Motion/easing tokens
│   ├── theme/                  # ThemeData integration
│   │   └── app_theme.dart      # Light & dark themes
│   ├── layout/                 # Layout primitives
│   │   └── app_layout.dart     # Responsive layout helpers
│   └── components/             # Reusable widgets
│       ├── app_avatar.dart
│       ├── app_button.dart
│       ├── app_card.dart
│       ├── app_confirm_dialog.dart
│       ├── app_data_table.dart
│       ├── app_date_picker.dart
│       ├── app_dialog.dart
│       ├── app_empty_state.dart     # the only view-replacing state
│       ├── app_filter_chip.dart
│       ├── app_inline_alert.dart    # error / warning / info / success feedback
│       ├── app_navigation_rail.dart
│       ├── app_search_field.dart
│       ├── app_select.dart
│       ├── app_shimmer.dart
│       ├── app_skeleton.dart        # loading silhouettes
│       ├── app_text_field.dart
│       └── app_tooltip.dart
```

## Usage

```dart
import 'package:shipit_ui/shipit_ui.dart';

// Use semantic tokens
final color = context.color.action.primary.bg;
final spacing = context.space.s4;
final style = context.text.title.medium;

// Use components
AppButton.primary(label: 'Submit', onPressed: () {});
AppTextField.normal(label: 'Name');
AppCard(title: 'Title', children: [...]);
```

## Theme Integration

```dart
MaterialApp(
  theme: shipitLightTheme(),
  darkTheme: shipitDarkTheme(),
  home: MyHomePage(),
);
```

Both themes register the `AppTheme` token tree as a `ThemeExtension`. Read
every design value through `BuildContext` — `context.color.bg.base`,
`context.space.s4`, `context.radius.all.md`, `context.text.body.medium`,
`context.motion.duration.fast` — and it resolves correctly for the active
brightness. Paths mirror the Penpot token names.

Every node supports `copyWith`, so a consuming app can override one segment:

```dart
final tokens = AppTheme.light.copyWith(
  radius: AppTheme.light.radius.copyWith(md: 12),
  color: AppTheme.light.color.copyWith(
    action: AppTheme.light.color.action.copyWith(
      primary: AppTheme.light.color.action.primary.copyWith(bg: brandBlue),
    ),
  ),
);
MaterialApp(theme: shipitLightTheme(tokens: tokens), ...);
```

## Fonts

`shipit_ui` bundles **Inter** (400 / 500 / 600 / 700, SIL OFL 1.1 — see
`assets/fonts/LICENSE-Inter.txt`). Every `context.text.*` style and the
`shipitLightTheme()` / `shipitDarkTheme()` text themes already resolve to it;
consuming apps do not need to declare the font. If you build a `TextStyle`
by hand, pass `package: context.font.package` (or use
`context.font.resolvedFamily`, i.e. `packages/shipit_ui/Inter`).

Widget/golden tests render with Flutter's Ahem test font unless you load the
family yourself, e.g. `FontLoader(context.font.resolvedFamily)` with the
four `packages/shipit_ui/assets/fonts/Inter-*.ttf` assets.

## Testing

```bash
dart format .
flutter analyze
flutter test
```

## Design Token Mapping

See [docs/penpot-mapping.md](docs/penpot-mapping.md) for the mapping convention
between Penpot identifiers and Flutter APIs.

## Patterns

See [docs/patterns.md](docs/patterns.md) for composition rules: loading =
`AppSkeleton` silhouette in place, error = `AppInlineAlert` next to content,
empty = `AppEmptyState`; plus action rows and field stacks.

## Agent Rules

See [AGENTS.md](AGENTS.md) for rules governing product agent usage.

## License

See LICENSE file.
