import 'package:flutter/material.dart';
import 'package:shipit_ui/src/foundation/app_colors.dart';
import 'package:shipit_ui/src/foundation/app_spacing.dart';
import 'package:shipit_ui/src/foundation/app_radius.dart';
import 'package:shipit_ui/src/foundation/app_typography.dart';

/// Select state types for AppSelect.
enum AppSelectState { default_, error, disabled }

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
    this.state = AppSelectState.default_,
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
        return Semantics(
          label: widget.label,
          button: true,
          container: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.label,
                style: AppTypography.labelMedium.copyWith(
                  color: _getLabelColor(),
                ),
              ),
              const SizedBox(height: AppSpacing.space1),
              InputDecorator(
                decoration: InputDecoration(
                  hintText:
                      widget.hint ?? 'Select ${widget.label.toLowerCase()}',
                  prefixIcon: widget.prefixIcon,
                  filled: true,
                  fillColor: _getFillColor(),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.space4,
                    vertical: AppSpacing.space2,
                  ),
                  border: _border(_getBorderColor(isError)),
                  enabledBorder: _border(_getBorderColor(isError)),
                  focusedBorder: _border(
                    isError
                        ? AppColors.stateErrorFgColor
                        : AppColors.actionPrimaryBgColor,
                    width: 2,
                  ),
                  errorBorder: _border(AppColors.stateErrorFgColor),
                  focusedErrorBorder: _border(
                    AppColors.stateErrorFgColor,
                    width: 2,
                  ),
                  disabledBorder: _border(AppColors.actionDisabledBorderColor),
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
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.fgMutedColor,
                      ),
                    ),
                    items: widget.options.map((option) {
                      return DropdownMenuItem<T>(
                        value: option.value,
                        child: Text(
                          option.label,
                          style: AppTypography.bodyMedium,
                        ),
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
                  padding: const EdgeInsets.only(top: AppSpacing.space1),
                  child: Semantics(
                    liveRegion: true,
                    child: Text(
                      errorText,
                      key: const Key('select_error'),
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.stateErrorFgColor,
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

  OutlineInputBorder _border(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.radiusMd),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  Color _getLabelColor() {
    return _isDisabled ? AppColors.fgDisabledColor : AppColors.fgSecondaryColor;
  }

  Color _getFillColor() {
    return _isDisabled
        ? AppColors.actionDisabledBgColor
        : AppColors.bgSurfaceColor;
  }

  Color _getBorderColor(bool isError) {
    if (_isDisabled) return AppColors.actionDisabledBorderColor;
    return isError ? AppColors.stateErrorFgColor : AppColors.borderDefaultColor;
  }
}

/// An option in an [AppSelect] dropdown.
class AppSelectOption<T> {
  final T value;
  final String label;

  const AppSelectOption({required this.value, required this.label});
}
