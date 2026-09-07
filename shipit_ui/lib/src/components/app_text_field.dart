import 'package:flutter/material.dart';
import 'package:shipit_ui/src/foundation/app_colors.dart';
import 'package:shipit_ui/src/foundation/app_spacing.dart';
import 'package:shipit_ui/src/foundation/app_radius.dart';
import 'package:shipit_ui/src/foundation/app_typography.dart';

/// Text field variant types for AppTextField.
enum AppTextFieldVariant { normal, error, disabled }

/// A reusable text field widget following the shipit_ui design system.
///
/// Supports normal, error, and disabled states.
///
/// ## Semantics
///
/// Uses [Semantics] with `textField: true` and `label` for
/// accessibility automation.
///
/// ## Provisional
///
/// Visual values are provisional until approved Penpot tokens are adopted.
class AppTextField extends StatefulWidget {
  final String label;
  final String? hint;
  final String? initialValue;
  final AppTextFieldVariant variant;
  final bool isReadOnly;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final bool obscureText;
  final TextInputType? keyboardType;
  final int? maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Key? semanticLabel;

  const AppTextField({
    super.key,
    required this.label,
    this.hint,
    this.initialValue,
    this.variant = AppTextFieldVariant.normal,
    this.isReadOnly = false,
    this.controller,
    this.focusNode,
    this.validator,
    this.onChanged,
    this.onEditingComplete,
    this.obscureText = false,
    this.keyboardType,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
    this.semanticLabel,
  });

  factory AppTextField.normal({
    required String label,
    String? hint,
    String? initialValue,
    TextEditingController? controller,
    FocusNode? focusNode,
    String? Function(String?)? validator,
    ValueChanged<String>? onChanged,
    Widget? prefixIcon,
    Widget? suffixIcon,
    Key? semanticLabel,
  }) {
    return AppTextField(
      key: semanticLabel,
      label: label,
      hint: hint,
      initialValue: initialValue,
      controller: controller,
      focusNode: focusNode,
      validator: validator,
      onChanged: onChanged,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      semanticLabel: semanticLabel,
    );
  }

  factory AppTextField.error({
    required String label,
    String? hint,
    TextEditingController? controller,
    FocusNode? focusNode,
    ValueChanged<String>? onChanged,
    Widget? suffixIcon,
    Key? semanticLabel,
  }) {
    return AppTextField(
      key: semanticLabel,
      label: label,
      hint: hint,
      variant: AppTextFieldVariant.error,
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      suffixIcon: suffixIcon,
      semanticLabel: semanticLabel,
    );
  }

  factory AppTextField.disabled({
    required String label,
    String? hint,
    String? value,
    Key? semanticLabel,
  }) {
    return AppTextField(
      key: semanticLabel,
      label: label,
      hint: hint,
      variant: AppTextFieldVariant.disabled,
      isReadOnly: true,
      initialValue: value,
      semanticLabel: semanticLabel,
    );
  }

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      textField: true,
      label: widget.label,
      container: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: AppTypography.labelMedium.copyWith(color: _getLabelColor()),
          ),
          const SizedBox(height: AppSpacing.spacingXs),
          TextField(
            key: widget.semanticLabel,
            controller: _controller,
            focusNode: _focusNode,
            enabled: widget.variant != AppTextFieldVariant.disabled,
            readOnly:
                widget.isReadOnly ||
                widget.variant == AppTextFieldVariant.disabled,
            obscureText: widget.obscureText,
            keyboardType: widget.keyboardType,
            maxLines: widget.maxLines,
            onChanged: widget.onChanged,
            onEditingComplete: widget.onEditingComplete,
            decoration: InputDecoration(
              hintText: widget.hint,
              prefixIcon: widget.prefixIcon,
              suffixIcon: _buildSuffixIcon(),
              filled: true,
              fillColor: _getFillColor(),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.spacingMd,
                vertical: AppSpacing.spacingSm,
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
                  color: widget.variant == AppTextFieldVariant.error
                      ? AppColors.stateError
                      : AppColors.actionPrimary,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.radiusMd),
                borderSide: const BorderSide(color: AppColors.stateError),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.radiusMd),
                borderSide: const BorderSide(
                  color: AppColors.stateError,
                  width: 2,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.radiusMd),
                borderSide: const BorderSide(color: AppColors.neutral200),
              ),
            ),
          ),
          if (widget.variant == AppTextFieldVariant.error)
            Padding(
              padding: const EdgeInsets.only(top: AppSpacing.spacingXs),
              child: Text(
                'Error: Please check this field',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.stateError,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Color _getLabelColor() {
    switch (widget.variant) {
      case AppTextFieldVariant.error:
        return AppColors.stateError;
      case AppTextFieldVariant.disabled:
        return AppColors.textDisabled;
      case AppTextFieldVariant.normal:
        return AppColors.textPrimary;
    }
  }

  Color _getFillColor() {
    switch (widget.variant) {
      case AppTextFieldVariant.disabled:
        return AppColors.neutral100;
      case AppTextFieldVariant.error:
        return AppColors.neutral50;
      case AppTextFieldVariant.normal:
        return AppColors.neutral50;
    }
  }

  Color _getBorderColor() {
    switch (widget.variant) {
      case AppTextFieldVariant.error:
        return AppColors.stateError;
      case AppTextFieldVariant.disabled:
        return AppColors.neutral200;
      case AppTextFieldVariant.normal:
        return AppColors.divider;
    }
  }

  Widget? _buildSuffixIcon() {
    if (widget.variant == AppTextFieldVariant.error &&
        widget.suffixIcon == null) {
      return const Icon(
        Icons.error_outline,
        color: AppColors.stateError,
        size: 20,
      );
    }
    return widget.suffixIcon;
  }
}
