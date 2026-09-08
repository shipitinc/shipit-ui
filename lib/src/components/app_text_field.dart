import 'package:flutter/material.dart';
import 'package:shipit_ui/src/foundation/app_colors.dart';
import 'package:shipit_ui/src/foundation/app_spacing.dart';
import 'package:shipit_ui/src/foundation/app_radius.dart';
import 'package:shipit_ui/src/foundation/app_typography.dart';

/// Text field state types for AppTextField.
enum AppTextFieldState { default_, error, disabled }

/// A reusable text field widget following the shipit_ui design system.
///
/// Supports default, error, and disabled states.
/// Based on approved Penpot design tokens.
///
/// ## Semantics
///
/// Uses [Semantics] with `textField: true` and `label` for
/// accessibility automation.
class AppTextField extends StatefulWidget {
  final String label;
  final String? hint;
  final String? initialValue;
  final AppTextFieldState state;
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
    this.state = AppTextFieldState.default_,
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
      state: AppTextFieldState.error,
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
      state: AppTextFieldState.disabled,
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
          const SizedBox(height: AppSpacing.space1),
          TextField(
            key: widget.semanticLabel,
            controller: _controller,
            focusNode: _focusNode,
            enabled: widget.state != AppTextFieldState.disabled,
            readOnly:
                widget.isReadOnly || widget.state == AppTextFieldState.disabled,
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
                  color: widget.state == AppTextFieldState.error
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
          ),
          if (widget.state == AppTextFieldState.error)
            Padding(
              padding: const EdgeInsets.only(top: AppSpacing.space1),
              child: Text(
                'Error: Please check this field',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.stateErrorFgColor,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Color _getLabelColor() {
    switch (widget.state) {
      case AppTextFieldState.error:
        return AppColors.fgSecondaryColor;
      case AppTextFieldState.disabled:
        return AppColors.fgDisabledColor;
      case AppTextFieldState.default_:
        return AppColors.fgSecondaryColor;
    }
  }

  Color _getFillColor() {
    switch (widget.state) {
      case AppTextFieldState.disabled:
        return AppColors.actionDisabledBgColor;
      case AppTextFieldState.error:
        return AppColors.bgSurfaceColor;
      case AppTextFieldState.default_:
        return AppColors.bgSurfaceColor;
    }
  }

  Color _getBorderColor() {
    switch (widget.state) {
      case AppTextFieldState.error:
        return AppColors.stateErrorFgColor;
      case AppTextFieldState.disabled:
        return AppColors.actionDisabledBorderColor;
      case AppTextFieldState.default_:
        return AppColors.borderDefaultColor;
    }
  }

  Widget? _buildSuffixIcon() {
    if (widget.state == AppTextFieldState.error && widget.suffixIcon == null) {
      return const Icon(
        Icons.error_outline,
        color: AppColors.stateErrorFgColor,
        size: 20,
      );
    }
    return widget.suffixIcon;
  }
}
