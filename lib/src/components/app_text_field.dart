import 'package:flutter/material.dart';
import 'package:shipit_ui/src/theme/app_theme_tokens.dart';

/// Text field state types for AppTextField.
enum AppTextFieldState { base, error, disabled }

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
    this.state = AppTextFieldState.base,
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
        final color = context.color;
        final space = context.space;
        return Semantics(
          textField: true,
          label: widget.label,
          container: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.label,
                style: context.text.label.medium.copyWith(
                  color: _getLabelColor(color),
                ),
              ),
              SizedBox(height: space.s1),
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
                  suffixIcon: _buildSuffixIcon(context, isError),
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
              ),
              if (isError)
                Padding(
                  padding: EdgeInsets.only(top: space.s1),
                  child: Semantics(
                    liveRegion: true,
                    child: Text(
                      errorText,
                      key: const Key('text_field_error'),
                      style: context.text.body.small.copyWith(
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
    switch (widget.state) {
      case AppTextFieldState.error:
        return color.fg.secondary;
      case AppTextFieldState.disabled:
        return color.fg.disabled;
      case AppTextFieldState.base:
        return color.fg.secondary;
    }
  }

  Color _getFillColor(AppColorTokens color) {
    switch (widget.state) {
      case AppTextFieldState.disabled:
        return color.action.disabled.bg;
      case AppTextFieldState.error:
        return color.bg.surface;
      case AppTextFieldState.base:
        return color.bg.surface;
    }
  }

  Color _getBorderColor(AppColorTokens color, bool isError) {
    if (widget.state == AppTextFieldState.disabled) {
      return color.action.disabled.border;
    }
    return isError ? color.state.error.fg : color.border.base;
  }

  Widget? _buildSuffixIcon(BuildContext context, bool isError) {
    if (isError && widget.suffixIcon == null) {
      return Icon(
        Icons.error_outline,
        color: context.color.state.error.fg,
        size: 20,
      );
    }
    return widget.suffixIcon;
  }
}
