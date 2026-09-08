import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shipit_ui/src/components/app_date_picker.dart';

Widget _wrap(Widget child) => MaterialApp(
  home: Scaffold(
    body: Padding(padding: const EdgeInsets.all(16), child: child),
  ),
);

final _fixedPreset = AppDatePreset(
  label: 'Fixed',
  resolve: (_) => AppDateRange(DateTime(2026, 3), DateTime(2026, 3, 7)),
);

void main() {
  group('AppDatePicker', () {
    test('defaultFormat zero-pads year, month and day', () {
      expect(AppDatePicker.defaultFormat(DateTime(2026, 3, 4)), '2026-03-04');
      expect(AppDatePicker.defaultFormat(DateTime(999, 12, 25)), '0999-12-25');
    });

    test('AppDateRange equality', () {
      final a = AppDateRange(DateTime(2026), DateTime(2026, 1, 2));
      final b = AppDateRange(DateTime(2026), DateTime(2026, 1, 2));
      expect(a, equals(b));
      expect(a.hashCode, b.hashCode);
      expect(a.toString(), contains('AppDateRange'));
    });

    test('AppDatePreset.today resolves to start of today..today', () {
      final now = DateTime(2026, 3, 14, 15, 30);
      final r = AppDatePreset.today.resolve(now);
      expect(r.start, DateTime(2026, 3, 14));
      expect(r.end, DateTime(2026, 3, 14));
      expect(AppDatePreset.defaults.length, 4);
      expect(AppDatePreset.last7Days.resolve(now).start, DateTime(2026, 3, 8));
      expect(AppDatePreset.thisMonth.resolve(now).end, DateTime(2026, 3, 31));
    });

    testWidgets('shows default hint when no value', (tester) async {
      await tester.pumpWidget(
        _wrap(AppDatePicker(label: 'Date', onChanged: (_) {})),
      );
      expect(find.text('Date'), findsOneWidget);
      expect(find.text('Select date'), findsOneWidget);
      expect(find.byKey(const Key('date_picker_clear')), findsNothing);
    });

    testWidgets('shows range hint when no range value', (tester) async {
      await tester.pumpWidget(
        _wrap(
          AppDatePicker(
            label: 'Dates',
            mode: AppDatePickerMode.range,
            onRangeChanged: (_) {},
          ),
        ),
      );
      expect(find.text('Select dates'), findsOneWidget);
    });

    testWidgets('shows formatted single value', (tester) async {
      await tester.pumpWidget(
        _wrap(
          AppDatePicker(
            label: 'Date',
            value: DateTime(2026, 3, 14),
            onChanged: (_) {},
          ),
        ),
      );
      expect(find.text('2026-03-14'), findsOneWidget);
    });

    testWidgets('shows formatted range value with en dash', (tester) async {
      await tester.pumpWidget(
        _wrap(
          AppDatePicker(
            label: 'Dates',
            mode: AppDatePickerMode.range,
            rangeValue: AppDateRange(DateTime(2026, 3), DateTime(2026, 3, 7)),
            onRangeChanged: (_) {},
          ),
        ),
      );
      expect(find.text('2026-03-01 – 2026-03-07'), findsOneWidget);
    });

    testWidgets('clear button calls onChanged with null', (tester) async {
      DateTime? received = DateTime(2000);
      var called = false;
      await tester.pumpWidget(
        _wrap(
          AppDatePicker(
            label: 'Date',
            value: DateTime(2026, 3, 14),
            onChanged: (v) {
              called = true;
              received = v;
            },
          ),
        ),
      );
      await tester.tap(find.byKey(const Key('date_picker_clear')));
      expect(called, isTrue);
      expect(received, isNull);
    });

    testWidgets('allowClear false hides clear button', (tester) async {
      await tester.pumpWidget(
        _wrap(
          AppDatePicker(
            label: 'Date',
            value: DateTime(2026, 3, 14),
            allowClear: false,
            onChanged: (_) {},
          ),
        ),
      );
      expect(find.byKey(const Key('date_picker_clear')), findsNothing);
    });

    testWidgets('disabled does not open picker on tap', (tester) async {
      await tester.pumpWidget(
        _wrap(
          AppDatePicker(
            label: 'Date',
            value: DateTime(2026, 3, 14),
            isDisabled: true,
            onChanged: (_) {},
          ),
        ),
      );
      expect(find.byKey(const Key('date_picker_clear')), findsNothing);
      await tester.tap(find.byKey(const Key('date_picker_field')));
      await tester.pumpAndSettle();
      expect(find.byType(DatePickerDialog), findsNothing);
    });

    testWidgets(
      'tap opens DatePickerDialog and selecting a day calls onChanged',
      (tester) async {
        DateTime? received;
        await tester.pumpWidget(
          _wrap(
            AppDatePicker(
              label: 'Date',
              value: DateTime(2026, 3, 14),
              firstDate: DateTime(2020),
              lastDate: DateTime(2030),
              onChanged: (v) => received = v,
            ),
          ),
        );
        await tester.tap(find.byKey(const Key('date_picker_field')));
        await tester.pumpAndSettle();
        expect(find.byType(DatePickerDialog), findsOneWidget);
        await tester.tap(find.text('15'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('OK'));
        await tester.pumpAndSettle();
        expect(received, DateTime(2026, 3, 15));
        expect(find.byType(DatePickerDialog), findsNothing);
      },
    );

    testWidgets('range mode opens DateRangePickerDialog', (tester) async {
      await tester.pumpWidget(
        _wrap(
          AppDatePicker(
            label: 'Dates',
            mode: AppDatePickerMode.range,
            firstDate: DateTime(2020),
            lastDate: DateTime(2030),
            rangeValue: AppDateRange(DateTime(2026, 3), DateTime(2026, 3, 7)),
            onRangeChanged: (_) {},
          ),
        ),
      );
      await tester.tap(find.byKey(const Key('date_picker_field')));
      await tester.pumpAndSettle();
      expect(find.byType(DateRangePickerDialog), findsOneWidget);
    });

    testWidgets('preset tap in range mode calls onRangeChanged', (
      tester,
    ) async {
      AppDateRange? received;
      await tester.pumpWidget(
        _wrap(
          AppDatePicker(
            label: 'Dates',
            mode: AppDatePickerMode.range,
            presets: [_fixedPreset],
            onRangeChanged: (v) => received = v,
          ),
        ),
      );
      await tester.tap(find.byKey(const Key('date_picker_preset_0')));
      expect(received, AppDateRange(DateTime(2026, 3), DateTime(2026, 3, 7)));
    });

    testWidgets('preset tap in single mode calls onChanged with start', (
      tester,
    ) async {
      DateTime? received;
      await tester.pumpWidget(
        _wrap(
          AppDatePicker(
            label: 'Date',
            presets: [_fixedPreset],
            onChanged: (v) => received = v,
          ),
        ),
      );
      await tester.tap(find.byKey(const Key('date_picker_preset_0')));
      expect(received, DateTime(2026, 3));
    });

    testWidgets('preset shows selected when range value matches', (
      tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          AppDatePicker(
            label: 'Dates',
            mode: AppDatePickerMode.range,
            rangeValue: AppDateRange(DateTime(2026, 3), DateTime(2026, 3, 7)),
            presets: [_fixedPreset, AppDatePreset.today],
            onRangeChanged: (_) {},
          ),
        ),
      );
      final chip = find.byKey(const Key('date_picker_preset_0'));
      expect(tester.getSemantics(chip), isSemantics(isSelected: true));
      final other = find.byKey(const Key('date_picker_preset_1'));
      expect(tester.getSemantics(other), isSemantics(isSelected: false));
    });

    testWidgets('disabled presets do not call callbacks', (tester) async {
      var called = false;
      await tester.pumpWidget(
        _wrap(
          AppDatePicker(
            label: 'Date',
            isDisabled: true,
            presets: [_fixedPreset],
            onChanged: (_) => called = true,
          ),
        ),
      );
      await tester.tap(find.byKey(const Key('date_picker_preset_0')));
      expect(called, isFalse);
    });

    testWidgets('error text renders', (tester) async {
      await tester.pumpWidget(
        _wrap(
          AppDatePicker(
            label: 'Date',
            isError: true,
            errorText: 'Date is required',
            onChanged: (_) {},
          ),
        ),
      );
      expect(find.text('Date is required'), findsOneWidget);
    });

    testWidgets('exposes semantics label and value', (tester) async {
      const key = Key('due_date');
      await tester.pumpWidget(
        _wrap(
          AppDatePicker(
            label: 'Due date',
            value: DateTime(2026, 3, 14),
            semanticLabel: key,
            onChanged: (_) {},
          ),
        ),
      );
      expect(find.byKey(key), findsOneWidget);
      expect(
        tester.getSemantics(find.byKey(key)),
        isSemantics(label: 'Due date', value: '2026-03-14', isButton: true),
      );
    });
  });

  group('AppDatePicker validation', () {
    final march14 = DateTime(2026, 3, 14);

    testWidgets('validator runs on Form.validate and shows the message', (
      tester,
    ) async {
      final formKey = GlobalKey<FormState>();
      await tester.pumpWidget(
        _wrap(
          Form(
            key: formKey,
            child: AppDatePicker(
              label: 'Start date',
              validator: (d) => d == null ? 'Start date is required' : null,
              onChanged: (_) {},
            ),
          ),
        ),
      );
      expect(formKey.currentState!.validate(), isFalse);
      await tester.pump();
      expect(find.text('Start date is required'), findsOneWidget);
      expect(find.byKey(const Key('date_picker_error')), findsOneWidget);
    });

    testWidgets('validator passes once a value is provided', (tester) async {
      final formKey = GlobalKey<FormState>();
      await tester.pumpWidget(
        _wrap(
          Form(
            key: formKey,
            child: AppDatePicker(
              label: 'Start date',
              value: march14,
              validator: (d) => d == null ? 'Required' : null,
              onChanged: (_) {},
            ),
          ),
        ),
      );
      expect(formKey.currentState!.validate(), isTrue);
    });

    testWidgets('rangeValidator is used in range mode', (tester) async {
      final formKey = GlobalKey<FormState>();
      await tester.pumpWidget(
        _wrap(
          Form(
            key: formKey,
            child: AppDatePicker(
              label: 'Program dates',
              mode: AppDatePickerMode.range,
              rangeValue: AppDateRange(march14, march14),
              rangeValidator: (r) => r != null && r.start == r.end
                  ? 'Pick at least two days'
                  : null,
              validator: (_) => 'should not run',
              onRangeChanged: (_) {},
            ),
          ),
        ),
      );
      expect(formKey.currentState!.validate(), isFalse);
      await tester.pump();
      expect(find.text('Pick at least two days'), findsOneWidget);
      expect(find.text('should not run'), findsNothing);
    });

    testWidgets('errorText shows without isError and wins over validator', (
      tester,
    ) async {
      final formKey = GlobalKey<FormState>();
      await tester.pumpWidget(
        _wrap(
          Form(
            key: formKey,
            child: AppDatePicker(
              label: 'Start date',
              errorText: 'Date is in the past',
              validator: (_) => 'validator message',
              onChanged: (_) {},
            ),
          ),
        ),
      );
      expect(find.text('Date is in the past'), findsOneWidget);
      formKey.currentState!.validate();
      await tester.pump();
      expect(find.text('validator message'), findsNothing);
    });

    testWidgets('preset tap marks interaction for onUserInteraction', (
      tester,
    ) async {
      final preset = AppDatePreset(
        label: 'Fixed',
        resolve: (_) => AppDateRange(march14, march14),
      );
      await tester.pumpWidget(
        _wrap(
          Form(
            child: AppDatePicker(
              label: 'Start date',
              presets: [preset],
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (_) => 'Always invalid',
              onChanged: (_) {},
            ),
          ),
        ),
      );
      expect(find.byKey(const Key('date_picker_error')), findsNothing);
      await tester.tap(find.byKey(const Key('date_picker_preset_0')));
      await tester.pump();
      expect(find.text('Always invalid'), findsOneWidget);
    });
  });
}
