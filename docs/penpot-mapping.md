# Penpot Mapping Convention

## Overview

This document defines the convention for mapping Penpot design identifiers to Flutter APIs in the `shipit_ui` package.

## Mapping Convention

### Identifier Format

Penpot identifiers follow a hierarchical path format:

```
{type}/{category}/{name}/{variant}
```

| Type | Values | Description |
|------|--------|-------------|
| `component` | button, text_field, select, card, dialog, confirm_dialog, empty_state, skeleton, inline_alert, shimmer, tooltip, navigation_rail, avatar, filter_chip, search_field, date_picker, data_table | UI component |
| `token` | color, spacing, radius, typography, motion, breakpoint, elevation, opacity | Design token |
| `theme` | light, dark | Theme variant |

### Naming Convention

```
{type}/{category}/{name}/{variant} → FlutterClassName.methodOrConstructor()
```

### Specific Mappings

#### Components

| Penpot ID | Flutter API | Status |
|-----------|------------|--------|
| `component/button/primary/base` | `AppButton.primary(label: ...)` | MATCHED |
| `component/button/primary/disabled` | `AppButton.primary(label: ..., isDisabled: true)` | MATCHED |
| `component/button/primary/loading` | `AppButton.primary(label: ..., isLoading: true)` | MATCHED |
| `component/button/secondary/base` | `AppButton.secondary(label: ...)` | MATCHED |
| `component/button/secondary/disabled` | `AppButton.secondary(label: ..., isDisabled: true)` | MATCHED |
| `component/button/secondary/loading` | `AppButton.secondary(label: ..., isLoading: true)` | MATCHED |
| `component/text_field/base` | `AppTextField.normal(label: ...)` | MATCHED |
| `component/text_field/error` | `AppTextField.error(label: ..., errorText: ...)` or any `AppTextField` whose `validator` fails / `errorText` is set | MATCHED |
| `component/text_field/disabled` | `AppTextField.disabled(label: ...)` | MATCHED |
| `component/select/base` | `AppSelect(label: ..., options: ...)` | MATCHED |
| `component/select/error` | `AppSelect(state: AppSelectState.error)` or any `AppSelect` whose `validator` fails / `errorText` is set | MATCHED |
| `component/select/disabled` | `AppSelect(label: ..., options: ..., isDisabled: true)` | MATCHED |
| `component/card/default` | `AppCard(title: ..., children: ...)` | MATCHED |
| `component/dialog/default` | `AppDialog(title: ..., content: ...)` | MATCHED |
| `component/dialog/error` | `AppDialog.error(title: ...)` | MATCHED |
| `component/empty_state/default` | `AppEmptyState(title: ..., message: ..., actionLabel: ...)` | MATCHED |
| `component/skeleton/{line,circle,block}` | `AppSkeleton.line()` / `.circle()` / `.block()` (wrap in `AppSkeleton.shimmer`) | MATCHED |
| `component/inline_alert/{error,warning,info,success}` | `AppInlineAlert.error(...)` / `.warning` / `.info` / `.success` | MATCHED |
| `state/loading` (guidance board) | `AppSkeleton` shimmer silhouette rendered in place of the incoming content | MATCHED |
| `state/error` (guidance board) | `AppInlineAlert.error` next to content; `AppConfirmDialog` for blocking decisions | MATCHED |
| `component/shimmer/default` | `AppShimmer(child: ...)` | MATCHED |
| `component/tooltip/default` | `AppTooltip(message: ..., child: ...)` | MATCHED |
| `component/navigation_rail/extended` | `AppNavigationRail(items: ..., extended: true)` | MATCHED |
| `component/navigation_rail/collapsed` | `AppNavigationRail(items: ..., extended: false)` | MATCHED |
| `component/confirm_dialog/base` | `AppConfirmDialog(title: ..., onConfirm: ...)` | MATCHED |
| `component/confirm_dialog/destructive` | `AppConfirmDialog.destructive(title: ..., onConfirm: ...)` | MATCHED |
| `component/avatar/{sm,md,lg,xl}` | `AppAvatar(name: ..., size: AppAvatarSize.*)` | MATCHED |
| `component/avatar/status/{online,busy,offline}` | `AppAvatar(name: ..., status: AppAvatarStatus.*)` | MATCHED |
| `component/avatar/icon` | `AppAvatar()` (no name → person icon) | MATCHED |
| `component/avatar/badge` | `AppAvatar(name: ..., badge: ...)` | MATCHED |
| `component/filter_chip/base` | `AppFilterChip(label: ...)` | MATCHED |
| `component/filter_chip/selected` | `AppFilterChip(label: ..., selected: true)` | MATCHED |
| `component/search_field/base` | `AppSearchField(filters: ...)` | MATCHED |
| `component/search_field/active` | `AppSearchField(controller: <non-empty>)` | MATCHED |
| `component/search_field/recents` | `AppSearchField(recentSearches: ...)` (focused, empty) | MATCHED |
| `component/date_picker/single` | `AppDatePicker(value: ..., presets: ...)` | MATCHED |
| `component/date_picker/range` | `AppDatePicker(mode: AppDatePickerMode.range, rangeValue: ...)` | MATCHED |
| `component/date_picker/empty` | `AppDatePicker(label: ...)` | MATCHED |
| `component/date_picker/error` | `AppDatePicker(errorText: ...)` or any `AppDatePicker` whose `validator` / `rangeValidator` fails | MATCHED |
| `component/date_picker/disabled` | `AppDatePicker(isDisabled: true)` | MATCHED |
| `component/data_table/base` | `AppDataTable(columns: ..., rows: ...)` | MATCHED |
| `component/data_table/paginated` | `AppDataTable(rowsPerPage: ...)` (rows > page) | MATCHED |
| `component/data_table/empty` | `AppDataTable(rows: [])` | MATCHED |
| `component/data_table/loading` | `AppDataTable(isLoading: true)` | MATCHED |

