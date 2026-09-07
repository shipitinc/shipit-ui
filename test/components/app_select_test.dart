import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:shipit_ui/src/components/app_select.dart';

void main() {
  group('AppSelect', () {
    testWidgets('select renders with label and options', (final tester) async {
      final options = [
        const AppSelectOption<String>(value: 'a', label: 'Option A'),
        const AppSelectOption<String>(value: 'b', label: 'Option B'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppSelect<String>(
              label: 'Category',
              options: options,
              value: 'a',
              onChanged: (value) {},
            ),
          ),
        ),
      );

      expect(find.text('Category'), findsOneWidget);
      expect(find.text('Option A'), findsOneWidget);
    });

    testWidgets('select renders with label', (final tester) async {
      final options = [
        const AppSelectOption<String>(value: 'a', label: 'Option A'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppSelect<String>(
              label: 'Status',
              options: options,
              onChanged: (final value) {},
            ),
          ),
        ),
      );

      expect(find.text('Status'), findsOneWidget);
    });

    testWidgets('disabled select does not call onChanged', (
      final tester,
    ) async {
      final options = [
        const AppSelectOption<String>(value: 'a', label: 'Option A'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppSelect<String>(
              label: 'Locked',
              options: options,
              state: AppSelectState.disabled,
              value: 'a',
              onChanged: (final value) {},
            ),
          ),
        ),
      );

      expect(find.text('Locked'), findsOneWidget);
    });

    testWidgets('select with hint renders', (final tester) async {
      final options = [
        const AppSelectOption<String>(value: 'a', label: 'Option A'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppSelect<String>(
              label: 'Select',
              options: options,
              hint: 'Choose one',
              onChanged: (final value) {},
            ),
          ),
        ),
      );

      expect(find.text('Select'), findsOneWidget);
    });

    testWidgets('error select renders', (final tester) async {
      final options = [
        const AppSelectOption<String>(value: 'a', label: 'Option A'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppSelect<String>(
              label: 'Error Select',
              options: options,
              state: AppSelectState.error,
              onChanged: (final value) {},
            ),
          ),
        ),
      );

      expect(find.text('Error Select'), findsOneWidget);
    });
  });
}