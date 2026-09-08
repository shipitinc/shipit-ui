import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:shipit_ui/src/components/app_date_picker.dart';

AppDatePreset _preset(String label, DateTime start, DateTime end) =>
    AppDatePreset(label: label, resolve: (_) => AppDateRange(start, end));

final _today = _preset('Today', DateTime(2026, 3, 14), DateTime(2026, 3, 14));
final _yesterday = _preset(
  'Yesterday',
  DateTime(2026, 3, 13),
  DateTime(2026, 3, 13),
);
final _week = _preset(
  'Last 7 days',
  DateTime(2026, 3, 8),
  DateTime(2026, 3, 14),
);
final _month = _preset('This month', DateTime(2026, 3), DateTime(2026, 3, 31));

Widget _surface(Widget child) => MaterialApp(
  home: Scaffold(
    body: Padding(
      key: const Key('golden_root'),
      padding: const EdgeInsets.all(16),
      child: child,
    ),
  ),
);

void main() {
  group('Golden tests - AppDatePicker', () {
    testGoldens('single with value and presets', (tester) async {
      await tester.pumpWidgetBuilder(
        _surface(
          AppDatePicker(
            label: 'Due date',
            value: DateTime(2026, 3, 14),
            presets: [_today, _yesterday],
            onChanged: (_) {},
          ),
        ),
        surfaceSize: const Size(400, 300),
      );
      await expectLater(
        find.byKey(const Key('golden_root')),
        matchesGoldenFile('date_picker_single.png'),
      );
    });

    testGoldens('range with selected preset', (tester) async {
      await tester.pumpWidgetBuilder(
        _surface(
          AppDatePicker(
            label: 'Reporting period',
            mode: AppDatePickerMode.range,
            rangeValue: AppDateRange(
              DateTime(2026, 3, 8),
              DateTime(2026, 3, 14),
            ),
            presets: [_today, _week, _month],
            onRangeChanged: (_) {},
          ),
        ),
        surfaceSize: const Size(400, 300),
      );
      await expectLater(
        find.byKey(const Key('golden_root')),
        matchesGoldenFile('date_picker_range.png'),
      );
    });

    testGoldens('states: empty, error, disabled', (tester) async {
      await tester.pumpWidgetBuilder(
        _surface(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppDatePicker(label: 'Start date', onChanged: (_) {}),
              const SizedBox(height: 16),
              AppDatePicker(
                label: 'End date',
                isError: true,
                errorText: 'End date is required',
                onChanged: (_) {},
              ),
              const SizedBox(height: 16),
              AppDatePicker(
                label: 'Locked date',
                value: DateTime(2026, 3, 14),
                isDisabled: true,
                onChanged: (_) {},
              ),
            ],
          ),
        ),
        surfaceSize: const Size(400, 300),
      );
      await expectLater(
        find.byKey(const Key('golden_root')),
        matchesGoldenFile('date_picker_states.png'),
      );
    });
  });
}
