import 'package:flutter/material.dart';
import 'package:shipit_ui/src/components/app_filter_chip.dart';
import 'package:shipit_ui/src/foundation/app_colors.dart';
import 'package:shipit_ui/src/foundation/app_elevation.dart';
import 'package:shipit_ui/src/foundation/app_radius.dart';
import 'package:shipit_ui/src/foundation/app_spacing.dart';
import 'package:shipit_ui/src/foundation/app_typography.dart';

/// A single filter shown beneath an [AppSearchField].
class AppSearchFilter {
  final String label;
  final bool selected;
  final IconData? icon;

  const AppSearchFilter({
    required this.label,
    this.selected = false,
    this.icon,
  });
}

/// A search input with optional filter chips and recent searches following
/// the shipit_ui design system.
///
/// Shows a clear button while text is present, renders [filters] as a wrap
/// of [AppFilterChip] below the field, and surfaces [recentSearches] inline
/// while the field is focused and empty.
/// Based on approved Penpot design tokens.
///
/// ## Semantics
///
/// Uses [Semantics] with `textField: true` and `label` set to [hint].
/// The clear button uses `Key('search_field_clear')` and each recent row
/// uses `Key('search_recent_$index')` for automation.
class AppSearchField extends StatefulWidget {
  final String hint;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;
  final List<AppSearchFilter> filters;
  final ValueChanged<int>? onFilterToggled;
  final List<String> recentSearches;
  final ValueChanged<String>? onRecentSelected;
  final bool autofocus;
  final bool enabled;
  final Key? semanticLabel;

  const AppSearchField({
    super.key,
    this.hint = 'Search',
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.filters = const [],
    this.onFilterToggled,
    this.recentSearches = const [],
    this.onRecentSelected,
    this.autofocus = false,
    this.enabled = true,
    this.semanticLabel,
  });

  static const Key clearKey = Key('search_field_clear');
  static const int maxRecents = 5;

  static Key recentKey(int index) => Key('search_recent_$index');

  @override
  State<AppSearchField> createState() => _AppSearchFieldState();
}

class _AppSearchFieldState extends State<AppSearchField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void didUpdateWidget(AppSearchField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      if (oldWidget.controller == null) _controller.dispose();
      _controller = widget.controller ?? TextEditingController();
    }
    if (widget.focusNode != oldWidget.focusNode) {
      if (oldWidget.focusNode == null) _focusNode.dispose();
      _focusNode = widget.focusNode ?? FocusNode();
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    if (widget.focusNode == null) _focusNode.dispose();
    super.dispose();
  }

  void _clear() {
    _controller.clear();
    widget.onChanged?.call('');
    widget.onClear?.call();
  }

  void _selectRecent(String value) {
    _controller.text = value;
    _controller.selection = TextSelection.collapsed(offset: value.length);
    widget.onChanged?.call(value);
    widget.onRecentSelected?.call(value);
  }

  OutlineInputBorder _border(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: AppRadius.borderRadiusMd,
      borderSide: BorderSide(color: color, width: width),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      key: widget.semanticLabel,
      textField: true,
      label: widget.hint,
      container: true,
      child: ListenableBuilder(
        listenable: Listenable.merge([_controller, _focusNode]),
        builder: (context, _) {
          final bool hasText = _controller.text.isNotEmpty;
          final bool showRecents =
              _focusNode.hasFocus &&
              !hasText &&
              widget.recentSearches.isNotEmpty;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _controller,
                focusNode: _focusNode,
                enabled: widget.enabled,
                autofocus: widget.autofocus,
                textInputAction: TextInputAction.search,
                onChanged: widget.onChanged,
                onSubmitted: widget.onSubmitted,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.fgPrimaryColor,
                ),
                decoration: InputDecoration(
                  hintText: widget.hint,
                  hintStyle: AppTypography.bodyMedium.copyWith(
                    color: AppColors.fgMutedColor,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    size: AppSpacing.space5,
                    color: AppColors.fgMutedColor,
                  ),
                  suffixIcon: hasText
                      ? IconButton(
                          key: AppSearchField.clearKey,
                          tooltip: 'Clear',
                          icon: const Icon(
                            Icons.close,
                            size: AppSpacing.space5,
                            color: AppColors.fgMutedColor,
                          ),
                          onPressed: widget.enabled ? _clear : null,
                        )
                      : null,
                  filled: true,
                  fillColor: AppColors.bgSurfaceColor,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.space4,
                    vertical: AppSpacing.space2,
                  ),
                  border: _border(AppColors.borderDefaultColor),
                  enabledBorder: _border(AppColors.borderDefaultColor),
                  focusedBorder: _border(
                    AppColors.actionPrimaryBgColor,
                    width: 2,
                  ),
                  disabledBorder: _border(AppColors.actionDisabledBorderColor),
                ),
              ),
              if (showRecents)
                Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.space1),
                  child: _RecentSearchesPanel(
                    recents: widget.recentSearches
                        .take(AppSearchField.maxRecents)
                        .toList(),
                    onSelected: _selectRecent,
                  ),
                ),
              if (widget.filters.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.space2),
                  child: Wrap(
                    spacing: AppSpacing.space2,
                    runSpacing: AppSpacing.space2,
                    children: [
                      for (var i = 0; i < widget.filters.length; i++)
                        AppFilterChip(
                          label: widget.filters[i].label,
                          selected: widget.filters[i].selected,
                          icon: widget.filters[i].icon,
                          semanticLabel: Key('search_filter_$i'),
                          onSelected: widget.onFilterToggled == null
                              ? null
                              : (_) => widget.onFilterToggled!(i),
                        ),
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _RecentSearchesPanel extends StatelessWidget {
  final List<String> recents;
  final ValueChanged<String> onSelected;

  const _RecentSearchesPanel({required this.recents, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.bgSurfaceColor,
        borderRadius: AppRadius.borderRadiusMd,
        border: Border.all(color: AppColors.borderDefaultColor),
        boxShadow: AppElevation.elevation1,
      ),
      child: Material(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < recents.length; i++)
              Semantics(
                key: AppSearchField.recentKey(i),
                button: true,
                label: recents[i],
                child: InkWell(
                  onTap: () => onSelected(recents[i]),
                  hoverColor: AppColors.bgSubtleColor,
                  child: SizedBox(
                    height: AppSpacing.space10,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.space4,
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.history,
                            size: AppSpacing.space4,
                            color: AppColors.fgMutedColor,
                          ),
                          const SizedBox(width: AppSpacing.space3),
                          Expanded(
                            child: ExcludeSemantics(
                              child: Text(
                                recents[i],
                                overflow: TextOverflow.ellipsis,
                                style: AppTypography.bodyMedium.copyWith(
                                  color: AppColors.fgPrimaryColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
