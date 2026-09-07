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
| `component` | button, text_field, select, card, dialog, state_view, etc. | UI component |
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
| `component/button/primary/default` | `AppButton.primary(label: ...)` | MATCHED |
| `component/button/primary/disabled` | `AppButton.primary(label: ..., isDisabled: true)` | MATCHED |
| `component/button/primary/loading` | `AppButton.primary(label: ..., isLoading: true)` | MATCHED |
| `component/button/secondary/default` | `AppButton.secondary(label: ...)` | MATCHED |
| `component/button/secondary/disabled` | `AppButton.secondary(label: ..., isDisabled: true)` | MATCHED |
| `component/button/secondary/loading` | `AppButton.secondary(label: ..., isLoading: true)` | MATCHED |
| `component/text_field/default` | `AppTextField.normal(label: ...)` | MATCHED |
| `component/text_field/error` | `AppTextField.error(label: ...)` | MATCHED |
| `component/text_field/disabled` | `AppTextField.disabled(label: ...)` | MATCHED |
| `component/select/default` | `AppSelect(label: ..., options: ...)` | MATCHED |
| `component/select/error` | `AppSelect(label: ..., options: ..., isError: true)` | MATCHED |
| `component/select/disabled` | `AppSelect(label: ..., options: ..., isDisabled: true)` | MATCHED |
| `component/card/default` | `AppCard(title: ..., children: ...)` | MATCHED |
| `component/dialog/default` | `AppDialog(title: ..., content: ...)` | MATCHED |
| `component/dialog/error` | `AppDialog.error(title: ...)` | MATCHED |
| `component/state_view/loading` | `AppStateView.loading(message: ...)` | MATCHED |
| `component/state_view/empty` | `AppStateView.empty(title: ...)` | MATCHED |
| `component/state_view/error` | `AppStateView.error(title: ..., onRetry: ...)` | MATCHED |

#### Tokens - Colors

| Penpot ID | Flutter API | Status |
|-----------|------------|--------|
| `token/color/bg/base` | `AppColors.bgBase` | MATCHED |
| `token/color/bg/surface` | `AppColors.bgSurface` | MATCHED |
| `token/color/bg/subtle` | `AppColors.bgSubtle` | MATCHED |
| `token/color/bg/disabled` | `AppColors.bgDisabled` | MATCHED |
| `token/color/fg/primary` | `AppColors.fgPrimary` | MATCHED |
| `token/color/fg/secondary` | `AppColors.fgSecondary` | MATCHED |
| `token/color/fg/muted` | `AppColors.fgMuted` | MATCHED |
| `token/color/fg/inverse` | `AppColors.fgInverse` | MATCHED |
| `token/color/fg/disabled` | `AppColors.fgDisabled` | MATCHED |
| `token/color/border/default` | `AppColors.borderDefault` | MATCHED |
| `token/color/border/strong` | `AppColors.borderStrong` | MATCHED |
| `token/color/border/focus` | `AppColors.borderFocus` | MATCHED |
| `token/color/border/error` | `AppColors.borderError` | MATCHED |
| `token/color/action/primary/bg` | `AppColors.actionPrimaryBg` | MATCHED |
| `token/color/action/primary/bgHover` | `AppColors.actionPrimaryBgHover` | MATCHED |
| `token/color/action/primary/fg` | `AppColors.actionPrimaryFg` | MATCHED |
| `token/color/action/secondary/bg` | `AppColors.actionSecondaryBg` | MATCHED |
| `token/color/action/secondary/border` | `AppColors.actionSecondaryBorder` | MATCHED |
| `token/color/action/secondary/fg` | `AppColors.actionSecondaryFg` | MATCHED |
| `token/color/action/disabled/bg` | `AppColors.actionDisabledBg` | MATCHED |
| `token/color/action/disabled/border` | `AppColors.actionDisabledBorder` | MATCHED |
| `token/color/action/disabled/fg` | `AppColors.actionDisabledFg` | MATCHED |
| `token/color/state/error/fg` | `AppColors.stateErrorFg` | MATCHED |
| `token/color/state/error/bg` | `AppColors.stateErrorBg` | MATCHED |
| `token/color/state/success/fg` | `AppColors.stateSuccessFg` | MATCHED |
| `token/color/state/success/bg` | `AppColors.stateSuccessBg` | MATCHED |
| `token/color/state/warning/fg` | `AppColors.stateWarningFg` | MATCHED |
| `token/color/state/warning/bg` | `AppColors.stateWarningBg` | MATCHED |
| `token/color/state/info/fg` | `AppColors.stateInfoFg` | MATCHED |
| `token/color/state/info/bg` | `AppColors.stateInfoBg` | MATCHED |
| `token/color/scrim` | `AppColors.scrim` | MATCHED |

#### Tokens - Typography

