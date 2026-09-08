import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:shipit_ui/src/components/app_select.dart';
import 'package:shipit_ui/src/foundation/app_colors.dart';

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

  group('AppSelect validation', () {
    const options = [
      AppSelectOption(value: 'a', label: 'Alpha'),
      AppSelectOption(value: 'b', label: 'Beta'),
    ];
    String? required(String? v) => v == null ? 'Pick one' : null;

    OutlineInputBorder enabledBorder(WidgetTester tester) =>
        tester
                .widget<InputDecorator>(find.byType(InputDecorator))
                .decoration
                .enabledBorder!
            as OutlineInputBorder;

    testWidgets('errorText renders custom message in error styling', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppSelect<String>(
              label: 'Role',
              options: options,
              errorText: 'Role is no longer available',
              onChanged: (_) {},
            ),
          ),
        ),
      );
      expect(find.text('Role is no longer available'), findsOneWidget);
      expect(
        enabledBorder(tester).borderSide.color,
        AppColors.stateErrorFgColor,
      );
    });

    testWidgets('validator runs on Form.validate and clears on selection', (
      tester,
    ) async {
      final formKey = GlobalKey<FormState>();
      String? selected;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) => Form(
                key: formKey,
                child: AppSelect<String>(
                  label: 'Role',
                  options: options,
                  value: selected,
                  validator: required,
                  onChanged: (v) => setState(() => selected = v),
                ),
              ),
            ),
          ),
        ),
      );

      expect(formKey.currentState!.validate(), isFalse);
      await tester.pump();
      expect(find.text('Pick one'), findsOneWidget);

      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Beta').last);
      await tester.pumpAndSettle();

      expect(formKey.currentState!.validate(), isTrue);
      await tester.pump();
      expect(find.byKey(const Key('select_error')), findsNothing);
    });

    testWidgets('onUserInteraction autovalidates after a change', (
      tester,
    ) async {
      String? selected = 'a';
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) => Form(
                child: AppSelect<String>(
                  label: 'Role',
                  options: options,
                  value: selected,
                  validator: (v) => v == 'b' ? 'Beta is retired' : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (v) => setState(() => selected = v),
                ),
              ),
            ),
          ),
        ),
      );
      expect(find.byKey(const Key('select_error')), findsNothing);

      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Beta').last);
      await tester.pumpAndSettle();

      expect(find.text('Beta is retired'), findsOneWidget);
    });

    testWidgets('onSaved receives the current value', (tester) async {
      final formKey = GlobalKey<FormState>();
      String? saved;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: AppSelect<String>(
                label: 'Role',
                options: options,
                value: 'a',
                onSaved: (v) => saved = v,
                onChanged: (_) {},
              ),
            ),
          ),
        ),
      );
      formKey.currentState!.save();
      expect(saved, 'a');
    });
  });
}
