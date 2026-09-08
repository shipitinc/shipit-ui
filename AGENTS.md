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

This applies to all Material fallbacks, including `Tooltip` (use `AppTooltip`), `NavigationRail` (use `AppNavigationRail`), `AlertDialog` confirmations (use `AppConfirmDialog`), `CircleAvatar` (use `AppAvatar`), `FilterChip` (use `AppFilterChip`), `SearchBar` (use `AppSearchField`), raw `showDatePicker` (use `AppDatePicker`) and `DataTable`/`PaginatedDataTable` (use `AppDataTable`).

### 2. No Arbitrary Hex Colors

Arbitrary hex colors are **prohibited** in product UI unless explicitly justified:

```dart
// WRONG
Container(color: Color(0xFF3A7BD5))

// CORRECT
Container(color: AppColors.actionPrimary)
```

If a color does not exist in `AppColors`, add it to the foundation first.

### 3. No Arbitrary Spacing Literals

Arbitrary spacing literals should be **avoided** when a token exists:

```dart
// WRONG
padding: EdgeInsets.all(16)

// CORRECT
padding: EdgeInsets.all(AppSpacing.md)
```

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
