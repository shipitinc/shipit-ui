import 'package:flutter/material.dart';
import 'package:shipit_ui/src/components/app_tooltip.dart';
import 'package:shipit_ui/src/theme/app_theme_tokens.dart';

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
/// presets, and default, error, and disabled states. Participates in an
/// enclosing [Form]: [validator] / [rangeValidator] run on `Form.validate()`
/// and per [autovalidateMode]; a failing validator or an explicit [errorText]
/// switches the field into the error state and shows the message.
///
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

  /// Explicit error message; takes precedence over a validator message and
  /// switches the field into the error state.
  final String? errorText;

  /// Validates [value] in single mode (ignored in range mode).
  final FormFieldValidator<DateTime?>? validator;

  /// Validates [rangeValue] in range mode (ignored in single mode).
  final FormFieldValidator<AppDateRange?>? rangeValidator;
  final AutovalidateMode autovalidateMode;
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
    this.validator,
    this.rangeValidator,
    this.autovalidateMode = AutovalidateMode.disabled,
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

  String? _validate() =>
      _isRange ? rangeValidator?.call(rangeValue) : validator?.call(value);

  @override
  Widget build(BuildContext context) {
    return FormField<Object?>(
      initialValue: _isRange ? rangeValue : value,
      validator: (_) => _validate(),
      autovalidateMode: autovalidateMode,
      enabled: !isDisabled,
      builder: (field) {
        final color = context.color;
        final space = context.space;
        final String? message = errorText ?? field.errorText;
        final bool showError = isError || message != null;
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
                style: context.text.label.medium.copyWith(
                  color: isDisabled ? color.fg.disabled : color.fg.secondary,
                ),
              ),
              SizedBox(height: space.s1),
              _buildField(context, field, showError),
              if (message != null)
                Padding(
                  padding: EdgeInsets.only(top: space.s1),
                  child: Semantics(
                    liveRegion: true,
                    child: Text(
                      message,
                      key: const Key('date_picker_error'),
                      style: context.text.body.small.copyWith(
                        color: color.state.error.fg,
                      ),
                    ),
                  ),
                ),
              if (presets.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(top: space.s2),
                  child: Wrap(
                    spacing: space.s2,
                    runSpacing: space.s2,
                    children: [
                      for (var i = 0; i < presets.length; i++)
                        _PresetChip(
                          key: Key('date_picker_preset_$i'),
                          label: presets[i].label,
                          selected: _isPresetSelected(presets[i]),
                          onTap: isDisabled
                              ? null
                              : () => _applyPreset(field, presets[i]),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildField(
    BuildContext context,
    FormFieldState<Object?> field,
    bool showError,
  ) {
    final color = context.color;
    final space = context.space;
    final textColor = isDisabled
        ? color.fg.disabled
        : _hasValue
        ? color.fg.primary
        : color.fg.muted;
    final iconColor = isDisabled ? color.fg.disabled : color.fg.muted;
    return Material(
      key: const Key('date_picker_field'),
      color: isDisabled ? color.action.disabled.bg : color.bg.surface,
      shape: RoundedRectangleBorder(
        borderRadius: context.radius.all.md,
        side: BorderSide(color: _borderColor(color, showError)),
      ),
      child: InkWell(
        borderRadius: context.radius.all.md,
        onTap: isDisabled ? null : () => _open(context, field),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: _fieldHeight),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: space.s4,
              vertical: space.s2,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: _iconSize,
                  color: iconColor,
                ),
                SizedBox(width: space.s2),
                Expanded(
                  child: Text(
                    _displayText,
                    style: context.text.body.medium.copyWith(color: textColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (allowClear && _hasValue && !isDisabled)
                  AppTooltip(
                    message: 'Clear',
                    child: IconButton(
                      key: const Key('date_picker_clear'),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      iconSize: _iconSize,
                      color: color.fg.muted,
                      icon: const Icon(Icons.close),
                      onPressed: () => _clear(field),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _borderColor(AppColorTokens color, bool showError) {
    if (isDisabled) return color.action.disabled.border;
    if (showError) return color.state.error.fg;
    return color.border.base;
  }

  void _emitRange(FormFieldState<Object?> field, AppDateRange? r) {
    field.didChange(r);
    onRangeChanged?.call(r);
  }

  void _emitDate(FormFieldState<Object?> field, DateTime? d) {
    field.didChange(d);
    onChanged?.call(d);
  }

  void _clear(FormFieldState<Object?> field) {
    if (_isRange) {
      _emitRange(field, null);
    } else {
      _emitDate(field, null);
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

  void _applyPreset(FormFieldState<Object?> field, AppDatePreset preset) {
    final r = preset.resolve(DateTime.now());
    if (_isRange) {
      _emitRange(field, r);
    } else {
      _emitDate(field, r.start);
    }
  }

  static bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  static DateTime _clamp(DateTime d, DateTime first, DateTime last) =>
      d.isBefore(first) ? first : (d.isAfter(last) ? last : d);

  Future<void> _open(
    BuildContext context,
    FormFieldState<Object?> field,
  ) async {
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
        _emitRange(field, AppDateRange(result.start, result.end));
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
    if (result != null) _emitDate(field, result);
  }

  static ThemeData _pickerTheme(BuildContext context) {
    final base = Theme.of(context);
    final color = context.color;
    return base.copyWith(
      colorScheme: base.colorScheme.copyWith(
        primary: color.action.primary.bg,
        onPrimary: color.action.primary.fg,
        surface: color.bg.surface,
        onSurface: color.fg.primary,
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: color.bg.surface,
        shape: RoundedRectangleBorder(borderRadius: context.radius.all.xl),
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
    final chip = context.color.chip;
    final space = context.space;
    final fg = !enabled
        ? context.color.fg.disabled
        : selected
        ? chip.selected.fg
        : chip.fg;
    return Semantics(
      button: true,
      selected: selected,
      enabled: enabled,
      label: label,
      child: Material(
        color: selected ? chip.selected.bg : chip.bg,
        shape: StadiumBorder(
          side: BorderSide(
            color: selected ? chip.selected.border : chip.border,
          ),
        ),
        child: InkWell(
          customBorder: const StadiumBorder(),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: space.s3,
              vertical: space.s1,
            ),
            child: Text(
              label,
              style: context.text.label.medium.copyWith(color: fg),
            ),
          ),
        ),
      ),
    );
  }
}
