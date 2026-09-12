# shipit_ui Agent Rules

This repository must remain **product-agnostic**. It is a canonical design system, not a product application.

## Core Rules

### 1. Use shipit_ui Components

Product agents **must** use `shipit_ui` components rather than recreating common controls:

```dart
// WRONG
ElevatedButton(onPressed: () {}, child: Text('Submit'))

// CORRECT
AppButton.primary(label: 'Submit', onPressed: () {})
```

This applies to all Material fallbacks, including `Tooltip` (use `AppTooltip`), `NavigationRail` (use `AppNavigationRail`), `NavigationBar` (use `AppBottomNavigationBar`), `AlertDialog` confirmations (use `AppConfirmDialog`), `SnackBar`/`MaterialBanner` feedback (use `AppInlineAlert`), `CircleAvatar` (use `AppAvatar`), `FilterChip` (use `AppFilterChip`), `SearchBar` (use `AppSearchField`), raw `showDatePicker` (use `AppDatePicker`) and `DataTable`/`PaginatedDataTable` (use `AppDataTable`). For low-emphasis actions use `TextButton` → `AppTextButton` and icon-only triggers use `IconButton` → `AppIconButton`.

### 2. All Design Values Come From `context.*`

The **only** sanctioned way to read a design value in product code is the token tree on `BuildContext`, whose paths mirror the Penpot token names 1:1:

```dart
context.color.bg.base            // color.bg.base
context.color.state.error.fg     // color.state.error.fg
context.space.s4                 // space.4  (16px)
context.radius.md                // radius.md (8)  · context.radius.all.md → BorderRadius
context.text.body.medium         // brightness-aware TextStyle
context.font.weight.semibold     // font.weight.semibold
context.elevation.e2             // elevation.2
context.motion.duration.fast     // motion.duration.fast · context.motion.curve.standard
context.breakpoint.desktop       // breakpoint.desktop · context.isDesktopOrLarger
context.opacity.scrim
```

Prohibited in product UI:

```dart
// WRONG — raw values
Container(color: Color(0xFF3A7BD5), padding: EdgeInsets.all(16))
// WRONG — no static token classes exist any more (AppColors, AppSpacing, AppRadius, AppTypography, … were removed)
// WRONG — branching on brightness by hand
color: Theme.of(context).brightness == Brightness.dark ? a : b

// CORRECT
Container(
  color: context.color.action.primary.bg,
  padding: EdgeInsets.all(context.space.s4),
)
```

Tokens resolve through the `AppTheme` `ThemeExtension` registered by `shipitLightTheme()` / `shipitDarkTheme()`, so the same call site is correct in both modes. Outside a `build` method (tests, pure functions) use `AppTheme.light` / `AppTheme.dark` directly.

**Adding a token:** add it to the node class under `lib/src/theme/tokens/`, to both `AppColorTokens.light` and `.dark` (for colours), and to the Penpot sets `shipit/color` and `shipit/color-dark` in the same change. Update `docs/penpot-mapping.md`.

**Customising a theme (consumers):** every node has `copyWith`; override a segment and pass it to the theme builder — never fork values:

```dart
final tokens = AppTheme.light.copyWith(
  radius: AppTheme.light.radius.copyWith(md: 12),
);
MaterialApp(theme: shipitLightTheme(tokens: tokens), ...)
```

### 3. No Arbitrary Spacing Literals

Arbitrary spacing literals are **prohibited** when a token exists:

```dart
// WRONG
padding: EdgeInsets.all(16)

// CORRECT
padding: EdgeInsets.all(context.space.s4)
```

### 3a. Loading, Error and Empty States Are Not Interchangeable

- **Loading** = an `AppSkeleton` shimmer silhouette of the content about to appear, rendered *in place*. Never a spinner, never a full-view "Loading…" screen.
- **Error** = an `AppInlineAlert.error` (dismissible, optional Retry) *next to* the content, or `AppConfirmDialog` / `AppDialog.error` for blocking decisions. Never a full-view error screen.
- **Empty** = `AppEmptyState`, the only state that replaces a content area.

```dart
// WRONG
if (loading) return Center(child: CircularProgressIndicator());
if (error != null) return AppEmptyState(title: 'Something went wrong');

// CORRECT
if (loading) return AppSkeleton.card();
return Column(children: [
  if (error != null) AppInlineAlert.error(title: error!, actionLabel: 'Retry', onAction: reload, onDismiss: clearError),
  content,
]);
```

Raw `CircularProgressIndicator` / `LinearProgressIndicator` are **prohibited** in product UI. See `docs/patterns.md` and Penpot **02 Components** (`state / loading`, `state / error`).

### 3b. Typography Uses the Bundled Inter

Use `context.text.*` styles (or the shipit themes). Hand-built `TextStyle`s must set `fontFamily: context.font.family, package: context.font.package` so the bundled Inter resolves; never set `fontFamily: 'Inter'` bare and never ship a second copy of Inter in a product.

### 3c. Form Validation Is Field-Level

Every shipit_ui input is a real `FormField`: `AppTextField`, `AppSelect` and `AppDatePicker` (`validator` / `rangeValidator`) all accept `validator`, `autovalidateMode`, `onSaved` and `errorText`. Wrap forms in `Form`, call `Form.validate()` on submit, and use `errorText` for server-side messages. Do not hand-roll error labels under fields, wrap inputs in your own `FormField`, or swap the form for an error screen.

### 4. Golden Baselines Are Binding

Changing an approved golden baseline is **not** an implementation fix. Any visual change to a golden-tested component requires:
- Design authority approval
- Corresponding design revision in Penpot
- Updated golden file in the same commit

### 5. Substantial Visual Changes Require Design Authority

Substantial component visual changes require corresponding design authority/design revision. Do not modify:
- Button shapes, sizes, or color semantics
- Typography scales
- Spacing systems
- Border radius conventions

Without an approved design revision.

### 6. Product-Agnostic Repository

This repository **must** remain product-agnostic:
- No business logic
- No product-specific screens
- No Serverpod
- No API clients
- No state management (Riverpod, Bloc, Provider, etc.)
- No routing
- No authentication
- No ShipIt Platform control-plane logic

### 7. Minimal Dependencies

Only add dependencies when absolutely necessary. The current dependency list:
- `flutter` (sdk)
- `flutter_lints` (dev)
- `flutter_test` (dev)
- `golden_toolkit` (dev, for golden tests)

Do not add Riverpod, Bloc, Provider, Serverpod, or other application architecture dependencies.

## Code Quality Rules

- Run `dart format` before every commit
- Run `flutter analyze` and fix all warnings
- Run `flutter test` and ensure all tests pass
- All meaningful components must have:
  - Widget tests
  - Accessibility-aware semantics
  - Golden coverage for important visual states
  - Deterministic keys/semantics for automation

## Adding New Components

When adding new components:
1. Add foundation tokens first (colors, spacing, typography)
2. Create the component in `lib/src/components/`
3. Export from `lib/shipit_ui.dart`
4. Add widget tests in `test/components/`
5. Add golden tests where visually significant
6. Update `docs/penpot-mapping.md`
7. Update this document if new rules are needed
