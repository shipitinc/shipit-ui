import 'package:flutter/material.dart';
import 'package:shipit_ui/src/foundation/app_colors.dart';
import 'package:shipit_ui/src/foundation/app_spacing.dart';
import 'package:shipit_ui/src/foundation/app_radius.dart';
import 'package:shipit_ui/src/foundation/app_typography.dart';

/// Select state types for AppSelect.
enum AppSelectState { default_, error, disabled }

/// A reusable select/dropdown widget following the shipit_ui design system.
///
/// Supports default, error, and disabled states.
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
    this.semanticLabel,
  });

  @override
  State<AppSelect<T>> createState() => _AppSelectState<T>();
}

class _AppSelectState<T> extends State<AppSelect<T>> {
  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.label,
      button: true,
      container: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: AppTypography.labelMedium.copyWith(color: _getLabelColor()),
          ),
          const SizedBox(height: AppSpacing.space1),
          InputDecorator(
            decoration: InputDecoration(
              hintText: widget.hint ?? 'Select ${widget.label.toLowerCase()}',
              prefixIcon: widget.prefixIcon,
              filled: true,
              fillColor: _getFillColor(),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.space4,
                vertical: AppSpacing.space2,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.radiusMd),
                borderSide: BorderSide(color: _getBorderColor()),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.radiusMd),
                borderSide: BorderSide(color: _getBorderColor()),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.radiusMd),
                borderSide: BorderSide(
                  color: widget.state == AppSelectState.error
                      ? AppColors.stateErrorFgColor
                      : AppColors.actionPrimaryBgColor,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.radiusMd),
                borderSide: const BorderSide(
                  color: AppColors.stateErrorFgColor,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.radiusMd),
                borderSide: const BorderSide(
                  color: AppColors.stateErrorFgColor,
                  width: 2,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.radiusMd),
                borderSide: const BorderSide(
                  color: AppColors.actionDisabledBorderColor,
                ),
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
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.fgMutedColor,
                  ),
                ),
                items: widget.options.map((option) {
                  return DropdownMenuItem<T>(
                    value: option.value,
                    child: Text(option.label, style: AppTypography.bodyMedium),
                  );
                }).toList(),
                onChanged: widget.state == AppSelectState.disabled
                    ? null
                    : widget.onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getLabelColor() {
    switch (widget.state) {
      case AppSelectState.error:
        return AppColors.fgSecondaryColor;
      case AppSelectState.disabled:
        return AppColors.fgDisabledColor;
      case AppSelectState.default_:
        return AppColors.fgSecondaryColor;
    }
  }

  Color _getFillColor() {
    switch (widget.state) {
      case AppSelectState.disabled:
        return AppColors.actionDisabledBgColor;
      case AppSelectState.error:
        return AppColors.bgSurfaceColor;
      case AppSelectState.default_:
        return AppColors.bgSurfaceColor;
    }
  }

  Color _getBorderColor() {
    switch (widget.state) {
      case AppSelectState.error:
        return AppColors.stateErrorFgColor;
      case AppSelectState.disabled:
        return AppColors.actionDisabledBorderColor;
      case AppSelectState.default_:
        return AppColors.borderDefaultColor;
    }
  }
}

/// An option in an [AppSelect] dropdown.
class AppSelectOption<T> {
  final T value;
  final String label;

  const AppSelectOption({required this.value, required this.label});
}
