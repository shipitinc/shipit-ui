import 'package:flutter/material.dart';
import 'package:shipit_ui/src/foundation/app_colors.dart';
import 'package:shipit_ui/src/foundation/app_spacing.dart';
import 'package:shipit_ui/src/foundation/app_radius.dart';
import 'package:shipit_ui/src/foundation/app_typography.dart';

/// Text field state types for AppTextField.
enum AppTextFieldState { default_, error, disabled }

/// A reusable text field widget following the shipit_ui design system.
///
/// Supports default, error, and disabled states. Participates in an enclosing
/// [Form]: [validator] runs on `Form.validate()` / `FormState.save()` and,
/// according to [autovalidateMode], while the user types. A failing
/// validator (or an explicit [errorText]) switches the field into the error
/// visual state and shows the message beneath the input.
///
/// Based on approved Penpot design tokens.
///
/// ## Semantics
///
/// Uses [Semantics] with `textField: true` and `label` for
/// accessibility automation. The active error message is exposed through
/// the `validationResult`/live-region of the error text.
class AppTextField extends StatefulWidget {
  final String label;
  final String? hint;
  final String? initialValue;
  final AppTextFieldState state;

  /// Explicit error message. When non-null the field renders in the error
  /// state with this text. Takes precedence over a validator message.
  final String? errorText;

  /// When to run [validator] automatically; defaults to
  /// [AutovalidateMode.disabled] (validate on `Form.validate()` only).
  final AutovalidateMode autovalidateMode;

  /// Called by `FormState.save()` with the current value.
  final FormFieldSetter<String>? onSaved;
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
    this.errorText,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.onSaved,
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
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    FormFieldSetter<String>? onSaved,
    String? errorText,
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
      autovalidateMode: autovalidateMode,
      onSaved: onSaved,
      errorText: errorText,
      onChanged: onChanged,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      semanticLabel: semanticLabel,
    );
  }

  factory AppTextField.error({
    required String label,
    String? hint,
    String? errorText,
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
      errorText: errorText,
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
  final GlobalKey<FormFieldState<String>> _fieldKey = GlobalKey();
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);
    _controller.addListener(_syncFormField);
    _focusNode = widget.focusNode ?? FocusNode();
  }

  void _syncFormField() {
    final field = _fieldKey.currentState;
    if (field != null && field.value != _controller.text) {
      field.didChange(_controller.text);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_syncFormField);
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  static const String defaultErrorMessage = 'Error: Please check this field';

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      key: _fieldKey,
      initialValue: _controller.text,
      validator: widget.validator,
      onSaved: widget.onSaved,
      autovalidateMode: widget.autovalidateMode,
      enabled: widget.state != AppTextFieldState.disabled,
      builder: (field) {
        final String? errorText =
            widget.errorText ??
            field.errorText ??
            (widget.state == AppTextFieldState.error
                ? defaultErrorMessage
                : null);
        final bool isError = errorText != null;
        return Semantics(
          textField: true,
          label: widget.label,
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
              TextField(
                key: widget.semanticLabel,
                controller: _controller,
                focusNode: _focusNode,
                enabled: widget.state != AppTextFieldState.disabled,
                readOnly:
                    widget.isReadOnly ||
                    widget.state == AppTextFieldState.disabled,
                obscureText: widget.obscureText,
                keyboardType: widget.keyboardType,
                maxLines: widget.maxLines,
                onChanged: widget.onChanged,
                onEditingComplete: widget.onEditingComplete,
                decoration: InputDecoration(
                  hintText: widget.hint,
                  prefixIcon: widget.prefixIcon,
                  suffixIcon: _buildSuffixIcon(isError),
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
              ),
              if (isError)
                Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.space1),
                  child: Semantics(
                    liveRegion: true,
                    child: Text(
                      errorText,
                      key: const Key('text_field_error'),
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

  Color _getBorderColor(bool isError) {
    if (widget.state == AppTextFieldState.disabled) {
      return AppColors.actionDisabledBorderColor;
    }
    return isError ? AppColors.stateErrorFgColor : AppColors.borderDefaultColor;
  }

  Widget? _buildSuffixIcon(bool isError) {
    if (isError && widget.suffixIcon == null) {
      return const Icon(
        Icons.error_outline,
        color: AppColors.stateErrorFgColor,
        size: 20,
      );
    }
    return widget.suffixIcon;
  }
}
