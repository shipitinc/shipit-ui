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
| `component` | button, text_field, select, card, dialog, etc. | UI component |
| `token` | color, spacing, radius, typography, motion, breakpoint | Design token |
| `theme` | light, dark | Theme variant |

### Naming Convention

```
{type}/{category}/{name}/{variant} → FlutterClassName.methodOrConstructor()
```

### Specific Mappings

#### Components

| Penpot ID | Flutter API | Status |
|-----------|------------|--------|
| `component/button/primary` | `AppButton.primary(label: ...)` | Implemented (provisional) |
| `component/button/secondary` | `AppButton.secondary(label: ...)` | Implemented (provisional) |
| `component/button/destructive` | `AppButton.destructive(label: ...)` | Implemented (provisional) |
| `component/button/ghost` | `AppButton.ghost(label: ...)` | Implemented (provisional) |
| `component/button/disabled` | `AppButton(label: ..., isDisabled: true)` | Implemented (provisional) |
| `component/button/loading` | `AppButton(label: ..., isLoading: true)` | Implemented (provisional) |
| `component/text_field/normal` | `AppTextField.normal(label: ...)` | Implemented (provisional) |
| `component/text_field/error` | `AppTextField.error(label: ...)` | Implemented (provisional) |
| `component/text_field/disabled` | `AppTextField.disabled(label: ...)` | Implemented (provisional) |
| `component/select/default` | `AppSelect(label: ..., options: ...)` | Implemented (provisional) |
| `component/card/default` | `AppCard(title: ..., children: ...)` | Implemented (provisional) |
| `component/dialog/default` | `AppDialog(title: ..., content: ...)` | Implemented (provisional) |
| `component/dialog/error` | `AppDialog.error(title: ...)` | Implemented (provisional) |
| `component/loading_state/default` | `AppLoadingState(message: ...)` | Implemented (provisional) |
| `component/empty_state/default` | `AppEmptyState(title: ...)` | Implemented (provisional) |
| `component/error_state/default` | `AppErrorState(title: ...)` | Implemented (provisional) |

#### Tokens

