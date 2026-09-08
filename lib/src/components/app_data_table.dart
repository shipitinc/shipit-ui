import 'package:flutter/material.dart';
import 'package:shipit_ui/src/components/app_shimmer.dart';
import 'package:shipit_ui/src/components/app_empty_state.dart';
import 'package:shipit_ui/src/components/app_tooltip.dart';
import 'package:shipit_ui/src/foundation/app_colors.dart';
import 'package:shipit_ui/src/foundation/app_radius.dart';
import 'package:shipit_ui/src/foundation/app_spacing.dart';
import 'package:shipit_ui/src/foundation/app_typography.dart';

/// A column definition for an [AppDataTable].
///
/// The column is sortable when [comparator] is provided. When [width] is set
/// the column has a fixed width; otherwise it expands with [flex].
class AppDataColumn<T> {
  final String label;
  final Widget Function(BuildContext context, T row) cellBuilder;
  final Comparator<T>? comparator;
  final bool numeric;
  final double? width;
  final int flex;
  final String? tooltip;

  const AppDataColumn({
    required this.label,
    required this.cellBuilder,
    this.comparator,
    this.numeric = false,
    this.width,
    this.flex = 1,
    this.tooltip,
  });

  /// Creates a column whose cells render [value] as single-line body text.
  AppDataColumn.text({
    required this.label,
    required String Function(T row) value,
    this.comparator,
    this.numeric = false,
    this.width,
    this.flex = 1,
    this.tooltip,
  }) : cellBuilder = ((context, row) => Text(
         value(row),
         maxLines: 1,
         overflow: TextOverflow.ellipsis,
         textAlign: numeric ? TextAlign.right : TextAlign.left,
         style: AppTypography.bodyMedium.copyWith(
           color: AppColors.fgPrimaryColor,
         ),
       ));

  bool get sortable => comparator != null;
}

/// A reusable, cross-product data table following the shipit_ui design
/// system.
///
/// Renders a header row, body rows and a pagination footer built from plain
/// layout primitives. Filtering ([AppDataTable.rowFilter]), sorting and
/// pagination are performed client-side. Shows shimmer placeholders while
/// [isLoading] and an [AppEmptyState] when there are no rows to display.
///
/// Based on approved Penpot design tokens.
///
/// ## Semantics
///
/// The root is labelled 'Data table'. Header cells are marked as headers,
/// sortable headers are exposed as buttons, and rows are exposed as buttons
/// when [onRowTap] is provided.
class AppDataTable<T> extends StatefulWidget {
  final List<AppDataColumn<T>> columns;
  final List<T> rows;
  final bool Function(T row)? rowFilter;
  final int? sortColumnIndex;
  final bool sortAscending;
  final void Function(int columnIndex, bool ascending)? onSort;
  final int rowsPerPage;
  final ValueChanged<int>? onPageChanged;
  final ValueChanged<T>? onRowTap;
  final bool isLoading;
  final String emptyTitle;
  final String? emptyDescription;
  final Key? semanticLabel;

  const AppDataTable({
    super.key,
    required this.columns,
    required this.rows,
    this.rowFilter,
    this.sortColumnIndex,
    this.sortAscending = true,
    this.onSort,
    this.rowsPerPage = 10,
    this.onPageChanged,
    this.onRowTap,
    this.isLoading = false,
    this.emptyTitle = 'No results',
    this.emptyDescription,
    this.semanticLabel,
  }) : assert(columns.length > 0, 'AppDataTable requires at least 1 column'),
       assert(rowsPerPage > 0, 'rowsPerPage must be positive');

  static const double headerHeight = AppSpacing.space10 + AppSpacing.space1;
  static const double rowHeight = AppSpacing.space12;
  static const double footerHeight = AppSpacing.space12;
  static const int loadingRowCount = 5;

  @override
  State<AppDataTable<T>> createState() => _AppDataTableState<T>();
}

