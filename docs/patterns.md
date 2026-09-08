# shipit_ui Patterns

Composition rules built from `shipit_ui` components. Each pattern mirrors a
board on the Penpot page **03 Patterns** (`pattern/<name>`). Patterns are
product-agnostic; product agents apply them rather than inventing layouts.

## Loading state (`pattern/loading-state`)

**Prefer `AppShimmer` skeletons.** A loading view should mirror the final
layout: same sizes, gaps and radii as the content that will replace it, with
each placeholder wrapped in `AppShimmer` (or one `AppShimmer` around the whole
skeleton).

```dart
// CORRECT — skeleton that mirrors the loaded card
AppShimmer(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: AppSpacing.space3,
    children: [
      Row(
        spacing: AppSpacing.space3,
        children: [
          Container(width: 40, height: 40, decoration: const BoxDecoration(color: AppColors.shimmerBaseColor, shape: BoxShape.circle)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppSpacing.space2,
            children: [
              Container(width: 180, height: 14, decoration: const BoxDecoration(color: AppColors.shimmerBaseColor, borderRadius: AppRadius.borderRadiusSm)),
              Container(width: 120, height: 12, decoration: const BoxDecoration(color: AppColors.shimmerBaseColor, borderRadius: AppRadius.borderRadiusSm)),
            ],
          ),
        ],
      ),
      Container(height: 72, decoration: const BoxDecoration(color: AppColors.shimmerBaseColor, borderRadius: AppRadius.borderRadiusSm)),
    ],
  ),
)

// WRONG — bare spinner in a content area
Center(child: CircularProgressIndicator())
```

Rules:

| Situation | Use |
|-----------|-----|
| Content area, list, card, table, detail view whose layout is known | `AppShimmer` skeleton (components such as `AppDataTable(isLoading: true)` already do this) |
| Full-screen or blocking load where the layout is unknown (app boot, auth hand-off) | `AppStateView.loading(...)` |
| Button/inline action in flight | `AppButton(state: AppButtonState.loading)` |
| Anywhere | Never a raw `CircularProgressIndicator` / `LinearProgressIndicator` |

Tokens: `AppColors.shimmerBase` → `AppColors.shimmerHighlight`, animated with
`AppMotion.shimmer` (1200 ms). Skeleton bars use `AppRadius.radiusSm`, avatar
placeholders `AppRadius.radiusFull`.

Penpot: `AppStateView` state=`loading` on **02 Components** is annotated as
the full-screen fallback; the skeleton reference is `pattern / loading-state`
on **03 Patterns**.

## Action row (`pattern/action-row`)

Buttons are ordered least → most emphatic/destructive, left to right:
`AppButton.secondary` on the left, `AppButton.primary` on the right, gap
`AppSpacing.space2` (8 px), right-aligned. `AppDialog`, `AppConfirmDialog`
and `AppStateView.error` already apply this.

## Field stack (`pattern/field-stack`)

Vertical gap between form fields is `AppSpacing.space4` (16 px); fields fill
the container width. Applies to `AppTextField`, `AppSelect`, `AppDatePicker`
and `AppSearchField`.