#### Components without a full Penpot design (UI gaps)

These exist in Flutter and Penpot; the Penpot component covers the approved
`state` variants (`default` / `disabled` / `loading`) and reuses the existing
`component/button/*` token set — **no new tokens were added**. The Flutter
implementations additionally honour a hover overlay (`color.bg.subtle` at 8%,
text button) that has no static Penpot equivalent, and accept the same
`AppButtonState`s (`base` / `disabled` / `loading`) and `semanticLabel`
automation key as [AppButton].

| Penpot component | Flutter API | Status |
|------------------|-------------|--------|
| `component/button/text` (`AppTextButton` · state) | `AppTextButton(label: ...)` — text/link-style button in `color.action.primary.bg` (`context.text.label.large`, 44 px tap target) | MATCHED |
| `component/button/icon` (`AppIconButton` · state) | `AppIconButton(icon: ..., tooltip: ...)` — icon-only button in `color.fg.secondary` (44×44 tap target) | MATCHED |

Penpot boards: **02 Components → `AppTextButton`** (board
`416652ee-53fd-807b-8008-9d644c111de7`) and **`AppIconButton`** (board
`416652ee-53fd-807b-8008-9d6450d61b85`), both registered as local library
components.

#### Tokens - Colors

Light values live in the Penpot set `shipit/color` (theme **ShipIt / Light**, `AppColorTokens.light`) and dark values in `shipit/color-dark` (theme **ShipIt / Dark**, `AppColorTokens.dark`) with identical names. In code read them as `context.color.<path>`; the path is the Penpot name minus the `color.` prefix (`color.border.base` → `context.color.border.base`, `color.state.error.fg` → `context.color.state.error.fg`).