class _AppDataTableState<T> extends State<AppDataTable<T>> {
  int? _sortColumnIndex;
  bool _sortAscending = true;
  int _page = 0;
  bool _pageChanged = false;

  @override
  void initState() {
    super.initState();
    _sortColumnIndex = widget.sortColumnIndex;
    _sortAscending = widget.sortAscending;
  }

  List<T> get _visibleRows {
    final List<T> rows = widget.rowFilter == null
        ? List<T>.of(widget.rows)
        : widget.rows.where(widget.rowFilter!).toList();
    final int? index = _sortColumnIndex;
    if (index != null && index < widget.columns.length) {
      final Comparator<T>? comparator = widget.columns[index].comparator;
      if (comparator != null) {
        rows.sort(_sortAscending ? comparator : (a, b) => comparator(b, a));
      }
    }
    return rows;
  }

  void _handleSort(int index) {
    setState(() {
      if (_sortColumnIndex == index) {
        _sortAscending = !_sortAscending;
      } else {
        _sortColumnIndex = index;
        _sortAscending = true;
      }
    });
    widget.onSort?.call(index, _sortAscending);
  }

  void _goToPage(int page) {
    setState(() {
      _page = page;
      _pageChanged = true;
    });
    widget.onPageChanged?.call(page);
  }

