import 'package:flutter/material.dart';
import 'package:shipit_ui/src/foundation/app_colors.dart';
import 'package:shipit_ui/src/foundation/app_spacing.dart';
import 'package:shipit_ui/src/foundation/app_radius.dart';
import 'package:shipit_ui/src/foundation/app_typography.dart';

/// Selection modes for [AppDatePicker].
enum AppDatePickerMode { single, range }

/// An inclusive date range used by [AppDatePicker] in range mode.
class AppDateRange {
  final DateTime start;
  final DateTime end;

  const AppDateRange(this.start, this.end);

  @override
  bool operator ==(Object other) =>
      other is AppDateRange && other.start == start && other.end == end;

  @override
  int get hashCode => Object.hash(start, end);

  @override
  String toString() => 'AppDateRange($start, $end)';
}

/// A quick-select preset rendered as a pill chip below an [AppDatePicker].
class AppDatePreset {
  final String label;
  final AppDateRange Function(DateTime now) resolve;

  const AppDatePreset({required this.label, required this.resolve});

  static const AppDatePreset today = AppDatePreset(
    label: 'Today',
    resolve: _today,
  );
  static const AppDatePreset last7Days = AppDatePreset(
    label: 'Last 7 days',
    resolve: _last7Days,
  );
  static const AppDatePreset last30Days = AppDatePreset(
    label: 'Last 30 days',
    resolve: _last30Days,
  );
  static const AppDatePreset thisMonth = AppDatePreset(
    label: 'This month',
    resolve: _thisMonth,
  );

  static List<AppDatePreset> get defaults => const [
    today,
    last7Days,
    last30Days,
    thisMonth,
  ];

  static DateTime _day(DateTime d) => DateTime(d.year, d.month, d.day);
  static AppDateRange _today(DateTime now) =>
      AppDateRange(_day(now), _day(now));
  static AppDateRange _lastDays(DateTime now, int days) => AppDateRange(
    DateTime(now.year, now.month, now.day - (days - 1)),
    _day(now),
  );
  static AppDateRange _last7Days(DateTime now) => _lastDays(now, 7);
  static AppDateRange _last30Days(DateTime now) => _lastDays(now, 30);
  static AppDateRange _thisMonth(DateTime now) => AppDateRange(
    DateTime(now.year, now.month),
    DateTime(now.year, now.month + 1, 0),
  );
}

/// A date picker field following the shipit_ui design system.
///
/// Supports single-date and date-range selection, optional quick-select
/// presets, and default, error, and disabled states.
/// Based on approved Penpot design tokens.
///
/// ## Semantics
///
/// Uses [Semantics] with `button: true`, `label` set to [label] and `value`
/// set to the displayed text for accessibility automation.
class AppDatePicker extends StatelessWidget {
  final String label;
  final String? hint;
  final AppDatePickerMode mode;
  final DateTime? value;
  final AppDateRange? rangeValue;
  final ValueChanged<DateTime?>? onChanged;
  final ValueChanged<AppDateRange?>? onRangeChanged;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final List<AppDatePreset> presets;
  final bool isDisabled;
  final bool isError;
  final String? errorText;
  final String Function(DateTime) formatDate;
  final bool allowClear;
  final Key? semanticLabel;

  static const double _fieldHeight = 44;
  static const double _iconSize = 20;

  const AppDatePicker({
    super.key,
    required this.label,
    this.hint,
    this.mode = AppDatePickerMode.single,
    this.value,
    this.rangeValue,
    this.onChanged,
    this.onRangeChanged,
    this.firstDate,
    this.lastDate,
    this.presets = const [],
    this.isDisabled = false,
    this.isError = false,
    this.errorText,
    this.formatDate = defaultFormat,
    this.allowClear = true,
    this.semanticLabel,
  });