| Penpot ID | Flutter API | Status |
|-----------|------------|--------|
| `token/color/bg/base` | `context.color.bg.base` | MATCHED |
| `token/color/bg/surface` | `context.color.bg.surface` | MATCHED |
| `token/color/bg/subtle` | `context.color.bg.subtle` | MATCHED |
| `token/color/bg/disabled` | `context.color.bg.disabled` | MATCHED |
| `token/color/fg/primary` | `context.color.fg.primary` | MATCHED |
| `token/color/fg/secondary` | `context.color.fg.secondary` | MATCHED |
| `token/color/fg/muted` | `context.color.fg.muted` | MATCHED |
| `token/color/fg/inverse` | `context.color.fg.inverse` | MATCHED |
| `token/color/fg/disabled` | `context.color.fg.disabled` | MATCHED |
| `token/color/border/base` | `context.color.border.base` | MATCHED |
| `token/color/border/strong` | `context.color.border.strong` | MATCHED |
| `token/color/border/focus` | `context.color.border.focus` | MATCHED |
| `token/color/border/error` | `context.color.border.error` | MATCHED |
| `token/color/action/primary/bg` | `context.color.action.primary.bg` | MATCHED |
| `token/color/action/primary/bgHover` | `context.color.action.primary.bgHover` | MATCHED |
| `token/color/action/primary/fg` | `context.color.action.primary.fg` | MATCHED |
| `token/color/action/secondary/bg` | `context.color.action.secondary.bg` | MATCHED |
| `token/color/action/secondary/border` | `context.color.action.secondary.border` | MATCHED |
| `token/color/action/secondary/fg` | `context.color.action.secondary.fg` | MATCHED |
| `token/color/action/disabled/bg` | `context.color.action.disabled.bg` | MATCHED |
| `token/color/action/disabled/border` | `context.color.action.disabled.border` | MATCHED |
| `token/color/action/disabled/fg` | `context.color.action.disabled.fg` | MATCHED |
| `token/color/state/error/fg` | `context.color.state.error.fg` | MATCHED |
| `token/color/state/error/bg` | `context.color.state.error.bg` | MATCHED |
| `token/color/state/success/fg` | `context.color.state.success.fg` | MATCHED |
| `token/color/state/success/bg` | `context.color.state.success.bg` | MATCHED |
| `token/color/state/warning/fg` | `context.color.state.warning.fg` | MATCHED |
| `token/color/state/warning/bg` | `context.color.state.warning.bg` | MATCHED |
| `token/color/state/info/fg` | `context.color.state.info.fg` | MATCHED |
| `token/color/state/info/bg` | `context.color.state.info.bg` | MATCHED |
| `token/color/scrim` | `context.color.scrim` | MATCHED |
| `token/color/shimmer/base` | `context.color.shimmer.base` | MATCHED |
| `token/color/shimmer/highlight` | `context.color.shimmer.highlight` | MATCHED |
| `token/color/nav/selected/bg` | `context.color.nav.selected.bg` | MATCHED |
| `token/color/nav/selected/fg` | `context.color.nav.selected.fg` | MATCHED |
| `token/color/nav/unselected/fg` | `context.color.nav.unselected.fg` | MATCHED |
| `token/color/tooltip/bg` | `context.color.tooltip.bg` | MATCHED |
| `token/color/tooltip/fg` | `context.color.tooltip.fg` | MATCHED |
| `token/color/avatar/bg` | `context.color.avatar.bg` | MATCHED |
| `token/color/avatar/fg` | `context.color.avatar.fg` | MATCHED |
| `token/color/chip/bg` | `context.color.chip.bg` | MATCHED |
| `token/color/chip/fg` | `context.color.chip.fg` | MATCHED |
| `token/color/chip/border` | `context.color.chip.border` | MATCHED |
| `token/color/chip/selected/bg` | `context.color.chip.selected.bg` | MATCHED |
| `token/color/chip/selected/fg` | `context.color.chip.selected.fg` | MATCHED |
| `token/color/chip/selected/border` | `context.color.chip.selected.border` | MATCHED |
| `token/color/table/header/bg` | `context.color.table.header.bg` | MATCHED |
| `token/color/table/row/hover` | `context.color.table.row.hover` | MATCHED |
| `token/color/table/border` | `context.color.table.border` | MATCHED |

