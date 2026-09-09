import 'package:flutter/material.dart';
import 'package:shipit_ui/src/theme/app_theme_tokens.dart';

/// Select state types for AppSelect.
enum AppSelectState { base, error, disabled }

/// A reusable select/dropdown widget following the shipit_ui design system.
///
/// Supports default, error, and disabled states. Participates in an enclosing
/// [Form]: [validator] receives the current [value] on `Form.validate()` /
/// `FormState.save()` and per [autovalidateMode]. A failing validator or an
/// explicit [errorText] switches the field into the error visual state and
/// shows the message beneath it.
///
/// Based on approved Penpot design tokens.
///
/// ## Semantics
///
/// Uses [Semantics] with `dropdown` and `label` for accessibility automation.
class AppSelect<T> extends StatefulWidget {
  final String label;
  final List<AppSelectOption<T>> options;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final String? hint;
  final AppSelectState state;
  final Widget? prefixIcon;

  /// Explicit error message; takes precedence over a validator message.
  final String? errorText;
  final FormFieldValidator<T?>? validator;
  final AutovalidateMode autovalidateMode;
  final FormFieldSetter<T?>? onSaved;
  final Key? semanticLabel;

  const AppSelect({
    super.key,
    required this.label,
    required this.options,
    this.value,
    this.onChanged,
    this.hint,
    this.state = AppSelectState.base,
    this.prefixIcon,
    this.errorText,
    this.validator,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.onSaved,
    this.semanticLabel,
  });

  @override
  State<AppSelect<T>> createState() => _AppSelectState<T>();
}

class _AppSelectState<T> extends State<AppSelect<T>> {
  bool get _isDisabled => widget.state == AppSelectState.disabled;

  @override
  Widget build(BuildContext context) {
    return FormField<T?>(
      initialValue: widget.value,
      validator: (_) => widget.validator?.call(widget.value),
      onSaved: (_) => widget.onSaved?.call(widget.value),
      autovalidateMode: widget.autovalidateMode,
      enabled: !_isDisabled,
      builder: (field) {
        final String? errorText = widget.errorText ?? field.errorText;
        final bool isError =
            errorText != null || widget.state == AppSelectState.error;
        final color = context.color;
        final space = context.space;
        final text = context.text;
        return Semantics(
          label: widget.label,
          button: true,
          container: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.label,
                style: text.label.medium.copyWith(color: _getLabelColor(color)),
              ),
              SizedBox(height: space.s1),
              InputDecorator(
                decoration: InputDecoration(
                  hintText:
                      widget.hint ?? 'Select ${widget.label.toLowerCase()}',
                  prefixIcon: widget.prefixIcon,
                  filled: true,
                  fillColor: _getFillColor(color),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: space.s4,
                    vertical: space.s2,
                  ),
                  border: _border(context, _getBorderColor(color, isError)),
                  enabledBorder: _border(
                    context,
                    _getBorderColor(color, isError),
                  ),
                  focusedBorder: _border(
                    context,
                    isError ? color.state.error.fg : color.action.primary.bg,
                    width: 2,
                  ),
                  errorBorder: _border(context, color.state.error.fg),
                  focusedErrorBorder: _border(
                    context,
                    color.state.error.fg,
                    width: 2,
                  ),
                  disabledBorder: _border(
                    context,
                    color.action.disabled.border,
                  ),
                ),
                isEmpty: widget.value == null,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<T>(
                    key: widget.semanticLabel,
                    value: widget.value,
                    isExpanded: true,
                    isDense: true,
                    hint: Text(
                      widget.hint ?? 'Select ${widget.label.toLowerCase()}',
                      style: text.body.medium.copyWith(color: color.fg.muted),
                    ),
                    items: widget.options.map((option) {
                      return DropdownMenuItem<T>(
                        value: option.value,
                        child: Text(option.label, style: text.body.medium),
                      );
                    }).toList(),
                    onChanged: _isDisabled
                        ? null
                        : (value) {
                            field.didChange(value);
                            widget.onChanged?.call(value);
                          },
                  ),
                ),
              ),
              if (errorText != null)
                Padding(
                  padding: EdgeInsets.only(top: space.s1),
                  child: Semantics(
                    liveRegion: true,
                    child: Text(
                      errorText,
                      key: const Key('select_error'),
                      style: text.body.small.copyWith(
                        color: color.state.error.fg,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  OutlineInputBorder _border(
    BuildContext context,
    Color color, {
    double width = 1,
  }) {
    return OutlineInputBorder(
      borderRadius: context.radius.all.md,
      borderSide: BorderSide(color: color, width: width),
    );
  }

  Color _getLabelColor(AppColorTokens color) {
    return _isDisabled ? color.fg.disabled : color.fg.secondary;
  }

  Color _getFillColor(AppColorTokens color) {
    return _isDisabled ? color.action.disabled.bg : color.bg.surface;
  }

  Color _getBorderColor(AppColorTokens color, bool isError) {
    if (_isDisabled) return color.action.disabled.border;
    return isError ? color.state.error.fg : color.border.base;
  }
}

/// An option in an [AppSelect] dropdown.
class AppSelectOption<T> {
  final T value;
  final String label;

  const AppSelectOption({required this.value, required this.label});
}
