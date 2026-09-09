import 'package:flutter/material.dart';
import 'package:shipit_ui/src/components/app_filter_chip.dart';
import 'package:shipit_ui/src/theme/app_theme_tokens.dart';

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
      borderRadius: context.radius.all.md,
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
          final color = context.color;
          final space = context.space;
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
                style: context.text.body.medium.copyWith(
                  color: color.fg.primary,
                ),
                decoration: InputDecoration(
                  hintText: widget.hint,
                  hintStyle: context.text.body.medium.copyWith(
                    color: color.fg.muted,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    size: space.s5,
                    color: color.fg.muted,
                  ),
                  suffixIcon: hasText
                      ? IconButton(
                          key: AppSearchField.clearKey,
                          tooltip: 'Clear',
                          icon: Icon(
                            Icons.close,
                            size: space.s5,
                            color: color.fg.muted,
                          ),
                          onPressed: widget.enabled ? _clear : null,
                        )
                      : null,
                  filled: true,
                  fillColor: color.bg.surface,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: space.s4,
                    vertical: space.s2,
                  ),
                  border: _border(color.border.base),
                  enabledBorder: _border(color.border.base),
                  focusedBorder: _border(color.action.primary.bg, width: 2),
                  disabledBorder: _border(color.action.disabled.border),
                ),
              ),
              if (showRecents)
                Padding(
                  padding: EdgeInsets.only(top: space.s1),
                  child: _RecentSearchesPanel(
                    recents: widget.recentSearches
                        .take(AppSearchField.maxRecents)
                        .toList(),
                    onSelected: _selectRecent,
                  ),
                ),
              if (widget.filters.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(top: space.s2),
                  child: Wrap(
                    spacing: space.s2,
                    runSpacing: space.s2,
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
    final color = context.color;
    final space = context.space;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: color.bg.surface,
        borderRadius: context.radius.all.md,
        border: Border.all(color: color.border.base),
        boxShadow: context.elevation.e1,
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
                  hoverColor: color.bg.subtle,
                  child: SizedBox(
                    height: space.s10,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: space.s4),
                      child: Row(
                        children: [
                          Icon(
                            Icons.history,
                            size: space.s4,
                            color: color.fg.muted,
                          ),
                          SizedBox(width: space.s3),
                          Expanded(
                            child: ExcludeSemantics(
                              child: Text(
                                recents[i],
                                overflow: TextOverflow.ellipsis,
                                style: context.text.body.medium.copyWith(
                                  color: color.fg.primary,
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