#### Tokens - Typography

| Penpot ID | Flutter API | Status |
|-----------|------------|--------|
| `token/typography/font/family/base` | `context.font.family` (Inter 400/500/600/700 bundled in `assets/fonts/`, resolved as `context.font.resolvedFamily`) | MATCHED |
| `token/typography/font/weight/regular` | `context.font.weight.regular` | MATCHED |
| `token/typography/font/weight/medium` | `context.font.weight.medium` | MATCHED |
| `token/typography/font/weight/semibold` | `context.font.weight.semibold` | MATCHED |
| `token/typography/font/weight/bold` | `context.font.weight.bold` | MATCHED |
| `token/typography/font/size/xs` | `context.font.size.xs` | MATCHED |
| `token/typography/font/size/sm` | `context.font.size.sm` | MATCHED |
| `token/typography/font/size/md` | `context.font.size.md` | MATCHED |
| `token/typography/font/size/lg` | `context.font.size.lg` | MATCHED |
| `token/typography/font/size/xl` | `context.font.size.xl` | MATCHED |
| `token/typography/font/size/2xl` | `context.font.size.xxl` | MATCHED |
| `token/typography/font/size/3xl` | `context.font.size.xxxl` | MATCHED |
| `token/typography/font/size/4xl` | `context.font.size.xxxxl` | MATCHED |
| `token/typography/letterSpacing/tight` | `context.font.letterSpacing.tight` | MATCHED |
| `token/typography/letterSpacing/normal` | `context.font.letterSpacing.normal` | MATCHED |
| `token/typography/letterSpacing/wide` | `context.font.letterSpacing.wide` | MATCHED |

#### Tokens - Spacing

| Penpot ID | Flutter API | Status |
|-----------|------------|--------|
| `token/spacing/0` | `context.space.s0` | MATCHED |
| `token/spacing/1` | `context.space.s1` | MATCHED |
| `token/spacing/2` | `context.space.s2` | MATCHED |
| `token/spacing/3` | `context.space.s3` | MATCHED |
| `token/spacing/4` | `context.space.s4` | MATCHED |
| `token/spacing/5` | `context.space.s5` | MATCHED |
| `token/spacing/6` | `context.space.s6` | MATCHED |
| `token/spacing/8` | `context.space.s8` | MATCHED |
| `token/spacing/10` | `context.space.s10` | MATCHED |
| `token/spacing/12` | `context.space.s12` | MATCHED |
| `token/spacing/16` | `context.space.s16` | MATCHED |

#### Tokens - Radius

| Penpot ID | Flutter API | Status |
|-----------|------------|--------|
| `token/radius/none` | `context.radius.none` | MATCHED |
| `token/radius/sm` | `context.radius.sm` | MATCHED |
| `token/radius/md` | `context.radius.md` | MATCHED |
| `token/radius/lg` | `context.radius.lg` | MATCHED |
| `token/radius/xl` | `context.radius.xl` | MATCHED |
| `token/radius/full` | `context.radius.full` | MATCHED |

#### Tokens - Breakpoints

| Penpot ID | Flutter API | Status |
|-----------|------------|--------|
| `token/breakpoint/mobile` | `context.breakpoint.mobile` | MATCHED |
| `token/breakpoint/tablet` | `context.breakpoint.tablet` | MATCHED |
| `token/breakpoint/desktop` | `context.breakpoint.desktop` | MATCHED |
| `token/breakpoint/wide` | `context.breakpoint.wide` | MATCHED |

#### Tokens - Elevation

| Penpot ID | Flutter API | Status |
|-----------|------------|--------|
| `token/elevation/0` | `context.elevation.e0` | MATCHED |
| `token/elevation/1` | `context.elevation.e1` | MATCHED |
| `token/elevation/2` | `context.elevation.e2` | MATCHED |
| `token/elevation/3` | `context.elevation.e3` | MATCHED |