  @override
  Widget build(BuildContext context) {
    final List<T> rows = _visibleRows;
    final int total = rows.length;
    final int pageCount = total == 0
        ? 1
        : ((total + widget.rowsPerPage - 1) ~/ widget.rowsPerPage);
    final int page = _page.clamp(0, pageCount - 1);
    final int start = page * widget.rowsPerPage;
    final int end = (start + widget.rowsPerPage).clamp(0, total);
    final List<T> pageRows = rows.sublist(start.clamp(0, total), end);
    final bool showFooter =
        !widget.isLoading && (total > widget.rowsPerPage || _pageChanged);

    return Semantics(
      key: widget.semanticLabel,
      container: true,
      label: 'Data table',
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.bgSurfaceColor,
          borderRadius: AppRadius.borderRadiusLg,
          border: Border.all(color: AppColors.tableBorderColor),
        ),
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(),
              if (widget.isLoading)
                for (var i = 0; i < AppDataTable.loadingRowCount; i++)
                  _buildLoadingRow(i)
              else if (total == 0)
                AppEmptyState(
                  title: widget.emptyTitle,
                  message: widget.emptyDescription,
                )
              else
                for (var i = 0; i < pageRows.length; i++)
                  _buildRow(context, i, pageRows[i]),
              if (showFooter)
                _buildFooter(
                  start: total == 0 ? 0 : start + 1,
                  end: end,
                  total: total,
                  page: page,
                  pageCount: pageCount,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sized(AppDataColumn<T> column, Widget child) {
    if (column.width != null) {
      return SizedBox(width: column.width, child: child);
    }
    return Expanded(flex: column.flex, child: child);
  }

  Widget _buildHeader() {
    return Container(
      height: AppDataTable.headerHeight,
      decoration: const BoxDecoration(
        color: AppColors.tableHeaderBgColor,
        border: Border(bottom: BorderSide(color: AppColors.tableBorderColor)),
      ),
      child: Row(
        children: [
          for (var i = 0; i < widget.columns.length; i++)
            _sized(widget.columns[i], _buildHeaderCell(i)),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(int index) {
    final AppDataColumn<T> column = widget.columns[index];
    final bool active = _sortColumnIndex == index && column.sortable;
    final Widget label = Text(
      column.label,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: column.numeric ? TextAlign.right : TextAlign.left,
      style: AppTypography.labelMedium.copyWith(
        color: AppColors.fgSecondaryColor,
        fontWeight: AppTypography.fontWeightSemibold,
      ),
    );
    final Widget? icon = column.sortable
        ? Icon(
            active
                ? (_sortAscending ? Icons.arrow_upward : Icons.arrow_downward)
                : Icons.unfold_more,
            size: AppSpacing.space4,
            color: active
                ? AppColors.actionPrimaryBgColor
                : AppColors.fgMutedColor,
          )
        : null;

    Widget content = Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space4),
      child: Row(
        mainAxisAlignment: column.numeric
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (column.numeric && icon != null) ...[
            icon,
            const SizedBox(width: AppSpacing.space1),
          ],
          Flexible(child: label),
          if (!column.numeric && icon != null) ...[
            const SizedBox(width: AppSpacing.space1),
            icon,
          ],
        ],
      ),
    );

    if (column.sortable) {
      content = InkWell(
        key: Key('table_sort_$index'),
        onTap: () => _handleSort(index),
        hoverColor: AppColors.tableRowHoverColor,
        child: content,
      );
    }
    if (column.tooltip != null) {
      content = AppTooltip(message: column.tooltip!, child: content);
    }

    return Semantics(
      header: true,
      button: column.sortable,
      child: SizedBox(height: AppDataTable.headerHeight, child: content),
    );
  }

  Widget _buildRow(BuildContext context, int index, T row) {
    final VoidCallback? onTap = widget.onRowTap == null
        ? null
        : () => widget.onRowTap!(row);
    return Semantics(
      button: onTap != null,
      child: InkWell(
        key: Key('table_row_$index'),
        onTap: onTap,
        hoverColor: AppColors.tableRowHoverColor,
        child: Container(
          height: AppDataTable.rowHeight,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: AppColors.tableBorderColor),
            ),
          ),
          child: Row(
            children: [
              for (final column in widget.columns)
                _sized(
                  column,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.space4,
                    ),
                    child: Align(
                      alignment: column.numeric
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: column.cellBuilder(context, row),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingRow(int index) {
    return Container(
      key: Key('table_loading_row_$index'),
      height: AppDataTable.rowHeight,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.tableBorderColor)),
      ),
      child: Row(
        children: [
          for (final column in widget.columns)
            _sized(
              column,
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.space4,
                ),
                child: Align(
                  alignment: column.numeric
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: AppShimmer(
                    initialProgress: 0.5,
                    child: Container(
                      height: AppSpacing.space4,
                      width: column.numeric
                          ? AppSpacing.space10
                          : AppSpacing.space16 + AppSpacing.space10,
                      decoration: const BoxDecoration(
                        color: AppColors.shimmerBaseColor,
                        borderRadius: AppRadius.borderRadiusSm,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFooter({
    required int start,
    required int end,
    required int total,
    required int page,
    required int pageCount,
  }) {
    final bool canPrev = page > 0;
    final bool canNext = page < pageCount - 1;
    return Container(
      height: AppDataTable.footerHeight,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space2),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.tableBorderColor)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '$start–$end of $total',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.fgSecondaryColor,
            ),
          ),
          const SizedBox(width: AppSpacing.space2),
          _pagerButton(
            key: const Key('table_prev'),
            icon: Icons.chevron_left,
            label: 'Previous page',
            onPressed: canPrev ? () => _goToPage(page - 1) : null,
          ),
          _pagerButton(
            key: const Key('table_next'),
            icon: Icons.chevron_right,
            label: 'Next page',
            onPressed: canNext ? () => _goToPage(page + 1) : null,
          ),
        ],
      ),
    );
  }

  Widget _pagerButton({
    required Key key,
    required IconData icon,
    required String label,
    required VoidCallback? onPressed,
  }) {
    return Semantics(
      label: label,
      child: IconButton(
        key: key,
        onPressed: onPressed,
        iconSize: AppSpacing.space5,
        splashRadius: AppSpacing.space5,
        color: AppColors.fgSecondaryColor,
        disabledColor: AppColors.actionDisabledFgColor,
        hoverColor: AppColors.tableRowHoverColor,
        icon: Icon(icon),
      ),
    );
  }
}