| Penpot ID | Flutter API | Status |
|-----------|------------|--------|
| `token/color/brand/primary` | `AppColors.brandPrimary` | Provisional |
| `token/color/brand/secondary` | `AppColors.brandSecondary` | Provisional |
| `token/color/action/primary` | `AppColors.actionPrimary` | Provisional |
| `token/color/action/secondary` | `AppColors.actionSecondary` | Provisional |
| `token/color/action/destructive` | `AppColors.actionDestructive` | Provisional |
| `token/color/semantic/success` | `AppColors.stateSuccess` | Provisional |
| `token/color/semantic/error` | `AppColors.stateError` | Provisional |
| `token/color/semantic/warning` | `AppColors.stateWarning` | Provisional |
| `token/color/semantic/info` | `AppColors.stateInfo` | Provisional |
| `token/color/neutral/50` | `AppColors.neutral50` | Provisional |
| `token/color/neutral/100` | `AppColors.neutral100` | Provisional |
| `token/color/neutral/200` | `AppColors.neutral200` | Provisional |
| `token/color/neutral/300` | `AppColors.neutral300` | Provisional |
| `token/color/neutral/400` | `AppColors.neutral400` | Provisional |
| `token/color/neutral/500` | `AppColors.neutral500` | Provisional |
| `token/color/neutral/600` | `AppColors.neutral600` | Provisional |
| `token/color/neutral/700` | `AppColors.neutral700` | Provisional |
| `token/color/neutral/800` | `AppColors.neutral800` | Provisional |
| `token/color/neutral/900` | `AppColors.neutral900` | Provisional |
| `token/color/neutral/950` | `AppColors.neutral950` | Provisional |
| `token/color/text/primary` | `AppColors.textPrimary` | Provisional |
| `token/color/text/secondary` | `AppColors.textSecondary` | Provisional |
| `token/color/text/disabled` | `AppColors.textDisabled` | Provisional |
| `token/color/text/on_primary` | `AppColors.textOnPrimary` | Provisional |
| `token/color/background` | `AppColors.background` | Provisional |
| `token/color/surface` | `AppColors.surface` | Provisional |
| `token/color/surface_dark` | `AppColors.surfaceDark` | Provisional |
| `token/color/divider` | `AppColors.divider` | Provisional |
| `token/spacing/2xs` | `AppSpacing.spacing2xs` | Provisional |
| `token/spacing/xs` | `AppSpacing.spacingXs` | Provisional |
| `token/spacing/sm` | `AppSpacing.spacingSm` | Provisional |
| `token/spacing/md` | `AppSpacing.spacingMd` | Provisional |
| `token/spacing/lg` | `AppSpacing.spacingLg` | Provisional |
| `token/spacing/xl` | `AppSpacing.spacingXl` | Provisional |
| `token/spacing/xxl` | `AppSpacing.spacingXxl` | Provisional |
| `token/spacing/xxxl` | `AppSpacing.spacingXxxl` | Provisional |
| `token/radius/none` | `AppRadius.radiusNone` | Provisional |
| `token/radius/sm` | `AppRadius.radiusSm` | Provisional |
| `token/radius/md` | `AppRadius.radiusMd` | Provisional |
| `token/radius/lg` | `AppRadius.radiusLg` | Provisional |
| `token/radius/xl` | `AppRadius.radiusXl` | Provisional |
| `token/radius/xxl` | `AppRadius.radiusXxl` | Provisional |
| `token/radius/full` | `AppRadius.radiusFull` | Provisional |
| `token/breakpoint/sm` | `AppBreakpoints.sm` | Provisional |
| `token/breakpoint/md` | `AppBreakpoints.md` | Provisional |
| `token/breakpoint/lg` | `AppBreakpoints.lg` | Provisional |
| `token/breakpoint/xl` | `AppBreakpoints.xl` | Provisional |
| `token/motion/duration/instant` | `AppMotion.instant` | Provisional |
| `token/motion/duration/fast` | `AppMotion.fast` | Provisional |
| `token/motion/duration/normal` | `AppMotion.normal` | Provisional |
| `token/motion/duration/slow` | `AppMotion.slow` | Provisional |
| `token/motion/duration/slower` | `AppMotion.slower` | Provisional |
| `token/motion/curve/standard` | `AppMotion.curveStandard` | Provisional |
| `token/motion/curve/decelerate` | `AppMotion.curveDecelerate` | Provisional |
| `token/motion/curve/accelerate` | `AppMotion.curveAccelerate` | Provisional |
| `token/motion/curve/sharp` | `AppMotion.curveSharp` | Provisional |
| `token/typography/font/family` | `AppTypography.fontFamily` | Provisional |
| `token/typography/display/large` | `AppTypography.displayLarge` | Provisional |
| `token/typography/display/medium` | `AppTypography.displayMedium` | Provisional |
| `token/typography/display/small` | `AppTypography.displaySmall` | Provisional |
| `token/typography/headline/large` | `AppTypography.headlineLarge` | Provisional |
| `token/typography/headline/medium` | `AppTypography.headlineMedium` | Provisional |
| `token/typography/headline/small` | `AppTypography.headlineSmall` | Provisional |
| `token/typography/title/large` | `AppTypography.titleLarge` | Provisional |
| `token/typography/title/medium` | `AppTypography.titleMedium` | Provisional |
| `token/typography/title/small` | `AppTypography.titleSmall` | Provisional |
| `token/typography/body/large` | `AppTypography.bodyLarge` | Provisional |
| `token/typography/body/medium` | `AppTypography.bodyMedium` | Provisional |
| `token/typography/body/small` | `AppTypography.bodySmall` | Provisional |
| `token/typography/label/large` | `AppTypography.labelLarge` | Provisional |
| `token/typography/label/medium` | `AppTypography.labelMedium` | Provisional |
| `token/typography/label/small` | `AppTypography.labelSmall` | Provisional |
| `token/typography/mono/medium` | `AppTypography.monoMedium` | Provisional |

## Status Legend

| Status | Meaning |
|--------|---------|
| **Implemented (provisional)** | Component exists in Flutter code with placeholder values |
| **Provisional** | Token value is a placeholder, not yet approved by design |
| **Not mapped** | Penpot identifier does not yet exist in the design system |
| **Planned** | Component/token is planned but not yet implemented |

## Rules

1. **Do not claim mappings to Penpot components that do not yet exist.**
2. **All values are provisional** until approved by design authority.
3. **Do not invent permanent visual brand values.** Use neutral placeholders.
4. **Any visual change requires corresponding design revision.**
5. **Update this document when new Penpot identifiers are added.**

## Product Agent Guidelines

When using `shipit_ui` components in product code:

- Use `AppButton.primary()` instead of raw `ElevatedButton`
- Use `AppTextField.normal()` instead of raw `TextField`
- Use `AppSpacing.md` instead of literal `EdgeInsets.all(16)`
- Use `AppColors.actionPrimary` instead of literal hex colors
- Use `AppBreakpoints.md` for responsive layout decisions
- See [AGENTS.md](../AGENTS.md) for additional rules