#### Tokens - Opacity

| Penpot ID | Flutter API | Status |
|-----------|------------|--------|
| `token/opacity/scrim` | `context.opacity.scrim` | MATCHED |

#### Tokens - Motion (Provisional)

| Penpot ID | Flutter API | Status |
|-----------|------------|--------|
| `token/motion/duration/instant` | `context.motion.duration.instant` | MISSING_IN_PENPOT |
| `token/motion/duration/fast` | `context.motion.duration.fast` | MISSING_IN_PENPOT |
| `token/motion/duration/normal` | `context.motion.duration.normal` | MISSING_IN_PENPOT |
| `token/motion/duration/slow` | `context.motion.duration.slow` | MISSING_IN_PENPOT |
| `token/motion/duration/slower` | `context.motion.duration.slower` | MISSING_IN_PENPOT |
| `token/motion/duration/shimmer` | `context.motion.duration.shimmer` | MATCHED |
| `token/motion/curve/standard` | `context.motion.curve.standard` | MISSING_IN_PENPOT |
| `token/motion/curve/decelerate` | `context.motion.curve.decelerate` | MISSING_IN_PENPOT |
| `token/motion/curve/accelerate` | `context.motion.curve.accelerate` | MISSING_IN_PENPOT |
| `token/motion/curve/sharp` | `context.motion.curve.sharp` | MISSING_IN_PENPOT |
| `token/motion/curve/bouncy` | `context.motion.curve.bouncy` | MISSING_IN_PENPOT |

#### Patterns (Penpot page "03 Patterns" → `docs/patterns.md`)

| Penpot ID | Flutter guidance | Status |
|-----------|------------------|--------|
| `pattern/action-row` | `AppButton.secondary` left, `AppButton.primary` right, gap `context.space.s2` | MATCHED |
| `pattern/field-stack` | Fields fill width, vertical gap `context.space.s4` | MATCHED |

#### Themes

| Penpot theme | Flutter API | Status |
|--------------|-------------|--------|
| `ShipIt / Light` (sets: primitives + `shipit/color` + shared) | `shipitLightTheme()` / `AppTheme.light` | MATCHED |
| `ShipIt / Dark` (sets: primitives + `shipit/color-dark` + shared) | `shipitDarkTheme()` / `AppTheme.dark` | MATCHED |

**Previewing dark mode in Penpot:** Tokens panel → Themes → activate **ShipIt / Dark**. Every component, state board and pattern is bound to semantic tokens, so the whole file re-colours; switch back to **ShipIt / Light** when done (Light is the committed default). Section labels on the canvas are intentionally static. When adding shapes, always bind fills/strokes with tokens (never raw hex) or they will not follow the theme; note that the plugin API only persists token bindings on the *active* page.

## Status Legend

| Status | Meaning |
|--------|---------|
| **MATCHED** | Component/token exists in both Penpot and Flutter with matching values |
| **MISMATCH** | Component/token exists in both but values differ |
| **MISSING_IN_FLUTTER** | Exists in Penpot but not implemented in Flutter |
| **MISSING_IN_PENPOT** | Exists in Flutter but not in Penpot design system |

## Rules

1. **Do not claim mappings to Penpot components that do not yet exist.**
2. **All values are derived from approved Penpot design tokens.**
3. **Do not invent permanent visual brand values.** Use design system tokens.
4. **Any visual change requires corresponding design revision.**
5. **Update this document when new Penpot identifiers are added.**

## Product Agent Guidelines

When using `shipit_ui` components in product code:

- Use `AppButton.primary()` instead of raw `ElevatedButton`
- Use `AppTextField.normal()` instead of raw `TextField`
- Use `context.space.s4` instead of literal `EdgeInsets.all(16)`
- Use `context.color.action.primary.bg` instead of literal hex colors
- Use `context.breakpoint.tablet` for responsive layout decisions
- See [AGENTS.md](../AGENTS.md) for additional rules