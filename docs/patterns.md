# shipit_ui Patterns

Composition rules built from `shipit_ui` components. Product agents apply
them rather than inventing layouts.

- **App states** (loading / error / empty) are component behaviour and live on
  the Penpot page **02 Components** as `state / loading`, `state / error` and
  the `AppEmptyState`, `AppSkeleton`, `AppInlineAlert` components.
- **Layout patterns** (action row, field stack) live on **03 Patterns** as
  `pattern / <name>`.

## Loading state (`state/loading`, Penpot 02 Components)

A loading state is a **shimmering silhouette of the content that is about to
appear** — same sizes, gaps and radii. It never replaces the view with an
icon + "Loading…" screen, and never uses a bare spinner.

Compose `AppSkeleton.line` / `.circle` / `.block` to mirror the final layout
(or use the `AppSkeleton.listTile` / `.card` presets) and wrap the composition
in one `AppSkeleton.shimmer(...)`. Components that own their layout
(`AppDataTable(isLoading: true)`) already do this.

```dart
// CORRECT — silhouette of the card that will render once loaded
AppSkeleton.shimmer(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: context.space.s3,
    children: const [
      Row(
        spacing: context.space.s3,
        children: [
          AppSkeleton.circle(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: context.space.s2,
              children: [
                AppSkeleton.line(width: 180),
                AppSkeleton.line(width: 120, height: context.space.s3),
              ],
            ),
          ),
        ],
      ),
      AppSkeleton.block(height: context.space.s16),
    ],
  ),
)

// WRONG — replaces the content area
Center(child: CircularProgressIndicator())
AppEmptyState(title: 'Loading…')
```

| Situation | Use |
|-----------|-----|
| Any content area whose layout is known (list, card, table, detail, form) | `AppSkeleton` silhouette in place |
| Button / inline action in flight | `AppButton(state: AppButtonState.loading)` |
| Anywhere | Never `CircularProgressIndicator` / `LinearProgressIndicator`, never a full-view "Loading" screen |

Tokens: `context.color.shimmer.base` → `context.color.shimmer.highlight`, `context.motion.duration.shimmer`
(1200 ms); lines/blocks `context.radius.sm`/`radiusMd`, circles `radiusFull`.

## Error state (`state/error`, Penpot 02 Components)

Errors are surfaced **on top of or next to** the affected content, never by
replacing it. The content area keeps its last good state (or its skeleton)
underneath.

| Situation | Use |
|-----------|-----|
| Failed load or action, user can continue | `AppInlineAlert.error(title, message, actionLabel: 'Retry', onAction, onDismiss)` placed directly above the affected content |
| User must make a blocking decision | `AppConfirmDialog` / `AppDialog.error` |
| Field-level validation | `AppTextField` / `AppSelect` / `AppDatePicker` inside a `Form` with `validator` (or `rangeValidator`); message comes from the validator or `errorText` |
| Anywhere | Never a full-view error icon screen |

`AppInlineAlert` also has `.warning`, `.info` and `.success` severities for
non-error feedback.

## Empty state (`component/empty_state`, Penpot 02 Components)

`AppEmptyState` is the **only** state that replaces a content area: icon,
title, optional message and optional secondary action. Use it when a query
legitimately returns nothing — not for loading and not for errors.

## Action row (`pattern/action-row`)

Buttons are ordered least → most emphatic/destructive, left to right:
`AppButton.secondary` on the left, `AppButton.primary` on the right, gap
`context.space.s2` (8 px), right-aligned. `AppDialog`, `AppConfirmDialog`
and `AppEmptyState` (single secondary action) already apply this.

## Field stack (`pattern/field-stack`)

Vertical gap between form fields is `context.space.s4` (16 px); fields fill
the container width. Applies to `AppTextField`, `AppSelect`, `AppDatePicker`
and `AppSearchField`.

Wrap the stack in a `Form` and give each field a `validator`
(`AppTextField`, `AppSelect`, `AppDatePicker`; range pickers use
`rangeValidator`); call `formKey.currentState!.validate()` on submit (or set
`autovalidateMode: AutovalidateMode.onUserInteraction`) and
`formKey.currentState!.save()` to collect values via `onSaved`. Server-side
errors are surfaced per field with `errorText`, which always wins over the
validator message. Never show validation failures as a full-view error state.