  /// Formats [date] as zero-padded `yyyy-MM-dd`.
  static String defaultFormat(DateTime date) {
    final y = date.year.toString().padLeft(4, '0');
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  bool get _isRange => mode == AppDatePickerMode.range;
  bool get _hasValue => _isRange ? rangeValue != null : value != null;

  String? get _displayValue {
    if (_isRange) {
      final r = rangeValue;
      return r == null ? null : '${formatDate(r.start)} – ${formatDate(r.end)}';
    }
    final v = value;
    return v == null ? null : formatDate(v);
  }

  String get _displayText =>
      _displayValue ?? hint ?? (_isRange ? 'Select dates' : 'Select date');

  @override
  Widget build(BuildContext context) {
    return Semantics(
      key: semanticLabel,
      button: true,
      enabled: !isDisabled,
      label: label,
      value: _displayText,
      container: true,
      explicitChildNodes: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: AppTypography.labelMedium.copyWith(
              color: isDisabled
                  ? AppColors.fgDisabledColor
                  : AppColors.fgSecondaryColor,
            ),
          ),
          const SizedBox(height: AppSpacing.space1),
          _buildField(context),
          if (isError && errorText != null)
            Padding(
              padding: const EdgeInsets.only(top: AppSpacing.space1),
              child: Text(
                errorText!,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.stateErrorFgColor,
                ),
              ),
            ),
          if (presets.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: AppSpacing.space2),
              child: Wrap(
                spacing: AppSpacing.space2,
                runSpacing: AppSpacing.space2,
                children: [
                  for (var i = 0; i < presets.length; i++)
                    _PresetChip(
                      key: Key('date_picker_preset_$i'),
                      label: presets[i].label,
                      selected: _isPresetSelected(presets[i]),
                      onTap: isDisabled ? null : () => _applyPreset(presets[i]),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildField(BuildContext context) {
    final textColor = isDisabled
        ? AppColors.fgDisabledColor
        : _hasValue
        ? AppColors.fgPrimaryColor
        : AppColors.fgMutedColor;
    final iconColor = isDisabled
        ? AppColors.fgDisabledColor
        : AppColors.fgMutedColor;
    return Material(
      key: const Key('date_picker_field'),
      color: isDisabled
          ? AppColors.actionDisabledBgColor
          : AppColors.bgSurfaceColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.radiusMd),
        side: BorderSide(color: _borderColor),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.radiusMd),
        onTap: isDisabled ? null : () => _open(context),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: _fieldHeight),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.space4,
              vertical: AppSpacing.space2,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: _iconSize,
                  color: iconColor,
                ),
                const SizedBox(width: AppSpacing.space2),
                Expanded(
                  child: Text(
                    _displayText,
                    style: AppTypography.bodyMedium.copyWith(color: textColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (allowClear && _hasValue && !isDisabled)
                  IconButton(
                    key: const Key('date_picker_clear'),
                    tooltip: 'Clear',
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    iconSize: _iconSize,
                    color: AppColors.fgMutedColor,
                    icon: const Icon(Icons.close),
                    onPressed: _clear,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color get _borderColor {
    if (isDisabled) return AppColors.actionDisabledBorderColor;
    if (isError) return AppColors.stateErrorFgColor;
    return AppColors.borderDefaultColor;
  }

  void _clear() {
    if (_isRange) {
      onRangeChanged?.call(null);
    } else {
      onChanged?.call(null);
    }
  }

  bool _isPresetSelected(AppDatePreset preset) {
    final r = preset.resolve(DateTime.now());
    if (_isRange) {
      final v = rangeValue;
      return v != null && _sameDay(v.start, r.start) && _sameDay(v.end, r.end);
    }
    final v = value;
    return v != null && _sameDay(v, r.start);
  }

  void _applyPreset(AppDatePreset preset) {
    final r = preset.resolve(DateTime.now());
    if (_isRange) {
      onRangeChanged?.call(r);
    } else {
      onChanged?.call(r.start);
    }
  }

  static bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  static DateTime _clamp(DateTime d, DateTime first, DateTime last) =>
      d.isBefore(first) ? first : (d.isAfter(last) ? last : d);

  Future<void> _open(BuildContext context) async {
    final now = DateTime.now();
    final first = firstDate ?? DateTime(now.year - 100, now.month, now.day);
    final last = lastDate ?? DateTime(now.year + 100, now.month, now.day);
    Widget themed(BuildContext context, Widget? child) =>
        Theme(data: _pickerTheme(context), child: child!);
    if (_isRange) {
      final r = rangeValue;
      final result = await showDateRangePicker(
        context: context,
        firstDate: first,
        lastDate: last,
        initialDateRange: r == null
            ? null
            : DateTimeRange(
                start: _clamp(r.start, first, last),
                end: _clamp(r.end, first, last),
              ),
        builder: themed,
      );
      if (result != null) {
        onRangeChanged?.call(AppDateRange(result.start, result.end));
      }
      return;
    }
    final result = await showDatePicker(
      context: context,
      firstDate: first,
      lastDate: last,
      initialDate: _clamp(value ?? now, first, last),
      builder: themed,
    );
    if (result != null) onChanged?.call(result);
  }

  static ThemeData _pickerTheme(BuildContext context) {
    final base = Theme.of(context);
    return base.copyWith(
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.actionPrimaryBgColor,
        onPrimary: AppColors.actionPrimaryFgColor,
        surface: AppColors.bgSurfaceColor,
        onSurface: AppColors.fgPrimaryColor,
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: AppColors.bgSurfaceColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.radiusXl),
        ),
      ),
    );
  }
}

class _PresetChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  const _PresetChip({
    super.key,
    required this.label,
    required this.selected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    final fg = !enabled
        ? AppColors.fgDisabledColor
        : selected
        ? AppColors.chipSelectedFgColor
        : AppColors.chipFgColor;
    return Semantics(
      button: true,
      selected: selected,
      enabled: enabled,
      label: label,
      child: Material(
        color: selected ? AppColors.chipSelectedBgColor : AppColors.chipBgColor,
        shape: StadiumBorder(
          side: BorderSide(
            color: selected
                ? AppColors.chipSelectedBorderColor
                : AppColors.chipBorderColor,
          ),
        ),
        child: InkWell(
          customBorder: const StadiumBorder(),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.space3,
              vertical: AppSpacing.space1,
            ),
            child: Text(
              label,
              style: AppTypography.labelMedium.copyWith(color: fg),
            ),
          ),
        ),
      ),
    );
  }
}