| Penpot ID | Flutter API | Status |
|-----------|------------|--------|
| `token/typography/font/family/base` | `AppTypography.fontFamily` | MATCHED |
| `token/typography/font/weight/regular` | `AppTypography.fontWeightRegular` | MATCHED |
| `token/typography/font/weight/medium` | `AppTypography.fontWeightMedium` | MATCHED |
| `token/typography/font/weight/semibold` | `AppTypography.fontWeightSemibold` | MATCHED |
| `token/typography/font/weight/bold` | `AppTypography.fontWeightBold` | MATCHED |
| `token/typography/font/size/xs` | `AppTypography.fontSizeXs` | MATCHED |
| `token/typography/font/size/sm` | `AppTypography.fontSizeSm` | MATCHED |
| `token/typography/font/size/md` | `AppTypography.fontSizeMd` | MATCHED |
| `token/typography/font/size/lg` | `AppTypography.fontSizeLg` | MATCHED |
| `token/typography/font/size/xl` | `AppTypography.fontSizeXl` | MATCHED |
| `token/typography/font/size/2xl` | `AppTypography.fontSize2xl` | MATCHED |
| `token/typography/font/size/3xl` | `AppTypography.fontSize3xl` | MATCHED |
| `token/typography/font/size/4xl` | `AppTypography.fontSize4xl` | MATCHED |
| `token/typography/letterSpacing/tight` | `AppTypography.letterSpacingTight` | MATCHED |
| `token/typography/letterSpacing/normal` | `AppTypography.letterSpacingNormal` | MATCHED |
| `token/typography/letterSpacing/wide` | `AppTypography.letterSpacingWide` | MATCHED |

#### Tokens - Spacing

| Penpot ID | Flutter API | Status |
|-----------|------------|--------|
| `token/spacing/0` | `AppSpacing.space0` | MATCHED |
| `token/spacing/1` | `AppSpacing.space1` | MATCHED |
| `token/spacing/2` | `AppSpacing.space2` | MATCHED |
| `token/spacing/3` | `AppSpacing.space3` | MATCHED |
| `token/spacing/4` | `AppSpacing.space4` | MATCHED |
| `token/spacing/5` | `AppSpacing.space5` | MATCHED |
| `token/spacing/6` | `AppSpacing.space6` | MATCHED |
| `token/spacing/8` | `AppSpacing.space8` | MATCHED |
| `token/spacing/10` | `AppSpacing.space10` | MATCHED |
| `token/spacing/12` | `AppSpacing.space12` | MATCHED |
| `token/spacing/16` | `AppSpacing.space16` | MATCHED |

#### Tokens - Radius

| Penpot ID | Flutter API | Status |
|-----------|------------|--------|
| `token/radius/none` | `AppRadius.radiusNone` | MATCHED |
| `token/radius/sm` | `AppRadius.radiusSm` | MATCHED |
| `token/radius/md` | `AppRadius.radiusMd` | MATCHED |
| `token/radius/lg` | `AppRadius.radiusLg` | MATCHED |
| `token/radius/xl` | `AppRadius.radiusXl` | MATCHED |
| `token/radius/full` | `AppRadius.radiusFull` | MATCHED |

#### Tokens - Breakpoints

| Penpot ID | Flutter API | Status |
|-----------|------------|--------|
| `token/breakpoint/mobile` | `AppBreakpoints.mobile` | MATCHED |
| `token/breakpoint/tablet` | `AppBreakpoints.tablet` | MATCHED |
| `token/breakpoint/desktop` | `AppBreakpoints.desktop` | MATCHED |
| `token/breakpoint/wide` | `AppBreakpoints.wide` | MATCHED |

#### Tokens - Elevation

| Penpot ID | Flutter API | Status |
|-----------|------------|--------|
| `token/elevation/0` | `AppElevation.elevation0` | MATCHED |
| `token/elevation/1` | `AppElevation.elevation1` | MATCHED |
| `token/elevation/2` | `AppElevation.elevation2` | MATCHED |
| `token/elevation/3` | `AppElevation.elevation3` | MATCHED |

#### Tokens - Opacity

| Penpot ID | Flutter API | Status |
|-----------|------------|--------|
| `token/opacity/scrim` | `AppOpacity.scrim` | MATCHED |

#### Tokens - Motion (Provisional)

| Penpot ID | Flutter API | Status |
|-----------|------------|--------|
| `token/motion/duration/instant` | `AppMotion.instant` | MISSING_IN_PENPOT |
| `token/motion/duration/fast` | `AppMotion.fast` | MISSING_IN_PENPOT |
| `token/motion/duration/normal` | `AppMotion.normal` | MISSING_IN_PENPOT |
| `token/motion/duration/slow` | `AppMotion.slow` | MISSING_IN_PENPOT |
| `token/motion/duration/slower` | `AppMotion.slower` | MISSING_IN_PENPOT |
| `token/motion/curve/standard` | `AppMotion.curveStandard` | MISSING_IN_PENPOT |
| `token/motion/curve/decelerate` | `AppMotion.curveDecelerate` | MISSING_IN_PENPOT |
| `token/motion/curve/accelerate` | `AppMotion.curveAccelerate` | MISSING_IN_PENPOT |
| `token/motion/curve/sharp` | `AppMotion.curveSharp` | MISSING_IN_PENPOT |
| `token/motion/curve/bouncy` | `AppMotion.curveBouncy` | MISSING_IN_PENPOT |

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
- Use `AppSpacing.space4` instead of literal `EdgeInsets.all(16)`
- Use `AppColors.actionPrimaryBg` instead of literal hex colors
- Use `AppBreakpoints.tablet` for responsive layout decisions
- See [AGENTS.md](../AGENTS.md) for additional rules