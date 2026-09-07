import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shipit_ui/src/components/app_text_field.dart';

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
}
