import 'package:flutter/material.dart';
import 'package:shipit_ui/src/foundation/app_colors.dart';
import 'package:shipit_ui/src/foundation/app_spacing.dart';
import 'package:shipit_ui/src/foundation/app_radius.dart';
import 'package:shipit_ui/src/foundation/app_typography.dart';

/// A reusable select/dropdown widget following the shipit_ui design system.
///
/// ## Semantics
///
/// Uses [Semantics] with `dropdown` and `label` for accessibility automation.
///
/// ## Provisional
///
/// Visual values are provisional until approved Penpot tokens are adopted.
class AppSelect<T> extends StatefulWidget {
  final String label;
  final List<AppSelectOption<T>> options;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final String? hint;
  final bool isDisabled;
  final Widget? prefixIcon;
  final Key? semanticLabel;

  const AppSelect({
    super.key,
    required this.label,
    required this.options,
    this.value,
    this.onChanged,
    this.hint,
    this.isDisabled = false,
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
            style: AppTypography.labelMedium.copyWith(
              color: widget.isDisabled
                  ? AppColors.textDisabled
                  : AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.spacingXs),
          InputDecorator(
            decoration: InputDecoration(
              hintText: widget.hint ?? 'Select ${widget.label.toLowerCase()}',
              prefixIcon: widget.prefixIcon,
              filled: true,
              fillColor: widget.isDisabled
                  ? AppColors.neutral100
                  : AppColors.neutral50,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.spacingMd,
                vertical: AppSpacing.spacingSm,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.radiusMd),
                borderSide: const BorderSide(color: AppColors.divider),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.radiusMd),
                borderSide: const BorderSide(color: AppColors.divider),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.radiusMd),
                borderSide: const BorderSide(
                  color: AppColors.actionPrimary,
                  width: 2,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.radiusMd),
                borderSide: const BorderSide(color: AppColors.neutral200),
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
                    color: AppColors.textSecondary,
                  ),
                ),
                items: widget.options.map((option) {
                  return DropdownMenuItem<T>(
                    value: option.value,
                    child: Text(option.label, style: AppTypography.bodyMedium),
                  );
                }).toList(),
                onChanged: widget.isDisabled ? null : widget.onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// An option in an [AppSelect] dropdown.
class AppSelectOption<T> {
  final T value;
  final String label;

  const AppSelectOption({required this.value, required this.label});
}
