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
final color = AppColors.actionPrimary;
final spacing = AppSpacing.md;
final style = AppTypography.titleMedium;

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
