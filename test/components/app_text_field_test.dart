import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shipit_ui/src/components/app_text_field.dart';
import 'package:shipit_ui/src/theme/app_theme_tokens.dart';

void main() {
  group('AppTextField', () {
    testWidgets('normal text field renders with label', (final tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTextField.normal(label: 'Name', hint: 'Enter your name'),
          ),
        ),
      );

      expect(find.text('Name'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('error text field shows error indicator', (final tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: AppTextField.error(label: 'Email')),
        ),
      );

      expect(find.text('Error: Please check this field'), findsOneWidget);
    });

    testWidgets('disabled text field is read-only', (final tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTextField.disabled(label: 'Status', value: 'Active'),
          ),
        ),
      );

      expect(find.text('Status'), findsOneWidget);
    });

    testWidgets('text field has textField semantics', (final tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: AppTextField.normal(label: 'Username')),
        ),
      );

      expect(find.byType(AppTextField), findsOneWidget);
    });

    testWidgets('text field with initial value', (final tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTextField.normal(label: 'Bio', initialValue: 'Hello'),
          ),
        ),
      );

      await tester.pump();
      expect(find.byType(TextField), findsOneWidget);
    });
  });

  group('AppTextField validation', () {
    const errorKey = Key('text_field_error');
    String? required(String? v) =>
        (v == null || v.isEmpty) ? 'Email is required' : null;

    InputDecoration decorationOf(WidgetTester tester) =>
        tester.widget<TextField>(find.byType(TextField)).decoration!;

    testWidgets('errorText renders a custom message in error styling', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTextField.normal(
              label: 'Email',
              errorText: 'An account already exists for this email address',
            ),
          ),
        ),
      );

      expect(
        find.text('An account already exists for this email address'),
        findsOneWidget,
      );
      expect(find.text('Error: Please check this field'), findsNothing);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
      final border = decorationOf(tester).enabledBorder! as OutlineInputBorder;
      expect(border.borderSide.color, AppTheme.light.color.state.error.fg);
    });

    testWidgets('error variant keeps default message when errorText is null', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: AppTextField.error(label: 'Email')),
        ),
      );
      expect(find.text('Error: Please check this field'), findsOneWidget);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTextField.error(label: 'Email', errorText: 'Too short'),
          ),
        ),
      );
      expect(find.text('Too short'), findsOneWidget);
      expect(find.text('Error: Please check this field'), findsNothing);
    });

    testWidgets('validator runs on Form.validate and shows its message', (
      tester,
    ) async {
      final formKey = GlobalKey<FormState>();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: AppTextField.normal(label: 'Email', validator: required),
            ),
          ),
        ),
      );

      expect(find.byKey(errorKey), findsNothing);
      expect(formKey.currentState!.validate(), isFalse);
      await tester.pump();

      expect(find.text('Email is required'), findsOneWidget);
      final border = decorationOf(tester).enabledBorder! as OutlineInputBorder;
      expect(border.borderSide.color, AppTheme.light.color.state.error.fg);

      await tester.enterText(find.byType(TextField), 'a@b.co');
      expect(formKey.currentState!.validate(), isTrue);
      await tester.pump();
      expect(find.byKey(errorKey), findsNothing);
    });

    testWidgets('autovalidateMode.onUserInteraction validates while typing', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              child: AppTextField.normal(
                label: 'Password',
                validator: (v) => (v ?? '').length < 12
                    ? 'Password must be at least 12 characters'
                    : null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
            ),
          ),
        ),
      );

      expect(find.byKey(errorKey), findsNothing);
      await tester.enterText(find.byType(TextField), 'short');
      await tester.pump();
      expect(
        find.text('Password must be at least 12 characters'),
        findsOneWidget,
      );

      await tester.enterText(find.byType(TextField), 'long-enough-secret');
      await tester.pump();
      expect(find.byKey(errorKey), findsNothing);
    });

    testWidgets('programmatic controller changes reach the validator', (
      tester,
    ) async {
      final formKey = GlobalKey<FormState>();
      final controller = TextEditingController();
      addTearDown(controller.dispose);
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: AppTextField.normal(
                label: 'Email',
                controller: controller,
                validator: required,
              ),
            ),
          ),
        ),
      );

      controller.text = 'a@b.co';
      await tester.pump();
      expect(formKey.currentState!.validate(), isTrue);
    });

    testWidgets('onSaved receives the value on Form.save', (tester) async {
      final formKey = GlobalKey<FormState>();
      String? saved;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: AppTextField.normal(
                label: 'Name',
                onSaved: (v) => saved = v,
              ),
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'Ada');
      formKey.currentState!.save();
      expect(saved, 'Ada');
    });

    testWidgets('explicit errorText wins over validator message', (
      tester,
    ) async {
      final formKey = GlobalKey<FormState>();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: AppTextField.normal(
                label: 'Email',
                validator: required,
                errorText: 'Server says no',
              ),
            ),
          ),
        ),
      );
      formKey.currentState!.validate();
      await tester.pump();
      expect(find.text('Server says no'), findsOneWidget);
      expect(find.text('Email is required'), findsNothing);
    });
  });
}
